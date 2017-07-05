//
//  SinglePostDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 15/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import LoremIpsum
import DTPhotoViewerController
import Models

private let kNumberofItems: Int = 20

class SinglePostDataSource: NSObject, ASTableViewDelegate, ASTableViewDataSource, UICollectionViewDelegateFlowLayout, CommentNodeDelegate {
    var post: Post! {
        didSet {
            DTLog("Set")
        }
    }
    var postId: Int64!
    private var _comments: [Comment]!
    
    private weak var _viewController: UIViewController?
    private weak var _tableNode: ASTableNode?
    
    ///
    /// This flag is used to notify others if other posts should be updated according to the current 
    /// post info. 
    /// Only change this value to true if something changes in post (numberOfLikes, numberOfComments, liked)
    ///
    private var _shouldNotifyChanges = false
    
    convenience init(tableNode: ASTableNode, viewController: UIViewController) {
        self.init()
        tableNode.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        tableNode.view.separatorStyle = UITableViewCellSeparatorStyle.None
        tableNode.view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        tableNode.dataSource = self
        tableNode.delegate = self
        
        _viewController = viewController
        _tableNode = tableNode
        
        _comments = []
    }
    
    //Public methods
    func addNewComment(comment: String, fromUser user: User) {
        let newComment = Comment(comment: comment, user: user, date: NSDate())
        _comments.append(newComment)
        
        guard let tableView = self._tableNode?.view else {
            return
        }
        
        let indexPath = NSIndexPath(forRow: _comments.count - 1, inSection: 1)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        tableView.waitUntilAllUpdatesAreCommitted()
        
        //Scroll to bottom
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        
        // Create new comment
        BDFAuthenticatedUser.currentUser.commentToPost(comment, postId: post.postId, successBlock: { (comment: BDFComment) in
            // Update new comment
            newComment.commentId = comment.commentId
            
            // Update number of comments in post
            self.post.numberOfComments += 1
            self._shouldNotifyChanges = true
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Update comment visual
            DTLog(error)
        }
    }
    
    ///
    /// Notify post info changes
    ///
    func notifyPostInfoChanges() {
        if _shouldNotifyChanges {
            BDFUIUpdaterManager.sharedManager.postInfoChanged(self.post)
            _shouldNotifyChanges = false
        }
    }
    
    func insertComments(previousComments: [Comment]) {
        guard let tableView = self._tableNode?.view else {
            return
        }
        
        var indexPaths = [NSIndexPath]()
        for (index, comment) in previousComments.enumerate() {
            _comments.insert(comment, atIndex: 0)
            indexPaths.append(NSIndexPath(forRow: index, inSection: 1))
        }
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
        tableView.waitUntilAllUpdatesAreCommitted()
        
        //Scroll to bottom
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func loadComments() {
        BDFAuthenticatedUser.currentUser.getCommentsInPost(post.postId, limit: 20, nextPageString: nil, successBlock: { (comments: [Comment]?, nextPageString: String?) in
            // Update table view
            if let newComments = comments {
                self._comments = newComments
                self._tableNode?.view.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.None)
            }
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Show error
            DTLog(error)
        }
    }
    
    //MARK: ASTableViewDataSource + ASTableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return _comments.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 1 {
            // Tap comment
            let comment = _comments[indexPath.row]
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let deleteButton = UIAlertAction(title: "Delete comment", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.deleteCommentAtIndexPath(indexPath)
            })
            
            let reportButton = UIAlertAction(title: "Report comment", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.reportCommentAtIndexPath(indexPath)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            
            // If I am an owner of the comment. I can only delete it.
            if comment.isOwner(BDFAuthenticatedUser.currentUser) {
                // Delete option
                alertController.addAction(deleteButton)
            }
            else {
                // If I am an owner of the post. I can delete and report the comment.
                if post.isOwner(BDFAuthenticatedUser.currentUser) {
                    alertController.addAction(deleteButton)
                    alertController.addAction(reportButton)
                }
                else {
                    // I can only report the comment
                    alertController.addAction(reportButton)
                }
            }
            
            alertController.addAction(cancelButton)
            _viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        //let conversation = Conversation.sharedConversations[indexPath.row]
        if indexPath.section == 0 {
            return {
                let node = SinglePostNode(post: self.post)
                //node.loadNetworkingData(self.post)
                node.nodeDelegate = self
                return node
            }
        }
        
        return {
            let node = CommentNode(comment: self._comments[indexPath.row])
            node.delegate = self
            return node
        }
    }
    
    //MARK: CommentNodeDelegate
    func commentNodeGoToUserProfileWithNode(node: CommentNode) {
        if let indexPath = self._tableNode?.view.indexPathForNode(node) {
            let profileViewController = ProfileViewController()
            profileViewController.user = _comments[indexPath.row].commentor!
            _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}

//MARK: SinglePostNodeDelegate
extension SinglePostDataSource: SinglePostNodeDelegate {
    //MARK: SinglePostNodeDelegate
    func singlePostNodeCommentNumberButtonTapped(node: SinglePostNode) {
        //Does nothing, we are already in single post view
    }
    
    func singlePostNodeImageViewTapped(node: SinglePostNode) {
        //Present Image viewwer
        if let photoViewerController = DTPhotoViewerController(referenceView: node.postPhotoNode.view, image: node.postPhotoNode.image) {
            _viewController?.presentViewController(photoViewerController, animated: true, completion: nil)
        }
    }
    
    func singlePostNodeLikeButtonTapped(button: ASButtonNode, node: SinglePostNode) {
        // We just need to update post data model, KVO will handle UI Change
        if button.selected {
            // Update number of likes
            self.post.numberOfLikes += 1
            
            // Like the post
            BDFAuthenticatedUser.currentUser.likePost(post.postId, successBlock: {
                // Update post like
                self.post.liked = true
                
                // Change flag
                self._shouldNotifyChanges = true
                
                }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    // Update like button
                    self.post.liked = false
                    self.post.numberOfLikes -= 1
            })
        }
        else {
            // Update number of likes
            self.post.numberOfLikes -= 1
            
            // Unlike the post
            BDFAuthenticatedUser.currentUser.unlikePost(post.postId, successBlock: {
                // Update post like
                self.post.liked = false
                
                //Change flag
                self._shouldNotifyChanges = true
                
                }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    // Update like button
                    self.post.liked = true
                    self.post.numberOfLikes += 1
                    print(error)
            })
        }
    }
    
    func singlePostNodeLikeNumberButtonTapped(node: SinglePostNode) {
        let type = UserListType.Likers(self.postId)
        let likerListViewController = UserListViewController(type: type)
        _viewController?.navigationController?.pushViewController(likerListViewController, animated: true)
    }
    
    func singlePostNodeProfileImageViewTapped(node: SinglePostNode) {
        let profileViewController = ProfileViewController()
        profileViewController.user = post.owner
        _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func singlePostNodeCommentButtonTapped(node: SinglePostNode) {
        
    }
}

//MARK: Comment handling (Delete & Report)
extension SinglePostDataSource {
    func deleteCommentAtIndexPath(indexPath: NSIndexPath) {
        let comment = _comments[indexPath.row]
        BDFAuthenticatedUser.currentUser.deleteComment(comment.commentId, successBlock: { 
            // Delete comment successfully
            self._comments.removeAtIndex(indexPath.row)
            self._tableNode?.view.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Failure
            let alertController = UIAlertController(title: nil, message: "Cannot delete this comment. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            
            alertController.addAction(cancelButton)
            self._viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func reportCommentAtIndexPath(indexPath: NSIndexPath) {
        let comment = _comments[indexPath.row]
        BDFAuthenticatedUser.currentUser.reportComment(comment.commentId, successBlock: { 
            // Report comment successfully
            let alertController = UIAlertController(title: "Thank you!", message: "This comment has been reported to us. We will review it as soon as possible.", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            
            alertController.addAction(cancelButton)
            self._viewController?.presentViewController(alertController, animated: true, completion: nil)
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Failure
            let alertController = UIAlertController(title: nil, message: "Cannot report this comment. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            
            alertController.addAction(cancelButton)
            self._viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
