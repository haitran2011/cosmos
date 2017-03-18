# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

def shared_pods
    pod 'ObjectMapper'
    pod 'Bolts-Swift'
    pod 'Alamofire', :git => 'https://github.com/tue-savvy/Alamofire.git', :branch => 'ios8'
    pod 'XCGLogger', '~> 4.0.0'
    pod 'SnapKit' #autolayout process library https://github.com/SnapKit/SnapKit
    #pod 'SwiftDate', :git => 'https://github.com/malcommac/SwiftDate.git', :branch => 'feature/swift-3.0' #date processing library https://github.com/malcommac/SwiftDate
    pod 'SwiftDate'
    pod 'Kingfisher'
    pod 'KeychainAccess' #Keychain access framework https://github.com/kishikawakatsumi/KeychainAccess
    pod 'DynamicColor' #manipulate color
    pod 'RealmSwift'
    pod 'Localize-Swift'
    #below is useful libraries that you may want to include in your project
    #pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
    #pod 'SQLite.swift' #https://github.com/stephencelis/SQLite.swift
    #pod 'MagicalRecord', '~> 2.3.2' #https://github.com/magicalpanda/MagicalRecord
    #pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift2'
    #pod 'RAMAnimatedTabBarController' #animated tabbar library https://github.com/Ramotion/animated-tab-bar
    #pod 'Material' #An animation and graphics framework for Material Design in Swift. https://github.com/CosmicMind/Material
    #pod 'SwiftSpinner' #a nice loading spinner
    #pod 'IQKeyboardManager'
    #pod 'MZFormSheetPresentationController'
    #pod 'DZNWebViewController'
    #pod 'INTULocationManager'
    #pod 'MMNumberKeyboard'
    #pod 'DZNEmptyDataSet' #https://github.com/dzenbot/DZNEmptyDataSet
    pod 'DisplaySwitcher'
    pod 'TBEmptyDataSet'
    pod 'MobilePlayer'
    pod 'PKHUD', '~> 4.0'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Firebase/Core'
    pod 'Firebase/AdMob'
    pod 'ActiveLabel'
end

target 'cosmos' do
    shared_pods
end

target 'cosmosTests' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
