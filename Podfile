# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!
target 'SwiftDelivery' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  

  # Pods for SwiftDelivery
   pod 'Alamofire', '~> 5.0.0-beta.3'
   pod 'MBProgressHUD', '~> 1.1.0'
   pod 'SDWebImage', '~> 4.0'
   pod 'SwiftLint', '~> 0.31.0'
   pod 'Firebase/Core'
   pod 'Fabric', '~> 1.9.0'
   pod 'Crashlytics', '~> 3.12.0'
   pod 'NotificationBannerSwift'
   
   
   post_install do |installer|
     installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '5.0'
       end
     end
   end

  target 'SwiftDeliveryTests' do
    inherit! :search_paths
    pod 'OHHTTPStubs/Swift', '~> 7.0.0'
    # Pods for testing
  end

end
