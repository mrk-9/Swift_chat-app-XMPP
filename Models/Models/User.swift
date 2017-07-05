//
//  User.swift
//  Models
//
//  Created by Tung Vo  on 16/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation

///
/// Protocol User
///
@objc public protocol User {
    init(dictionary: NSDictionary)
    var userId: Int64 {get set}
    var age: Int {get}
    var userVisibility: BDFUserVisibility {get set}
    var photoThumbnails: [String]! {get set}
    var profilePhoto: String! {get}
    var gender: BDFUserGender {get}
    var name: String! {get}
    var distance: Int {get}
    var bio: String! {get}
    var friendStatus: BDFFriendStatus {get set}
    var jid: String! {get set}
    var birthdate: NSDate? {get set}
    
    func isIdentical(user: User) -> Bool
    func isAuthenticatedUser() -> Bool
    func updateInformation(user: User)
    func stringFromDate(date: NSDate) -> String
}

///
/// Enum user visibility (public/private)
///
@objc public enum BDFUserVisibility: Int {
    case Public = 0 //"public"
    case Private = 1 //"private"
}


///
/// Enum friend status
///
@objc public enum BDFFriendStatus: Int {
    case NotFriend = 0 // "not_friend"
    case Friend = 1 //"friend"
    case RequestSent = 2 //"friend_request_sent"
    case RequestReceived = 3 //"friend_request_received"
}

///
/// Enum BDFUserGender
///
@objc public enum BDFUserGender: Int {
    case Male = 0 // "male"
    case Female = 1 // "female"
    case Both = 2 // "both"
    case None = 3 // "None"
}

///
/// Class BDFUser
///
public class BDFOtherUser: NSObject, User {
    required public init(dictionary: NSDictionary) {
        super.init()
        
        // User id
        if let value = dictionary["user_id"] as? NSNumber {
            self.userId = value.longLongValue
        }
        
        // User id
        if let value = dictionary["jid"] as? String {
            self.jid = value
        }
        
        // Fullname
        if let value = dictionary["full_name"] as? String {
            name = value
        }
        else {
            name = ""
        }
        
        // Profile url
        if let value = dictionary["url"] as? String {
            profilePhoto = value
        }
        else {
            profilePhoto = ""
        }
        
        // Bio
        if let value = dictionary["desc"] as? String {
            bio = value
        }
        else {
            bio = ""
        }
        
        // Thumbnails
        if let value = dictionary["thumbnails"] as? NSDictionary {
            var array: [String]?
            
            for (_, string) in value {
                if let str = string as? String {
                    if array == nil {
                        array = [String]()
                    }
                    array!.append(str)
                }
            }
            
            photoThumbnails = array
        }
        
        // Birthdate
        if let value = dictionary["date_of_birth"] as? String {
            if let date = Helper.dateFormatter.dateFromString(value) {
                birthdate = date
                
                // Update age after getting date of birth
                _age = Helper.calculateAge(date)
            }
        }
        
        // Friend status
        if let value = dictionary["friend_status"] as? String {
            if value == "not_friend" {
                friendStatus = .NotFriend
            }
            else if value == "friend" {
                friendStatus = .Friend
            }
            else if value == "friend_request_sent" {
                friendStatus = .RequestSent
            }
            else if value == "friend_request_received" {
                friendStatus = .RequestReceived
            }
            else {
                friendStatus = .NotFriend
            }
        }
        
        // User visibility
        if let value = dictionary["user_visibility"] as? String {
            if value == "public" {
                userVisibility = .Public
            }
            else if value == "private" {
                userVisibility = .Private
            }
        }
        
        // Distance
        if let value = dictionary["distance_away"] as? String {
            distance = Int(Double(value) ?? 0)
        }
        else {
            distance = 0
        }
        
        // Gender
        if let value = dictionary["gender"] as? String {
            if value == "male" {
                gender = .Male
            }
            else if value == "female" {
                gender = .Female
            }
            else {
                gender = .None
            }
        }
        else {
            gender = .None
        }
    }
    
    ///
    /// Create array of BDFOtherUser
    ///
    class func usersFromDictionaries(dictionaries: [NSDictionary]) -> [BDFOtherUser] {
        var array = [BDFOtherUser]()
        
        for dict in dictionaries {
            let user = BDFOtherUser(dictionary: dict)
            array.append(user)
        }
        
        return array
    }
    
    ///
    /// User id
    ///
    public var userId: Int64 = 0
    
    ///
    /// User's bio
    ///
    public private(set) var bio: String! = ""
    
    ///
    /// User's birthdate.
    /// Birthdate format: YYYY/MM/dd
    ///
    public dynamic var birthdate: NSDate? {
        didSet {
            if let _birthdate = self.birthdate {
                _age = Helper.calculateAge(_birthdate)
            }
        }
    }
    
    ///
    /// User's age
    /// Default value 18
    ///
    private var _age: Int?
    public var age: Int {
        if _age == nil {
            if let _birthdate = self.birthdate {
                _age = Helper.calculateAge(_birthdate)
            }
            else {
                _age = 18
            }
        }
        
        return _age!
    }
    
    ///
    /// User's chat id
    ///
    public var jid: String!
    
    ///
    /// User visibility
    ///
    @objc public dynamic var userVisibility = BDFUserVisibility.Public
    
    ///
    /// Friend status with current authenticated user
    ///
    @objc public dynamic var friendStatus: BDFFriendStatus = .NotFriend
    
    ///
    /// User's distance in meters
    ///
    public private(set) var distance: Int = 0
    
    ///
    /// Profile photo thumbnails
    ///
    public var photoThumbnails: [String]! = []
    ///
    /// Profile photo
    ///
    public private(set) dynamic var profilePhoto: String! = ""
    ///
    /// Gender
    /// Male is 1
    /// Female is 2
    ///
    @objc public private(set) dynamic var gender: BDFUserGender = .None
    
    ///
    /// Name
    ///
    public private(set) dynamic var name: String! = ""
    
    //MARK: Methods
    
    ///
    /// Method for checking if two users are the same based on their userId.
    /// Use it method to check if user is current logged in user in most cases.
    ///
    public func isIdentical(user: User) -> Bool {
        return self.userId == user.userId
    }
    
    ///
    /// Method for checking if an user if authenticated user.
    ///
    public func isAuthenticatedUser() -> Bool {
        return userId != 0
    }
    
    ///
    /// Method for updating user info with new user info
    ///
    public func updateInformation(user: User) {
        self.userId = user.userId
        self.name = user.name
        self._age = user.age
        self.birthdate = user.birthdate
        self.gender = user.gender
        self.profilePhoto = user.profilePhoto
        self.photoThumbnails = user.photoThumbnails
        self.bio = user.bio
        self.userVisibility = user.userVisibility
        self.jid = user.jid
    }
    
    ///
    /// Custom description
    ///
    
    
    ///
    /// Method to convert birthdate to string
    ///
    public func stringFromDate(date: NSDate) -> String {
        return Helper.stringFromDate(date)
    }
}