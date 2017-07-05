//
//  Comment.swift
//  Models
//
//  Created by Tung Vo  on 16/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation

///
/// Protocol BDFComment
///
@objc public protocol BDFComment: NSObjectProtocol {
    init(dictionary: NSDictionary)
    init(comment: String, user: User, date: NSDate)
    var commentId: Int64 {get set}
    var commentor: User! {get}
    var comment: String! {get}
    var createdAt: NSDate! {get set}
    
    func isOwner(user: User) -> Bool
}

public class Comment : NSObject, BDFComment {
    ///
    /// Initializer
    ///
    required public init(dictionary: NSDictionary) {
        super.init()
        
        // Comment owner
        if let value = dictionary["user"] as? NSDictionary {
            _commentor = BDFOtherUser(dictionary: value)
        }
        
        // Comment
        if let value = dictionary["comment"] as? String {
            _comment = value
        }
        
        // Comment id
        if let value = dictionary["comment_id"] as? NSNumber {
            commentId = value.longLongValue
        }
        
        // Created at
        if let value = dictionary["created_at"] as? String {
            createdAt = BDFTimeUtility.sharedInstance.dateFromString(value)
        }
    }
    
    required public init(comment: String, user: User, date: NSDate) {
        super.init()
        
        _commentor = user
        _comment = comment
        createdAt = date
    }
    
    ///
    /// Create array of BDFComment
    ///
    class func commentsFromDictionaries(dictionaries: [NSDictionary]) -> [Comment] {
        var array = [Comment]()
        
        for dict in dictionaries {
            let user = Comment(dictionary: dict)
            array.append(user)
        }
        
        return array
    }
    
    ///
    /// Comment id
    ///
    public var commentId: Int64 = 0
    
    ///
    /// User who creates the comment
    ///
    private var _commentor: User!
    public var commentor: User! {
        return _commentor
    }
    
    
    ///
    /// Content of the comment
    ///
    private var _comment: String!
    public var comment: String! {
        return _comment
    }
    
    ///
    /// Timestamp of the comment
    ///
    public var createdAt: NSDate!
    
    ///
    /// Indicate if user is owner of the comment
    ///
    public func isOwner(user: User) -> Bool {
        if user.isAuthenticatedUser() {
            return user.isIdentical(_commentor)
        }
        return false
    }
}
