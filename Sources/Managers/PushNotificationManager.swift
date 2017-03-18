//
//  PushNotificationManager.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/6/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import UIKit

class PushNotificationManager {
    
    func registerRemoteNotification() {
        let application = UIApplication.shared
        let notificationType: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let settings = UIUserNotificationSettings(types: notificationType, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
    }
    
    func disableRemoteNotification() {
        let application = UIApplication.shared
        let notificationType: UIUserNotificationType = UIUserNotificationType()
        let settings = UIUserNotificationSettings(types: notificationType, categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    
    func didRegisterForRemoteNotificationsWithDeviceToken(_ deviceToken: Data) {
        let tokenString = deviceToken.hexadecimalString()
        LogInfo("DeviceToken \(tokenString!)")
    }
    
    func didReceiveRemoteNotificationForState(_ state: UIApplicationState, userInfo: [AnyHashable: Any]!, whenAppLaunching: Bool = false) {
        LogInfo("AppState \(state) userInfo: \(userInfo.description) whenAppLaunching: \(whenAppLaunching)")
    }
}
