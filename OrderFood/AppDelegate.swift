//
//  AppDelegate.swift
//  OrderFood
//
//  Created by MehulS on 04/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

//mobapp.at.foodandbeverage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var arrayCart = [Cart]()
    var arrayCategory = [Category]()
    var strQRCodeValue: String = ""
    var isCategoryClassObserverAdded: Bool = false
    var isNeedToShowVegItemsOnly: Bool = false
    var isAnyChangeInCart: Bool = false
    var guid: String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Crashlytics
        Fabric.with([Crashlytics.self])
        
        //Push Notification
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            //Messaging.messaging().remoteMessageDelegate = self
            Messaging.messaging().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        //Get GUID if app have
        if let guid = UserDefaults.standard.value(forKey: "guid") as? String {
            self.guid = guid
        }
        
        FirebaseApp.configure()
                        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    //MARK: - Get Current View Controller
    func getCurrentViewController() -> UIViewController {
        //let vc = self.window?.rootViewController
        let navCTR = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        let vc = navCTR.visibleViewController
        return vc!
    }


}


//MARK: - Push Notification
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingDelegate) {
        print(remoteMessage)
    }
}

