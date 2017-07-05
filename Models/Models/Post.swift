//
//  Post.swift
//  Models
//
//  Created by Tung Vo  on 16/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation

///
/// Protocol Post
///
@objc public protocol Post: class, NSObjectProtocol {
    init(dictionary: NSDictionary)
    var photoSize: CGSize {get}
    var numberOfLikes: Int {get set}
    var numberOfComments: Int {get set}
    var liked: Bool {get set}
    var postId: Int64 {get}
    var owner: User! {get}
    var type: BDFPostType {get}
    var status: String! {get}
    var createdAt: NSDate! {get}
    var photo: String? {get}
    var thumbnailPhotos: [String]? {get}
    func isOwner(user: User) -> Bool
    func isIdentical(post: Post) -> Bool
}

///
///
///
@objc public enum BDFPostType: Int {
    case Image = 0 // "image"
    case Video = 1 // "video"
    case Status = 2 // "status"
}

///
/// Class of post BDFPost
///
public class BDFPost: NSObject, Post {
    ///
    /// Initializer
    ///
    required public init(dictionary: NSDictionary) {
        super.init()
        
        //post id
        if let value = dictionary["post_id"] as? NSNumber {
            _postId = value.longLongValue
        }
        
        //item type
        if let value = dictionary["item_type"] as? String {
            if value == "status" {
                _type = BDFPostType.Status
            }
            else if value == "image" {
                _type = BDFPostType.Image
            }
            else if value == "video" {
                _type = BDFPostType.Video
            }
        }
        
        //description
        if let value = dictionary["status"] as? String {
            _status = value
        }
        
        //photo
        if let value = dictionary["url"] as? String {
            _photo = value
        }
        
        // Photo width and height
        if let height = dictionary["height"] as? NSNumber {
            if let width = dictionary["width"] as? NSNumber {
                photoSize = CGSize(width: CGFloat(width.floatValue), height: CGFloat(height.floatValue))
            }
        }
        
        //thumbnails
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
            
            _thumbnailPhotos = array
        }
        
        
        //number of likes
        if let value = dictionary["total_likes"] as? NSNumber {
            numberOfLikes = value.integerValue
        }
        
        //number of comments
        if let value = dictionary["total_comments"] as? NSNumber {
            numberOfComments = value.integerValue
        }
        
        //owner
        if let value = dictionary["user"] as? NSDictionary {
            _owner = BDFOtherUser(dictionary: value)
        }
        
        //created at
        if let value = dictionary["created_at"] as? String {
            _createdAt = BDFTimeUtility.sharedInstance.dateFromString(value)
        }
        
        //liked
        if let value = dictionary["liked"] as? NSNumber {
            liked = value.boolValue
        }
    }
    
    ///
    /// Create array of BDFPost
    ///
    class func postsFromDictionaries(dictionaries: [NSDictionary]) -> [BDFPost] {
        var array = [BDFPost]()
        
        for dict in dictionaries {
            let post = BDFPost(dictionary: dict)
            array.append(post)
        }
        
        return array
    }
    
    ///
    /// Number of likes
    ///
    dynamic public var numberOfLikes: Int = 0
    
    ///
    /// Number of comments
    ///
    dynamic public var numberOfComments: Int = 0
    
    ///
    /// Post if
    ///
    private var _postId: Int64 = 0
    public var postId: Int64 {
        return _postId
    }
    
    ///
    /// Owner of the post
    ///
    private var _owner: User!
    public var owner: User! {
        return _owner
    }
    
    ///
    /// Type of the post
    ///
    private var _type: BDFPostType = .Status
    public var type: BDFPostType {
        return _type
    }
    
    ///
    /// Status of the post
    ///
    private var _status: String!
    public var status: String! {
        return _status
    }
    
    ///
    /// Timestamp when the post is posted
    ///
    private var _createdAt: NSDate!
    public var createdAt: NSDate! {
        return _createdAt
    }
    
    ///
    /// Photo of the post
    ///
    private var _photo: String?
    public var photo: String? {
        return _photo
    }
    
    /// Height of photo
    public private(set) var photoSize: CGSize = CGSizeZero
    
    // Width of photo
    
    ///
    /// Thumbnail photo of the post
    ///
    private var _thumbnailPhotos: [String]?
    public var thumbnailPhotos: [String]? {
        return _thumbnailPhotos
    }
    
    ///
    /// Indicates whether or not user has liked the post
    ///
    dynamic public var liked: Bool = false
    
    ///
    /// Indicates whether or not user is owner of the post
    ///
    public func isOwner(user: User) -> Bool {
        if user.isAuthenticatedUser() {
            return self.owner.isIdentical(user)
        }
        return false
    }
    
    /// Indicates if the post if identical
    public func isIdentical(post: Post) -> Bool {
        return post.postId == self.postId
    }
}

///
/// Time utility
///
class BDFTimeUtility: NSObject {
    var timeFormatter : NSDateFormatter!
    
    class var sharedInstance : BDFTimeUtility!{
        get {
            struct Static {
                static var instance : BDFTimeUtility!
            }
            
            if Static.instance == nil {
                Static.instance = BDFTimeUtility()
            }
            
            return Static.instance!
        }
    }
    
    override init() {
        super.init()
        timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZZZ"
    }
    
    func dateFromString(string : String!) -> NSDate! {
        if let date = timeFormatter.dateFromString(string) {
            return date
        }
        return NSDate()
    }
}
