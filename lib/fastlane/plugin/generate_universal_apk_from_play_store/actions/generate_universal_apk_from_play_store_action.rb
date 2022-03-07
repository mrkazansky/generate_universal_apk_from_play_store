require 'googleauth'
require 'net/http'  
require 'fastlane/action'
require_relative '../helper/generate_universal_apk_from_play_store_helper'

module Fastlane
  module Actions
    class GenerateUniversalApkFromPlayStoreAction < Action
      def self.run(params)
        scope = 'https://www.googleapis.com/auth/androidpublisher'

        authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open(params[:key_file]),
          scope: scope)

        token = authorizer.fetch_access_token["access_token"]
      
        listing_param = { :access_token => token}
        listingUri = URI("https://androidpublisher.googleapis.com/androidpublisher/v3/applications/#{params[:package_name]}/generatedApks/#{params[:version_code]}")
        listingUri.query = URI.encode_www_form(listing_param)

        res = Net::HTTP.get_response(listingUri).body
        apkListing = JSON.parse(res)
        downloadId = apkListing["generatedApks"][0]["generatedUniversalApk"]["downloadId"]
        UI.message("Download ID: #{downloadId}")

        download_param = { :alt => "media"}
        downloadUri = URI("https://androidpublisher.googleapis.com/androidpublisher/v3/applications/#{params[:package_name]}/generatedApks/#{params[:version_code]}/downloads/#{downloadId}:download")
        downloadUri.query = URI.encode_www_form(download_param)

        Net::HTTP.start(downloadUri.host, downloadUri.port, :use_ssl => downloadUri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new downloadUri.request_uri
          request['Authorization'] = "Bearer #{token} "
          http.request request do |response|
            open "fastlane/#{params[:version_code]}.apk", 'wb' do |io|
              response.read_body do |chunk|
                io.write chunk
              end
            end
          end
        end

        UI.message("The generate_universal_apk_from_play_store plugin is working!")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key_file,
                                       env_name: 'KEY_FILE',
                                       description: 'Json config file',
                                       type: String,
                                       default_value: 'fastlane/keyfile.json',
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find config keyfile at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :package_name,
                                       env_name: 'PACKAGE_NAME',
                                       description: 'Package name to download',
                                       optional: false,
                                       type: String,
                                       verify_block: proc do |value|
                                         UI.user_error!("No package name given") unless value and !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :version_code,
                                       env_name: 'VERSION_CODE',
                                       description: 'Version code to download',
                                       optional: false,
                                       type: String,
                                       verify_block: proc do |value|
                                         UI.user_error!("No version code given") unless value and !value.empty?
                                       end)                                       
        ]
      end

      def self.description
        "Generate universal apk from Playstore"
      end

      def self.authors
        ["Bình Phạm"]
      end

      def self.return_value
        
      end

      def self.details
        "Generate universal apk from Playstore"
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
