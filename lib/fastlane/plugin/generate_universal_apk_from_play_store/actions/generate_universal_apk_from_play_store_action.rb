require 'fastlane/action'
require_relative '../helper/generate_universal_apk_from_play_store_helper'

module Fastlane
  module Actions
    class GenerateUniversalApkFromPlayStoreAction < Action
      def self.run(params)
        UI.message("The generate_universal_apk_from_play_store plugin is working!")
      end

      def self.description
        "Generate universal apk from Playstore"
      end

      def self.authors
        ["Bình Phạm"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Generate universal apk from Playstore"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "GENERATE_UNIVERSAL_APK_FROM_PLAY_STORE_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
