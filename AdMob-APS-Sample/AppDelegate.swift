//
//  AppDelegate.swift
//  AdMob-APS-Sample
//
//  Created by ryokosuge on 2020/07/21.
//  Copyright © 2020 ryokosuge. All rights reserved.
//

import UIKit
import DTBiOSSDK
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // APSのAppIDを入れてください
    // test id
    let apsAppID: String = "b478e6a7750d4bcc8d4a4e53c04d6fab"

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DTBAds.sharedInstance().setAppKey(apsAppID)
        DTBAds.sharedInstance().setLogLevel(DTBLogLevelAll)
        DTBAds.sharedInstance().testMode = true
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

