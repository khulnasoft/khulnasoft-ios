Pod::Spec.new do |s|
  s.name             = "KhulnaSoft"
  s.version          = "3.17.0"
  s.summary          = "The hassle-free way to add khulnasoft to your iOS app."

  s.description      = <<-DESC
                       KhulnaSoft for iOS provides a single API that lets you
                       integrate with over 100s of tools.
                       DESC

  s.homepage         = "http://khulnasoft.com/"
  s.license          =  { :type => 'MIT' }
  s.author           = { "KhulnaSoft" => "engineering@khulnasoft.com" }
  s.source           = { :git => "https://github.com/KhulnaSoft/khulnasoft-ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/KhulnaSoft'
  s.readme           = "https://raw.githubusercontent.com/KhulnaSoft/khulnasoft-ios/#{s.version.to_s}/README.md"
  s.changelog        = "https://raw.githubusercontent.com/KhulnaSoft/khulnasoft-ios/#{s.version.to_s}/CHANGELOG.md"

  s.ios.deployment_target = '13.0'
  s.tvos.deployment_target = '13.0'
  s.osx.deployment_target = "10.15"
  s.watchos.deployment_target = "6.0"
  s.visionos.deployment_target = "1.0"
  s.swift_versions = "5.3"

  s.frameworks = 'Foundation'

  s.source_files = [
    'KhulnaSoft/**/*.{swift,h,hpp,m,mm,c,cpp}'
  ]
  s.resource_bundles = { "KhulnaSoft" => "KhulnaSoft/Resources/PrivacyInfo.xcprivacy" }
end
