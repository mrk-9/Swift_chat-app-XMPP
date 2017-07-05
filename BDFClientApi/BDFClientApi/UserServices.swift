//
//  UserServices.swift
//  Buddify
//
//  Created by Vo Duc Tung on 12/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

///
/// This class is a client api for getting content related to users in the app.
///

public class UserServices: AuthenticatedServices {
    ///
    /// Log out
    ///
    public func logOut(deviceToken: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "logout")
        var parameters: NSDictionary?
        if let token = deviceToken {
            parameters = ["apns_device_token": token]
        }
        
        self.request(NetworkingMethod.POST, request: request, paramaters: parameters, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Update user information
    ///
    public func updateUserInformation(name name: String?, username: String?, birthdate: String?, bio: String?, gender: String?, profileImage: UIImage?, progressBlock: WebServicesProgresssBlock?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me")
        var parameters = [String: AnyObject]()
        
        if let _name = name {
            parameters["full_name"] = _name
        }
        
        if let _birthdate = birthdate {
            parameters["date_of_birth"] = _birthdate
        }
        
        if let _bio = bio {
            parameters["bio"] = _bio
        }
        
        if let _username = username {
            parameters["username"] = _username
        }
        
        if let _gender = gender {
            parameters["gender"] = _gender
        }
        
        if let image = profileImage {
            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                self.request(request, parameters: parameters, formDatas: [(imageData, "file", "profile_pic.png", "image/png")], progress: progressBlock, success: successBlock, failure: failureBlock)
                return
            }
        }
        
        self.request(request, parameters: parameters, formDatas: nil, progress: progressBlock, success: successBlock, failure: failureBlock)
    }
    
    ///
    /// Update user location
    ///
    public func updateUserLocation(longitude: Double, latitude: Double, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me")
        let parameters = ["location": "\(longitude),\(latitude)"]
        
        self.request(request, parameters: parameters, formDatas: nil, progress: nil, success: successBlock, failure: failureBlock)
    }
    
    ///
    /// Get user information
    ///
    public func getUserInformationWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/\(userId)")
        self.request(NetworkingMethod.GET, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get my information
    ///
    public func getCurrentUserInformation(successBlock successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me")
        self.request(NetworkingMethod.GET, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Search users
    ///
    public func searchUserWithName(name: String, nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users")
        self.request(NetworkingMethod.GET, request: request, paramaters: ["full_name" : name], progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get discovery users
    ///
    public func getNearByUsers(minAge: Int, maxAge: Int, radius: Int, longitude: Double?, latitude: Double?, gender: String, nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "users/explore") : self.requestWithCustomURLString(nextPageString!)
        var parameters = [
            "age_gt": String(minAge),
            "age_lt": String(maxAge),
            "distance_lt": String(radius),
            "gender": gender
        ]
        
        if let long = longitude, let lat = latitude {
            parameters["location"] = "\(long),\(lat)"
        }
        
        self.request(NetworkingMethod.GET, request: request, paramaters: parameters, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Update password
    ///
    public func updatePasswordWithOldPassword(oldPassword: String, newPassword: String, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me/password") //?old_password=\(oldPassword)&new_password=\(newPassword)&new_password_check=\(newPassword)
        
        let parameters: NSDictionary = [
            "old_password": oldPassword,
            "new_password": newPassword,
            "new_password_check": newPassword
        ]
    
        self.request(NetworkingMethod.PUT, request: request, paramaters: parameters, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get user notifications
    ///
    public func getCurrentUserNotifications(nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "users/me/notifications") : self.requestWithCustomURLString(nextPageString!)
        self.request(NetworkingMethod.GET, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Mark notification seen
    ///
    public func markNotificationSeen(notificationId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me/notifications/\(notificationId)")
        self.request(NetworkingMethod.PUT, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Send friend request
    ///
    public func sendFriendRequetsToUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/\(userId)/friends")
        self.request(NetworkingMethod.POST, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    
    ///
    /// Accept friend request
    ///
    public func acceptFriendRequestFromUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me/friends/\(userId)")
        self.request(NetworkingMethod.POST, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Delete friend request
    ///
    public func deleteFriendRequestFromUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me/friends/\(userId)")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Cancel my own friend request
    ///
    public func cancelMyFriendRequestToUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me/friends/\(userId)")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Unfriend
    ///
    public func unfriendUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/\(userId)/friends")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Block user
    ///
    public func blockUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/\(userId)/block")
        self.request(NetworkingMethod.POST, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Unblock user
    ///
    public func unblockUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/\(userId)/block")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Report user
    ///
    public func reportUserWithUserId(userId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/\(userId)/flag")
        self.request(NetworkingMethod.POST, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Register APNS Token
    ///
    public func registerAPNSToken(token: String, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me/pns")
        self.request(NetworkingMethod.POST, request: request, paramaters: ["apns_device_token": token], progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Unregister APNS Token
    ///
    public func unregisterAPNSToken(token: String, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users/me/pns")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
}
