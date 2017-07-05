//
//  ContentService.swift
//  Buddify
//
//  Created by Vo Duc Tung on 12/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

///
/// This class is a client api for getting content in the app.
///
public class ContentServices: AuthenticatedServices {
    ///
    /// Get timeline posts
    ///
    public func getTimelinePosts(nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "posts") : self.requestWithCustomURLString(nextPageString!)
        self.request(NetworkingMethod.GET, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get posts from user
    ///
    public func getPostsFromUserWithUserId(userId: Int64, nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "posts") : self.requestWithCustomURLString(nextPageString!)
        let parameters = ["user_id": "\(userId)"]
        self.request(NetworkingMethod.GET, request: request, paramaters: parameters, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get post information
    ///
    public func getPostInformationWithPostId(postId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "posts/\(postId)")
        self.request(NetworkingMethod.GET, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Comment to post
    ///
    public func commentToPost(comment: String, postId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "posts/\(postId)/comments")
        self.request(request, parameters: ["comment": comment], formDatas: nil, progress: nil, success: successBlock, failure: failureBlock)
    }
    
    ///
    /// Delete comment from post
    ///
    public func deleteComment(commentId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "comments/\(commentId)")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Report comment
    ///
    public func reportComment(commentId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "comments/\(commentId)/flag")
        self.request(NetworkingMethod.POST, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Report post
    ///
    public func reportPost(postId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "posts/\(postId)/flag")
        self.request(NetworkingMethod.POST, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Delete post
    ///
    public func deletePost(postId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "posts/\(postId)")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Like post
    ///
    public func likePost(postId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "posts/\(postId)/likes")
        self.request(NetworkingMethod.POST, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Unlike post
    ///
    public func unlikePost(postId: Int64, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "posts/\(postId)/likes")
        self.request(NetworkingMethod.DELETE, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get friend requests
    ///
    public func getFriendRequests(nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "users/me/friend_request") : self.requestWithCustomURLString(nextPageString!)
        self.request(NetworkingMethod.GET, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get blocked users
    ///
    public func getBlockedUsers(nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "users/me/block_list") : self.requestWithCustomURLString(nextPageString!)
        self.request(NetworkingMethod.GET, request: request, paramaters: nil, progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get likers of post
    ///
    public func getLikersFromPost(postId: Int64, limit: Int, nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "users?liked_post=\(postId)") : self.requestWithCustomURLString(nextPageString!)
        self.request(NetworkingMethod.GET, request: request, paramaters: ["limit": String(limit)], progress: nil, success:
            successBlock, failure: failureBlock)
    }
    
    ///
    /// Get comments in post
    ///
    public func getCommentsInPost(postId: Int64, limit: Int, nextPageString: String?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = nextPageString == nil ? self.requestWith("1", endpoint: "posts/\(postId)/comments") : self.requestWithCustomURLString(nextPageString!)
        self.request(NetworkingMethod.GET, request: request, paramaters: ["comment_limit" : String(limit)], progress: nil, success:
            successBlock, failure: failureBlock)
    }
}
