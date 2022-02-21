require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class GenerateUniversalApkFromPlayStoreHelper
      # class methods that you define here become available in your action
      # as `Helper::GenerateUniversalApkFromPlayStoreHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the generate_universal_apk_from_play_store plugin helper!")
      end
    end
  end
end
