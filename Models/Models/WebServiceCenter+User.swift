//
//  WebServiceCenter.swift
//  Models
//
//  Created by Tung Vo  on 21/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation
import BDFClientApi
import CoreLocation

extension BDFAuthenticatedUser {
    ///
    /// Helper method to exceute WebServicesFailureBlock
    ///
    func executeBlock(block: BDFServiceCenterFailureBlock?, task: NSURLSessionDataTask?, error: NSError?) {
        if let _block = block{
            _block((task?.response as? NSHTTPURLResponse)?.statusCode, error)
        }
    }
    
    ///
    /// Helper method to exceute BDFServiceCenterExtendedFailureBlock
    ///
    func executeExtendedBlock(block: BDFServiceCenterExtendedFailureBlock?, task: NSURLSessionDataTask?, error: NSError?) {
        if let _block = block{
            var errorCode: Int?
            
            do {
                // Check error body
                if let data = error?.userInfo[BDFNetworkingOperationFailingURLResponseDataErrorKey] as? NSData {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    if let response = json as? NSDictionary {
                        // Check error code
                        if let error = response["error_code"] as? NSNumber {
                            errorCode = error.integerValue
                        }
                    }
                }
            }
            catch {
                
            }
            
            _block((task?.response as? NSHTTPURLResponse)?.statusCode, errorCode, error)
        }
    }
}

//MARK: User services
extension BDFAuthenticatedUser {
    ///
    /// Get nearby users
    ///
    public func getNearByUsers(minAge: Int, maxAge: Int, radius: Int, coordinate: CLLocationCoordinate2D?, gender: BDFUserGender, nextPageString: String?, successBlock: (([User], String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        var genderString: String
        if gender == .Male {
            genderString = "male"
        }
        else if gender == .Female {
            genderString = "female"
        }
        else {
            genderString = "both"
        }
        
        _userServices.getNearByUsers(minAge, maxAge: maxAge, radius: radius, longitude: coordinate?.longitude, latitude: coordinate?.latitude, gender: genderString, nextPageString: nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Get array of users
            if let dictionary = object as? NSDictionary {
                if let dictionaries = dictionary["items"] as? [NSDictionary] {
                    let users = BDFOtherUser.usersFromDictionaries(dictionaries)
                    let next = dictionary["next"] as? String
                    successBlock?(users, next)
                    return
                }
            }
            
            successBlock?([BDFOtherUser](), nil)
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Log out
    ///
    public func logOut(deviceToken: String?, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.logOut(deviceToken, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            successBlock?()
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Update user information
    ///
    public func updateUserInformation(name name: String?, username: String?, birthdate: NSDate?, bio: String?, gender: BDFUserGender?, profileImage: UIImage?, progressBlock: WebServicesProgresssBlock?, successBlock: ((User?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        // Convert date to string
        var dateString: String?
        if let _birthdate = birthdate {
            dateString = self.stringFromDate(_birthdate)
        }
        
        var genderString: String?
        // Convert gender
        if gender != nil {
            if gender == .Male {
                genderString = "male"
            }
            else {
                genderString = "female"
            }
        }
        
        _userServices.updateUserInformation(name: name, username: username, birthdate: dateString, bio: bio, gender: genderString, profileImage: profileImage, progressBlock: progressBlock, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            if let dictionary = object as? NSDictionary {
                let user = BDFAuthenticatedUser(dictionary: dictionary)
                self.updateInformation(user)
                successBlock?(user)
                return
            }
            
            successBlock?(nil)
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Update user location
    ///
    public func updateUserLocation(longitude: Double, latitude: Double, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.updateUserLocation(longitude, latitude: latitude, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get user information
    ///
    public func getUserInformationWithUserId(userId: Int64, successBlock: ((User -> Void))?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.getUserInformationWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //Return user
            if let dictionary = object as? NSDictionary {
                let user = BDFOtherUser(dictionary: dictionary)
                successBlock?(user)
            }
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get my information
    ///
    public func getCurrentUserInformation(successBlock successBlock: ((User -> Void))?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.getCurrentUserInformation(successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //Return user
            if let dictionary = object as? NSDictionary {
                let user = BDFAuthenticatedUser(dictionary: dictionary)
                self.updateInformation(user)
                successBlock?(user)
            }
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Search users
    /// Successs block takes array of users and next page url string
    ///
    public func searchUserWithName(name: String, nextPageString: String?, successBlock: (([User]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.searchUserWithName(name, nextPageString: nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //Return array of users
            if let dictionary = object as? NSDictionary {
                if let dictionaries = dictionary["items"] as? [NSDictionary] {
                    let users = BDFOtherUser.usersFromDictionaries(dictionaries)
                    let next = dictionary["next"] as? String
                    successBlock?(users, next)
                    return
                }
            }
            
            successBlock?(nil, nil)
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Update password
    ///
    public func updatePasswordWithOldPassword(oldPassword: String, newPassword: String, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.updatePasswordWithOldPassword(oldPassword, newPassword: newPassword, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get user notifications
    /// Successs block takes array of users and next page url string
    ///
    public func getCurrentUserNotifications(nextPageString nextPageString: String?, successBlock: (([Notification]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.getCurrentUserNotifications(nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            if let dictionary = object as? NSDictionary {
                print(dictionary)
                if let items = dictionary["items"] as? [NSDictionary] {
                    let notifications = BDFNotification.notificationsFromDictionaries(items)
                    let next = dictionary["next"] as? String
                    successBlock?(notifications, next)
                    return
                }
            }
            successBlock?(nil, nil)
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Mark notification seen
    ///
    public func markNotificationSeen(notificationId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.markNotificationSeen(notificationId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
            
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Send friend request
    ///
    public func sendFriendRequetsToUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.sendFriendRequetsToUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Cancel my own friend request
    ///
    public func cancelMyFriendRequestToUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.cancelMyFriendRequestToUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Accept friend request
    ///
    public func acceptFriendRequestFromUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.acceptFriendRequestFromUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Delete friend request
    ///
    public func deleteFriendRequestFromUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        
        _userServices.deleteFriendRequestFromUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Unfriend
    ///
    public func unfriendUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.unfriendUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Block user
    ///
    public func blockUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.blockUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Unblock user
    ///
    public func unblockUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.unblockUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
        
    }
    
    ///
    /// Report user
    ///
    public func reportUserWithUserId(userId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.reportUserWithUserId(userId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        })  { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
        
    }
    
    ///
    /// Register APNS Token
    ///
    public func registerAPNSToken(token: String, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.registerAPNSToken(token, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Unregister APNS Token
    ///
    public func unregisterAPNSToken(token: String, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _userServices.unregisterAPNSToken(token, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            // Execute success block
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            //Execute failure block
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
}
