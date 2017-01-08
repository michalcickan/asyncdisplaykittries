source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!



target 'AsyncDisplayKitMDevSpot' do
pod 'Alamofire'
pod 'AsyncDisplayKit', '~> 2.0'
pod 'ObjectMapper'

end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
end
end
end
