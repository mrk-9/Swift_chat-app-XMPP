//
//  WebServiceCenter+Creation.swift
//  Models
//
//  Created by Tung Vo  on 21/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation
import BDFClientApi

//MARK: Creation services
extension BDFAuthenticatedUser {
    public func createNewPostWith(caption: String?, image: UIImage?, progressBlock: WebServicesProgresssBlock, successBlock: (Post -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentCreationServices.createNewPostWith(caption, image: image, progressBlock: progressBlock, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            if let dictionary = object as? NSDictionary {
                let post = BDFPost(dictionary: dictionary)
                successBlock?(post)
            }
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
                //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
}

extension BDFAuthenticatedUser {
    ///
    /// Log in with username & password
    /// Return logged in user, access token & refresh token
    ///
    public func logInWithUsername(username: String, password: String, progressBlock: WebServicesProgresssBlock?, successBlock: ((BDFAuthenticatedUser, String, String) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _tokenServices.logInWithUsername(username, password: password, progressBlock: progressBlock, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            if let dictionary = object as? NSDictionary {
                guard let user = dictionary["user"] as? NSDictionary, accessToken = dictionary["access_token"] as? String, refreshToken = dictionary["refresh_token"] as? String else {
                    return
                }
                
                let currentUser = BDFAuthenticatedUser(dictionary: user)
                // Update user info and tokens
                self.updateInformation(currentUser)
                self.updateAccessToken(accessToken, refreshToken: refreshToken)
                
                successBlock?(currentUser, accessToken, refreshToken)
            }
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Log in with Facebook
    /// Return logged in user & request credentials
    ///
    public func loginWithFacebook(facebookAccessToken: String, progressBlock: WebServicesProgresssBlock?, successBlock: ((BDFAuthenticatedUser, Bool) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _tokenServices.loginWithFacebook(facebookAccessToken, progressBlock: progressBlock, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            if let dictionary = object as? NSDictionary {
                guard let user = dictionary["user"] as? NSDictionary, accessToken = dictionary["access_token"] as? String, refreshToken = dictionary["refresh_token"] as? String, requestCredentials = dictionary["request_credentials"] as? NSNumber else {
                    return
                }
                
                let currentUser = BDFAuthenticatedUser(dictionary: user)
                // Update user info and tokens
                self.updateInformation(currentUser)
                self.updateAccessToken(accessToken, refreshToken: refreshToken)
                
                successBlock?(currentUser, requestCredentials.boolValue)
            }
            
        }){ (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Sign up with email
    ///
    public func signUpWithName(name: String, email: String, password: String, progressBlock: WebServicesProgresssBlock?, successBlock: ((BDFAuthenticatedUser, String, String) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _tokenServices.signUpWithName(name, email: email, password: password, progressBlock: progressBlock, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            if let dictionary = object as? NSDictionary {
                guard let user = dictionary["user"] as? NSDictionary, accessToken = dictionary["access_token"] as? String, refreshToken = dictionary["refresh_token"] as? String else {
                    return
                }
                
                let currentUser = BDFAuthenticatedUser(dictionary: user)
                // Update user info and tokens
                self.updateInformation(currentUser)
                self.updateAccessToken(accessToken, refreshToken: refreshToken)
                
                successBlock?(currentUser, accessToken, refreshToken)
            }
            
        }){ (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Reset password
    ///
}