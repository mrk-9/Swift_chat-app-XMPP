//
//  WebServiceCenter+Content.swift
//  Models
//
//  Created by Tung Vo  on 21/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation
import BDFClientApi

//MARK: Content services
extension BDFAuthenticatedUser {
    ///
    /// Get timeline posts
    ///
    public func getTimelinePosts(nextPageString: String?, successBlock: (([Post]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.getTimelinePosts(nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //Return array of posts
            if let dictionary = object as? NSDictionary {
                if let items = dictionary["items"] as? [NSDictionary] {
                    let posts = BDFPost.postsFromDictionaries(items)
                    let next = dictionary["next"] as? String
                    successBlock?(posts, next)
                    return
                }
            }
            
            successBlock?(nil, nil)
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
                self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get posts from user
    ///
    public func getPostsFromUserWithUserId(userId: Int64, nextPageString: String?, successBlock: (([Post]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.getPostsFromUserWithUserId(userId, nextPageString: nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //Return array of posts
            if let dictionary = object as? NSDictionary {
                print(dictionary)
                if let items = dictionary["items"] as? [NSDictionary] {
                    let posts = BDFPost.postsFromDictionaries(items)
                    let next = dictionary["next"] as? String
                    successBlock?(posts, next)
                    return
                }
            }
            
            successBlock?(nil, nil)
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get post information
    ///
    public func getPostInformationWithPostId(postId: Int64, successBlock: (Post -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.getPostInformationWithPostId(postId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            if let dictionary = object as? NSDictionary {
                let post = BDFPost(dictionary: dictionary)
                successBlock?(post)
                return
            }
            
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Comment to post
    ///
    public func commentToPost(comment: String, postId: Int64, successBlock: (Comment -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.commentToPost(comment, postId: postId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            if let dictionary = object as? NSDictionary {
                let comment = Comment(dictionary: dictionary)
                successBlock?(comment)
                return
            }
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }

    }
    
    ///
    /// Delete comment from post
    ///
    public func deleteComment(commentId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.deleteComment(commentId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }

    }
    
    ///
    /// Report comment
    ///
    public func reportComment(commentId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.reportComment(commentId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Report post
    ///
    public func reportPost(postId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.reportPost(postId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Delete post
    ///
    public func deletePost(postId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.deletePost(postId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Like post
    ///
    public func likePost(postId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.likePost(postId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Unlike post
    ///
    public func unlikePost(postId: Int64, successBlock: (() -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.unlikePost(postId, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            successBlock?()
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get friend requests
    ///
    public func getFriendRequests(nextPageString nextPageString: String?, successBlock: (([User]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.getFriendRequests(nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            if let dictionary = object as? NSDictionary {
                if let items = dictionary["items"] as? [NSDictionary] {
                    let users = BDFOtherUser.usersFromDictionaries(items)
                    let next = dictionary["next"] as? String
                    successBlock?(users, next)
                    return
                }
                
                successBlock?(nil, nil)
            }
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get friend requests
    ///
    public func getBlockedUsers(nextPageString nextPageString: String?, successBlock: (([User]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.getBlockedUsers(nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            if let dictionary = object as? NSDictionary {
                if let items = dictionary["items"] as? [NSDictionary] {
                    let users = BDFOtherUser.usersFromDictionaries(items)
                    let next = dictionary["next"] as? String
                    successBlock?(users, next)
                    return
                }
                
                successBlock?(nil, nil)
            }
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get likers of post
    ///
    public func getLikersFromPost(postId: Int64, limit: Int, nextPageString: String?, successBlock: (([User]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.getLikersFromPost(postId, limit: limit, nextPageString: nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //
            if let dictionary = object as? NSDictionary {
                if let items = dictionary["items"] as? [NSDictionary] {
                    let users = BDFOtherUser.usersFromDictionaries(items)
                    let next = dictionary["next"] as? String
                    successBlock?(users, next)
                    return
                }
                
                successBlock?(nil, nil)
            }
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
    
    ///
    /// Get comments in post
    ///
    public func getCommentsInPost(postId: Int64, limit: Int, nextPageString: String?, successBlock: (([Comment]?, String?) -> Void)?, failureBlock: BDFServiceCenterExtendedFailureBlock?) {
        _contentServices.getCommentsInPost(postId, limit: limit, nextPageString: nextPageString, successBlock: { (task: NSURLSessionDataTask, object: AnyObject?) in
            //Return array of comments
            if let dictionary = object as? NSDictionary {
                if let items = dictionary["items"] as? [NSDictionary] {
                    let comments = Comment.commentsFromDictionaries(items)
                    let next = dictionary["next"] as? String
                    successBlock?(comments, next)
                    return
                }
                
                successBlock?(nil, nil)
            }
        }) { (task: NSURLSessionDataTask?, error: NSError?) in
            self.executeExtendedBlock(failureBlock, task: task, error: error)
        }
    }
}