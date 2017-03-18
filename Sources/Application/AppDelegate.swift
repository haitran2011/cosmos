//
//  AppDelegate.swift
//  cosmos
//
//  Created by Tue Nguyen on 4/13/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//
//self.navigationController.navigationBar.tintColor = [GSTATE scoreBoardColor];
//self.navigationController.navigationBar.barTintColor = FlatYellow;
//self.view.backgroundColor = FlatWhite;
//[self.navigationController.navigationBar setTitleTextAttributes:
//@{NSForegroundColorAttributeName:[GSTATE scoreBoardColor]}];
import UIKit
import Fabric
import Crashlytics
import Firebase
import GoogleMobileAds
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static func shareDelegate() -> AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!;
    }
    var window: UIWindow?
    var pushNotificationManager = PushNotificationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        LoggerSetup()
        self.setupTabbar()
        self.setupService()
        Fabric.with([Crashlytics.self])
        FIRApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-8322212054190086~5872723852")
        // Override point for customization after application launch.
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
        return true
    }
    func setupTabbar() -> Void {
        UINavigationBar.appearance().barTintColor = ColorSchema.navibarColor()
        //UINavigationBar.appearance().tintColor = ColorSchema.navibarColor()
        UITabBar.appearance().tintColor = ColorSchema.navibarColor()
        UITabBar.appearance().barTintColor = ColorSchema.appTheme()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName: UIFont.systemFont(ofSize: 11)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName: UIFont.systemFont(ofSize: 11)], for: .normal)
    }
    func setupService() -> Void {
        APIClient.setCurrentClient(APIClient(baseURLString: Constant.ServiceURL))
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if SettingManager.currentSetting().enableRotateScreen{
            return .allButUpsideDown
        }else {
            return .portrait
        }
    }
}

