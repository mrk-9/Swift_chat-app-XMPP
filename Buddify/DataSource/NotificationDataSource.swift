//
//  NotificationDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 11/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import LoremIpsum
import Models

class NotificationDataSource: NSObject, LoadingManagerDelegate {
    private weak var _tableNode: ASTableNode?
    private weak var _viewController: UIViewController?
    private var _notifications: [Notification]?
    
    ///
    /// Next page url string to load more data
    ///
    private var _nextPageString: String?
    
    /// Content status
    private var contentStatus = DTContentStatus.NotLoaded
    
    init(tableNode: ASTableNode, viewController: UIViewController) {
        super.init()
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.addLoadingManager(nil, loadingManagerDelegate: self, scrollDirection: ScrollDirection.Vertical)
        tableNode.view.addRefreshControl(self, action: #selector(NotificationDataSource.refresh(_:)), tintColor: UIColor.appPurpleColor())
        _tableNode = tableNode
        _tableNode?.view.rowHeight = 90
        
        _viewController = viewController
    }
    
    func loadMoreNotifications(completionHandler: ((Bool) -> Void)?) {
        self.loadData(refreshing: false, animated: false, completionHandler: completionHandler)
    }
    
    //MARK: LoadingManagerDelegate
    func loadingManagerLoaderDidStartAnimating(loadingManager: LoadingManager) {
        self.loadMoreNotifications { (succeeded) in
            loadingManager.scrollView?.stopLoading()
        }
    }
    
    //MARK: Handle navigations
    private func openUser(user: User) {
        let profileViewController = ProfileViewController()
        profileViewController.user = user
        _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func openPost(post: Post) {
        let singlePostViewController = SinglePostViewController()
        singlePostViewController.post = post
        _viewController?.navigationController?.pushViewController(singlePostViewController, animated: true)
    }
    
    private func openLink(string: String) {
        
    }
    
    private func openComment(comment: Comment) {
        
    }
}

//MARK: ASTableViewDelegate, ASTableViewDataSource
extension NotificationDataSource: ASTableViewDelegate, ASTableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let notifications = _notifications else {
            if contentStatus == .NotLoaded {
                tableView.userInteractionEnabled = false
                return 10
            }
            
            tableView.userInteractionEnabled = true
            return 0
        }
        
        tableView.userInteractionEnabled = true
        return notifications.count
    }
    
    func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        guard let notifications = _notifications else {
            return {
                let node = NotificationPlaceHolderNode()
                return node
            }
        }
        
        let notification = notifications[indexPath.row]
        
        return {
            let node = NotificationNode(notification: notification)
            node.delegate = self
            return node
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let notification = _notifications?[indexPath.row] {
            switch notification.action {
            case .OpenProfile:
                self.openUser(notification.user)
                
            case .OpenPost:
                if let post = notification.post {
                    self.openPost(post)
                }
                
            case .OpenLink:
                DTLog("Open Link")
            case .FriendRequest:
                DTLog("Friend request")
            case .AcceptFollowRequest:
                DTLog("Accept follow request")
            case .OpenComment:
                if let comment = notification.comment {
                    self.openComment(comment)
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if contentStatus == DTContentStatus.NoContent || contentStatus == .ErrorLoad {
            return 100
        }
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if contentStatus == DTContentStatus.NoContent || contentStatus == DTContentStatus.ErrorLoad {
            let label = InsetLabel()
            label.textInsets = UIEdgeInsetsMake(0, 20, 0, 20)
            label.frame.size.width = tableView.frame.width
            label.font = UIFont.appFont(CGFloat.normalFontSize)
            label.textColor = UIColor.blackColor()
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.textAlignment = .Center
            
            if contentStatus == .NoContent {
                label.text = "No activities yet."
            }
            else if contentStatus == .ErrorLoad {
                label.text = "There is problem loading activities.\nPlease try again."
            }
            
            return label
        }
        return nil
    }
}

//MARK: NotificationNodeDelegate
extension NotificationDataSource: NotificationNodeDelegate {
    func notificationNodeProfilePhotoTapped(node: NotificationNode) {
        guard let notifications = _notifications else {
            return
        }
        
        if let indexPath = _tableNode?.view.indexPathForNode(node) {
            self.openUser(notifications[indexPath.row].user)
        }
    }
    
    func notificationNodeThumbnailImageViewTapped(node: NotificationNode) {
        guard let notifications = _notifications else {
            return
        }
        
        if let indexPath = _tableNode?.view.indexPathForNode(node) {
            if let post = notifications[indexPath.row].post {
                self.openPost(post)
            }
        }
    }
}

//MARK: Load data
extension NotificationDataSource {
    internal func refresh(refreshControl: UIRefreshControl?) {
        // Remove next page
        _nextPageString = nil
        
        if !PLACEHOLDER_TEST {
            if let _ = refreshControl {
                self.loadData(refreshing: true, animated: true, completionHandler: nil)
            }
            else {
                self.loadData(refreshing: true, animated: true, completionHandler: nil)
            }
        }
    }
    
    func loadData(refreshing refresh: Bool, animated: Bool, completionHandler: ((Bool) -> Void)?) {
        BDFAuthenticatedUser.currentUser.getCurrentUserNotifications(nextPageString: _nextPageString, successBlock: {[weak self] (notifications: [Notification]?, nextPageString: String?) in
            guard let _self = self else {
                return
            }
            
            //New array
            if let newNotifications = notifications {
                //If we are refreshing the content
                if refresh {
                    // Update content status
                    if newNotifications.count == 0 {
                        _self.contentStatus = DTContentStatus.NoContent
                        _self._tableNode?.view.shouldAnimating = false
                    }
                    else {
                        _self.contentStatus = DTContentStatus.Loaded
                        _self._tableNode?.view.shouldAnimating = true
                    }
                    
                    //Remove all existing items by reinitializing the array
                    _self._notifications = []
                    _self._notifications = _self._notifications! + newNotifications
                    _self._tableNode?.view.reloadDataWithCompletion({
                        if animated {
                            //Reset content offset + shouldAnimating
                            _self._tableNode?.view.refreshControl?.endRefreshing()
                        }
                    })
                }
                else {
                    guard let notifications = _self._notifications else {
                        return
                    }
                    
                    if newNotifications.count == 0 {
                        //Prevent to load more the next time
                        self?._tableNode?.view.shouldAnimating = false
                        self?._tableNode?.view.reloadData()
                        completionHandler?(true)
                        return
                    }
                    
                    var indexPaths = [NSIndexPath]()
                    for i in notifications.count...(notifications.count + newNotifications.count - 1) {
                        let indexPath = NSIndexPath(forItem: i, inSection: 0)
                        indexPaths.append(indexPath)
                    }
                    
                    _self._notifications = notifications + newNotifications
                    _self._tableNode?.view.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                    completionHandler?(true)
                }
                
                //Get next link
                _self._nextPageString = nextPageString
                
                if _self._nextPageString == nil {
                    self?._tableNode?.view.shouldAnimating = false
                }
            }
            
        }) { [weak self](statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Update content status
            let status = self?.contentStatus
            self?.contentStatus = DTContentStatus.ErrorLoad
            if status == DTContentStatus.NotLoaded {
                dispatch_async_main_queue({
                    self?._tableNode?.view.reloadData()
                })
            }
            
            self?._tableNode?.view.refreshControl?.endRefreshing()
            self?._tableNode?.view.userInteractionEnabled = true
            completionHandler?(true)
            DTLog(error?.description)
        }
    }
}
