 //
//  AppDelegate.swift
//  Buddify
//
//  Created by Vo Duc Tung on 29/02/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import uservoice_iphone_sdk
import FBSDKCoreKit
import Fabric
import Crashlytics
import Models
import XMPPFramework
import KVNProgress
import AFNetworking
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //Crashlytics
        Fabric.with([Crashlytics.self])

        // Override point for customization after application launch.
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        AFNetworkActivityIndicatorManager.sharedManager().activationDelay = 0.001
        AFNetworkActivityIndicatorManager.sharedManager().completionDelay = 0.2
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
		UINavigationBar.appearance().setBackgroundImage(UIImage.image(UIColor.appPurpleColor()), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
		UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldAppFont(17)]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        let backButtonImage = UIImage.backIcon(size: CGSize(width: 30, height: 20), color: UIColor.whiteColor()).stretchableImageWithLeftCapWidth(20, topCapHeight: 20)
        
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backButtonImage, forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-100, -100), forBarMetrics: UIBarMetrics.Default)
        
        // Default configuration for KVNProgress
        KVNProgress.setDefaultConfiguration()
        
        // Swizzling all UIViewController's viewDidLoad method
        UIViewController.swizzleViewDidLoadMethod()
        
        // If Me object exists, go to app
        let user = BDFAuthenticatedUser.currentUser
        if user.isAuthenticatedUser() {
            // If user has everything setup
            if user.birthdate != nil || user.gender != BDFUserGender.None {
                let userTabbarController = UserTabbarController()
                let containerViewController = ContainerViewController(viewController: userTabbarController)
                window?.rootViewController = containerViewController
            }
            else {
                let profileEditViewController = ProfileEditViewController()
                let navigationController = UINavigationController(rootViewController: profileEditViewController)
                let containerViewController = ContainerViewController(viewController: navigationController)
                window?.rootViewController = containerViewController
            }
        }
        else {
            let viewController = OnboardingViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBarHidden = true
            navigationController.navigationBar.barStyle = .Black
            let containerViewController = ContainerViewController(viewController: navigationController)
            window?.rootViewController = containerViewController
        }
		
        
        // Set this up once when your application launches
        let config = UVConfig(site: "buddify.uservoice.com")
        config.showContactUs = false
        config.showKnowledgeBase = false
        config.forumId = 355575
        
        UserVoice.initialize(config)
        
        //Start Woobi
        Woobi.start()
        
        //Start NativeX
        NativeXSDK.initializeWithAppId(String.NativeXAppID(), andPublisherUserId: "57", andSDKDelegate: nil, andRewardDelegate: RewardManager.sharedInstance)
        
        // Chat client
        ChatClient.defaultClient.connect()
        
        return true
    }
    
    class func rootViewController() -> ContainerViewController? {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            if let viewController = appDelegate.window?.rootViewController as? ContainerViewController {
                return viewController
            }
        }
        return nil
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        BDFAuthenticatedUser.currentUser.save()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString: String = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        // Update user device token
        if BDFAuthenticatedUser.currentUser.isAuthenticatedUser() {
            BDFAuthenticatedUser.currentUser.registerAPNSToken(tokenString, successBlock: { 
                // Success
                // Only save device token on success
                BDFPushNotificationHelper.saveDeviceToken(tokenString)
                DTLog("Did register apns token \(tokenString)")
                }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    // Failure
                    DTLog("Did fail register apns token \(tokenString)")
            })
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register for remote notifications:", error)
        // Fail registering token
        BDFPushNotificationHelper.saveDeviceToken(nil)
    }
}