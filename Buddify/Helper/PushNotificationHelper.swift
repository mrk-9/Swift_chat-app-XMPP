//
//  PushNotificationHelper.swift
//  Buddify
//
//  Created by Admin on 14/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

private let notificationDeviceTokenKey = "push_notification_token_key" //
private let notificationPromptDidDeclineKey = "push_notification_prompt_decline_key" // User disable push notifications
private let notificationPromptDidEnableKey = "push_notification_prompt_enable_key" // User enables push notifications

private let markKey = "mark_key"

class BDFPushNotificationHelper {
    class func didEnablePushNotifications() -> Bool {
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(notificationPromptDidEnableKey) as? String {
            return true
        }
        
        return UIApplication.sharedApplication().isRegisteredForRemoteNotifications()
    }
    
    class func didDisablePushNotifications() -> Bool {
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(notificationPromptDidDeclineKey) as? String {
            return true
        }
        return false
    }
    
    class func didShowPushNotificationPrompt() -> Bool {
        // If user has enabled or declined push notification permission, it should be true.
        if BDFPushNotificationHelper.didEnablePushNotifications() {
            return true
        }
        else if BDFPushNotificationHelper.didDisablePushNotifications() {
            return true
        }
        
        return false
    }
    
    ///
    /// This method should be called when user logs out of the app.
    /// So next time you log into the app, new token will be set to new account.
    ///
    class func disconnectDeviceToken() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: notificationDeviceTokenKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /// 
    /// Save current device token.
    /// Give nil if user has declined permission.
    /// This should be called when delegate method for getting push device token is called on failure) and when
    /// current user has registered with this device token successfully. Because if registering fails, we should
    /// be able register again. 
    /// Should not used for other purposes.
    ///
    class func saveDeviceToken(deviceToken: String?) {
        if let token = deviceToken {
            self.setEnable()
            NSUserDefaults.standardUserDefaults().setObject(token, forKey: notificationDeviceTokenKey)
        }
        else {
            setDecline()
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    ///
    /// Use this method to ask for user's push notification permission.
    ///
    class func askForPushNotificationToken() {
        // If already prompt
        if BDFPushNotificationHelper.didShowPushNotificationPrompt() {
            // Check again if device token has not been saved, if not, we ask once more to get token.
            if deviceToken() != nil {
                return
            }
        }
        
        // Ask for notification permission
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound], categories: nil))
    }
    
    ///
    /// Get current device token.
    /// Returns nil if user declined push notification permission or has not granted permission.
    ///
    class func deviceToken() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey(notificationDeviceTokenKey) as? String
    }
    
    private class func setDecline() {
        NSUserDefaults.standardUserDefaults().setObject(markKey, forKey: notificationPromptDidDeclineKey)
    }
    
    private class func setEnable() {
        NSUserDefaults.standardUserDefaults().setObject(markKey, forKey: notificationPromptDidEnableKey)
    }
}