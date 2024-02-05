#
# Be sure to run `pod lib lint RainbowLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RainbowLabel'
  s.version          = '0.1'
  s.summary          = 'iOS label support rainbow color.'
  s.homepage         = 'https://github.com/Jerry/RainbowLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jerry' => 'jerry.qiushi@gmail.com' }
  s.source           = { :git => 'https://github.com/Jerry/RainbowLabel.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'RainbowLabel/Classes/**/*'
end
