//
//  FacebookSDKManager.swift
//  Buddify
//
//  Created by Vo Duc Tung on 15/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import FBSDKLoginKit

class FacebookUtility : NSObject {
    class func getFacebookInfo(viewController : UIViewController, handler : FBSDKLoginManagerRequestTokenHandler!) {
        let permissions = ["public_profile", "user_friends", "email"]
        
        // Open the session, prompting the user if necessary. This might send the application to the background
        let loginManager = FBSDKLoginManager()
        
        loginManager.logInWithReadPermissions(permissions, fromViewController: viewController, handler: handler)
    }
    
    class func requestFacebookPostPermission(viewController : UIViewController, handler : FBSDKLoginManagerRequestTokenHandler!) {
        let loginManager = FBSDKLoginManager()
        loginManager.logInWithReadPermissions(["publish_actions"], fromViewController: viewController, handler: handler)
    }
    
    
}