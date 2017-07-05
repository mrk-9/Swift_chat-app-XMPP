//
//  AuthenticatedUser.swift
//  Models
//
//  Created by Tung Vo  on 20/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation
import BDFClientApi

// status code, and error
public typealias BDFServiceCenterFailureBlock = ((Int?, NSError?) -> Void)

//status code, error code from backend and error
public typealias BDFServiceCenterExtendedFailureBlock = ((Int?, Int?, NSError?) -> Void)

private var userIdKey = "userIdKey"
private var nameKey = "nameKey"
private var usernameKey = "usernameKey"
private var ageKey = "ageKey"
private var jidKey = "jidKey"
private var genderKey = "genderKey"
private var profilePhotoKey = "profilePhotoKey"
private var profilePhotoThumbsKey = "profilePhotoThumbsKey"
private var visibilityKey = "visibilityKey"
private var bioKey = "bioKey"
private var accessTokenKey = "accessTokenKey"
private var refreshTokenKey = "refreshTokenKey"
private var birthdateKey = "birthdateKey"

private let buddifyAPIBaseURL = "http://52.58.15.245/api/"

///
/// Protocol AuthenticatedUser
///
@objc protocol AuthenticatedUser: User {
    var username: String! {get set}
}

///
/// Class BDFAuthenticatedUser
/// Represents current logged in user which is responsible for all the API calls.
///
public class BDFAuthenticatedUser: NSObject, AuthenticatedUser, NSCoding, NSCopying {
    ///
    /// Initializer with dictionary object from API calls
    ///
    required public init(dictionary: NSDictionary) {
        _baseURL = buddifyAPIBaseURL
        
        super.init()
        
        // User id
        if let value = dictionary["user_id"] as? NSNumber {
            self.userId = value.longLongValue
        }
        
        // Fullname
        if let value = dictionary["full_name"] as? String {
            name = value
        }
        
        // jid
        if let value = dictionary["jid"] as? String {
            jid = value
        }
        
        // Profile url
        if let value = dictionary["url"] as? String {
            profilePhoto = value
        }
        
        // Bio
        if let value = dictionary["desc"] as? String {
            bio = value
        }
        
        // Username
        if let value = dictionary["username"] as? String {
            username = value
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
            }
        }
        
        // Update age
        if let _birthdate = self.birthdate {
            _age = Helper.calculateAge(_birthdate)
        }
        
        // Friend status
        friendStatus = BDFFriendStatus.NotFriend
        
        // User visibility
        if let value = dictionary["user_visibility"] as? String {
            if value == "public" {
                userVisibility = .Public
            }
            else if value == "private" {
                userVisibility = .Private
            }
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
        
        // Observer tokens updated notification
        self.addTokensUpdatedNotification()
    }
    
    override public init() {
        _baseURL = buddifyAPIBaseURL
        super.init()
        
        // Observer tokens updated notification
        self.addTokensUpdatedNotification()
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init()
        userId = aDecoder.decodeInt64ForKey(userIdKey)
        name = aDecoder.decodeObjectForKey(nameKey) as? String ?? ""
        _age = aDecoder.decodeIntegerForKey(ageKey)
        gender = BDFUserGender(rawValue: aDecoder.decodeIntegerForKey(genderKey)) ?? BDFUserGender.None
        jid = aDecoder.decodeObjectForKey(jidKey) as? String ?? ""
        userVisibility = BDFUserVisibility(rawValue: aDecoder.decodeIntegerForKey(visibilityKey)) ?? BDFUserVisibility.Public
        profilePhoto = aDecoder.decodeObjectForKey(profilePhotoKey) as? String ?? ""
        photoThumbnails = aDecoder.decodeObjectForKey(profilePhotoThumbsKey) as? [String] ?? []
        _accessToken = aDecoder.decodeObjectForKey(accessTokenKey) as? String ?? ""
        _refreshToken = aDecoder.decodeObjectForKey(refreshTokenKey) as? String ?? ""
        username = aDecoder.decodeObjectForKey(usernameKey) as? String ?? ""
        birthdate = aDecoder.decodeObjectForKey(birthdateKey) as? NSDate
        
        _contentServices.updateAccessToken(_accessToken)
        _userServices.updateAccessToken(_accessToken)
        _contentCreationServices.updateAccessToken(_accessToken)
        
        _contentServices.updateRefreshToken(_refreshToken)
        _userServices.updateRefreshToken(_refreshToken)
        _contentCreationServices.updateRefreshToken(_refreshToken)
        _tokenServices.updateRefreshToken(_refreshToken)
        
        // Observer tokens updated notification
        self.addTokensUpdatedNotification()
    }
    
    deinit {
        self.removeTokensUpdatedNotification()
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt64(userId, forKey: userIdKey)
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeInteger(age, forKey: ageKey)
        aCoder.encodeInteger(gender.rawValue, forKey: genderKey)
        aCoder.encodeObject(profilePhoto, forKey: profilePhotoKey)              
        aCoder.encodeObject(photoThumbnails, forKey: profilePhotoThumbsKey)
        aCoder.encodeInteger(userVisibility.rawValue, forKey: visibilityKey)
        aCoder.encodeObject(bio, forKey: bioKey)
        aCoder.encodeObject(_accessToken, forKey: accessTokenKey)
        aCoder.encodeObject(_refreshToken, forKey: refreshTokenKey)
        aCoder.encodeObject(jid, forKey: jidKey)
        aCoder.encodeObject(username, forKey: usernameKey)
        aCoder.encodeObject(birthdate, forKey: birthdateKey)
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        let user = self.dynamicType.init(dictionary: NSDictionary())
        user.userId = self.userId
        user.name = self.name
        user._age = self.age
        user.gender = self.gender
        user.profilePhoto = self.profilePhoto
        user.photoThumbnails = self.photoThumbnails
        user.bio = self.bio
        user.userVisibility = self.userVisibility
        user._accessToken = self._accessToken
        user._refreshToken = self._refreshToken
        user.jid = self.jid
        user.username = self.username
        user.birthdate = self.birthdate
        
        return user
    }
    
    public override var description: String {
        return "userId = \(userId), username = \(username), name = \(name), age = \(_age), accessToken = \(_accessToken), refreshToken = \(_refreshToken) "
    }
    
    ///
    ///
    ///
    private func addTokensUpdatedNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handleTokensUpdated(_:)), name: WebServicesTokensUpdatedNotificationKey, object: nil)
    }
    
    private func removeTokensUpdatedNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: WebServicesTokensUpdatedNotificationKey, object: nil)
    }
    
    
    ///
    /// Handle tokens updated notifications
    ///
    func handleTokensUpdated(notification: NSNotification) {
        if let dictionary = notification.object as? NSDictionary {
            guard let accessToken = dictionary["access_token"] as? String else {
                return
            }
            
            guard let refreshToken = dictionary["refresh_token"] as? String else {
                return
            }
            
            self.updateAccessToken(accessToken, refreshToken: refreshToken)
        }
    }
    
    ///
    /// User id
    ///
    public var userId: Int64 = 0
    
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
    /// User's bio
    ///
    public private(set) dynamic var bio: String! = ""
    
    ///
    /// User's chat id
    ///
    public var jid: String!
    
    ///
    /// Profile photo thumbnails
    ///
    public dynamic var photoThumbnails: [String]! = []
    ///
    /// Distance
    ///
    public private(set) var distance: Int = 0
    
    ///
    /// User visibility
    ///
    public dynamic var userVisibility: BDFUserVisibility = BDFUserVisibility.Public
    
    ///
    /// Friend status with current authenticated user
    ///
    public var friendStatus: BDFFriendStatus = .NotFriend
    
    ///
    /// Profile photo
    ///
    public private(set) dynamic var profilePhoto: String! = ""
    
    ///
    /// Gender
    /// Male is 1
    /// Female is 2
    ///
    public private(set) dynamic var gender = BDFUserGender.None
    
    ///
    /// Name
    ///
    public private(set) dynamic var name: String! = ""
    
    ///
    /// Username
    ///
    public dynamic var username: String! = ""
    
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
    /// Services
    ///
    lazy var _contentServices: ContentServices! = ContentServices(baseURLString: self._baseURL)
    lazy var _userServices: UserServices! = UserServices(baseURLString: self._baseURL)
    lazy var _contentCreationServices: PostServices! = PostServices(baseURLString: self._baseURL)
    lazy var _tokenServices: TokenServices! = TokenServices(baseURLString: self._baseURL)
    
    ///
    /// Base URL
    ///
    private var _baseURL: String {
        didSet {
            fatalError("Cannot change base URL.")
        }
    }
    
    ///
    /// Copy value from an user.
    /// Use to update logged in user information
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
        
        if let authenticatedUser = user as? AuthenticatedUser {
            self.username = authenticatedUser.username
        }
    }
    
    ///
    /// Each user will have its own access token and refresh token.
    /// This will enable multiple logged in user.
    ///
    
    ///
    /// Access token
    ///
    private var _accessToken: String! {
        didSet {
            _contentServices.updateAccessToken(_accessToken)
            _userServices.updateAccessToken(_accessToken)
            _contentCreationServices.updateAccessToken(_accessToken)
        }
    }
    
    ///
    /// Refresh token
    ///
    private var _refreshToken: String! {
        didSet {
            _contentServices.updateRefreshToken(_refreshToken)
            _userServices.updateRefreshToken(_refreshToken)
            _contentCreationServices.updateRefreshToken(_refreshToken)
            _tokenServices.updateRefreshToken(_refreshToken)
        }
    }
    
    ///
    /// Update tokens
    ///
    internal func updateAccessToken(accessToken: String, refreshToken: String) {
        // Update the tokens
        _accessToken = accessToken
        _refreshToken = refreshToken
    }
    
    ///
    /// Method to convert birthdate to string
    ///
    public func stringFromDate(date: NSDate) -> String {
        return Helper.stringFromDate(date)
    }
}
