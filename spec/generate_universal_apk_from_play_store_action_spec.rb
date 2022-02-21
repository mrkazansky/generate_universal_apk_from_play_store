describe Fastlane::Actions::GenerateUniversalApkFromPlayStoreAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The generate_universal_apk_from_play_store plugin is working!")

      Fastlane::Actions::GenerateUniversalApkFromPlayStoreAction.run(nil)
    end
  end
end
