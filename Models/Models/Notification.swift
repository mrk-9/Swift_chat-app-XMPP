//
//  Notification.swift
//  Models
//
//  Created by Tung Vo  on 16/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation

///
/// Protocol Notification
///
@objc public protocol Notification: class, NSObjectProtocol {
    init(dictionary: NSDictionary)
    var notificationId: Int64 {get}
    var createdAt: NSDate! {get}
    var user: User! {get}
    var action: BDFNotificationAction {get}
    var message: String! {get}
    var highlights: [BDFHighlight]? {get}
    var seen: Bool {get}
    
    // Post should be nullable becasue not all notifications have post
    var post: Post? {get}
    
    // Comment(nullable)
    var comment: Comment? {get}
}

///
/// Struct BDFHighLightRange
///
public struct BDFHighLightRange {
    var indexStart: Int
    var indexEnd: Int
    
    init(start: Int, end: Int) {
        indexStart = start
        indexEnd = end
    }
}

///
/// Enum BDFNotificationHighlight
///
@objc public class BDFHighlight: NSObject {
    var range: BDFHighLightRange!
    var type: BDFHighlightType!
    
    required public init?(dictionary: NSDictionary) {
        guard let start = dictionary["index_start"] as? NSNumber, end = dictionary["index_end"] as? NSNumber else {
            return nil
        }
        
        super.init()
        range = BDFHighLightRange(start: start.integerValue, end: end.integerValue)
    }
    
    static func highlightsFromDictionary(dictionary: NSDictionary) -> [BDFHighlight]? {
        var highlights: [BDFHighlight]?
        
        if let users = dictionary["users"] as? [NSDictionary] {
            for user in users {
                if let userHighlight = BDFUserHighlight(dictionary: user) {
                    if highlights == nil {
                        highlights = []
                    }
                    highlights?.append(userHighlight)
                }
            }
        }
        
        if let hashtags = dictionary["hashtags"] as? [NSDictionary] {
            for hashtag in hashtags {
                if let hashtagHighlight = BDFHashTagHighlight(dictionary: hashtag) {
                    if highlights == nil {
                        highlights = []
                    }
                    highlights?.append(hashtagHighlight)
                }
            }
        }
        
        if let links = dictionary["links"] as? [NSDictionary] {
            for link in links {
                if let linkHighlight = BDFLinkHighlight(dictionary: link) {
                    if highlights == nil {
                        highlights = []
                    }
                    highlights?.append(linkHighlight)
                }
            }
        }
        
        return highlights
    }
}

///
/// Enum BDFNotificationHighlightType
///
@objc public enum BDFHighlightType: Int {
    case Link = 0 // Link string
    case Hashtag = 1 // Hashtag string
    case User = 2 // User id
}

///
/// Class BDFLinkHighlight
///
@objc public class BDFLinkHighlight: BDFHighlight {
    public var link: String!
    
    required public init?(dictionary: NSDictionary) {
        super.init(dictionary: dictionary)
        
        if let link = dictionary["link"] as? String {
            type = BDFHighlightType.Link
            self.link = link
        }
        else {
            return nil
        }
    }
}

///
/// Class BDFLinkHighlight
///
@objc public class BDFUserHighlight: BDFHighlight {
    public var userId: Int64 = 0
    
    required public init?(dictionary: NSDictionary) {
        super.init(dictionary: dictionary)
        
        if let userId = dictionary["userId"] as? NSNumber {
            type = BDFHighlightType.User
            self.userId = userId.longLongValue
        }
        else {
            return nil
        }
    }
}

///
/// Class BDFLinkHighlight
///
@objc public class BDFHashTagHighlight: BDFHighlight {
    public var hashtag: String!
    
    required public init?(dictionary: NSDictionary) {
        super.init(dictionary: dictionary)
        
        if let hashtag = dictionary["hashtag"] as? String {
            type = BDFHighlightType.Hashtag
            self.hashtag = hashtag
        }
        else {
            return nil
        }
    }
}

///
/// Enum BDFNotificationAction
///
@objc public enum BDFNotificationAction: Int {
    case OpenPost = 0 // "open_post"
    case OpenProfile = 1 // "open_user_profile"
    case FriendRequest = 2 // "friend_request"
    case AcceptFollowRequest = 3 // "accept_follow_request"
    case OpenLink = 4 // "open_link"
    case OpenComment = 5 // "open_comment"
}

///
/// Class BDFNotification for notification
///
public class BDFNotification: NSObject, Notification {
    ///
    /// Initializer
    ///
    required public init(dictionary: NSDictionary) {
        super.init()
        
        // Notification id
        if let value = dictionary["notification_id"] as? NSNumber {
            _notificationId = value.longLongValue
        }
        
        // Message
        if let value = dictionary["message"] as? NSDictionary {
            if let message = value["message"] as? String {
                _message = message
            }
            else {
                _message = ""
            }
            
            //Highlights
            _highlights = BDFHighlight.highlightsFromDictionary(value)
        }
        else {
            _message = ""
        }
        
        // Created at 
        if let value = dictionary["created_at"] as? String {
            _createdAt = BDFTimeUtility.sharedInstance.dateFromString(value)
        }
        
        // User
        if let value = dictionary["user"] as? NSDictionary {
            _user = BDFOtherUser(dictionary: value)
        }
        
        // Post
        if let value = dictionary["post"] as? NSDictionary {
            post = BDFPost(dictionary: value)
        }
        
        // Comment
        if let value = dictionary["comment"] as? NSDictionary {
            comment = Comment(dictionary: value)
        }
        
        // Action
        if let value = dictionary["action"] as? String {
            if value == "open_post" {
                _action = BDFNotificationAction.OpenPost
            }
            else if value == "open_user_profile" {
                _action = BDFNotificationAction.OpenProfile
            }
            else if value == "friend_request" {
                _action = BDFNotificationAction.FriendRequest
            }
            else if value == "accept_follow_request" {
                _action = BDFNotificationAction.AcceptFollowRequest
            }
            else if value == "open_link" {
                _action = BDFNotificationAction.OpenLink
            }
            else if value == "open_comment" {
                _action = BDFNotificationAction.OpenComment
            }
        }
        
        // Seen
        if let value = dictionary["seen"] as? NSNumber {
            seen = value.boolValue
        }
    }
    
    ///
    /// Create array of BDFOtherUser
    ///
    class func notificationsFromDictionaries(dictionaries: [NSDictionary]) -> [BDFNotification] {
        var array = [BDFNotification]()
        
        for dict in dictionaries {
            let user = BDFNotification(dictionary: dict)
            array.append(user)
        }
        
        return array
    }
    
    ///
    /// Notification id
    ///
    private var _notificationId: Int64 = 0
    public var notificationId: Int64 {
        return _notificationId
    }
    
    ///
    /// Post object
    ///
    public private(set) var post: Post?
    
    ///
    /// Comment object
    ///
    public private(set) var comment: Comment?
    
    ///
    /// Timestamp when the post is posted
    ///
    private var _createdAt: NSDate!
    public var createdAt: NSDate! {
        return _createdAt
    }
    
    ///
    /// User where notification is getting from
    ///
    private var _user: User!
    public var user: User! {
        return _user
    }
    
    ///
    /// Notification action
    ///
    private var _action: BDFNotificationAction = .OpenProfile
    public var action: BDFNotificationAction {
        return _action
    }
    
    ///
    /// Message
    ///
    private var _message: String!
    public var message: String! {
        return _message
    }
    
    ///
    /// Highlight actions
    ///
    private var _highlights: [BDFHighlight]?
    public var highlights: [BDFHighlight]? {
        return _highlights
    }
    
    ///
    /// Indicates if notification has been seen or not
    ///
    public var seen: Bool = false
}
