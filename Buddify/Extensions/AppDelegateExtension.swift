//
//  AppDelegate.swift
//  Buddify
//
//  Created by Vo Duc Tung on 12/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import FBSDKLoginKit

extension AppDelegate {
    class func logOut() {
        if let containerViewController = rootViewController() {
            FBSDKAccessToken.setCurrentAccessToken(nil)
            let viewController = OnboardingViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBarHidden = true
            navigationController.navigationBar.barStyle = .Black
            containerViewController.presentViewController(navigationController, completion: nil)
            
            // Disconnect device token
            BDFPushNotificationHelper.disconnectDeviceToken()
        }
    }
}