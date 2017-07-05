//
//  BlockedUserDataSource.swift
//  Buddify
//
//  Created by Tung Vo  on 01/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Models
import AsyncDisplayKit

class BlockedUserDataSource: NSObject {
    ///
    /// Array of blocked users
    ///
    private var _users: [User]!
    
    weak private var _tableNode: ASTableNode?
    
    ///
    /// View controller
    ///
    weak private var _viewController: UIViewController?
    
    
    ///
    /// Next page url string to load more data
    ///
    private var _nextPageString: String?
    
    /// Content status
    private var contentStatus = DTContentStatus.NotLoaded
    
    convenience init(tableNode: ASTableNode, viewController: UIViewController) {
        self.init()
        _users = []
        tableNode.dataSource = self
        tableNode.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        tableNode.view.addRefreshControl(self, action: #selector(FriendRequestDataSource.refresh(_:)), tintColor: UIColor.appPurpleColor())
        tableNode.view.rowHeight = UserUnblockNode.defaultHeight()
        
        _viewController = viewController

        _tableNode = tableNode
    }
    
    internal func refresh(refreshControl: UIRefreshControl?) {
        // Remove next page
        _nextPageString = nil
        
        if !PLACEHOLDER_TEST {
            if let _ = refreshControl {
                self.loadData(refreshing: true, animated: true, completionHandler: nil)
            }
            else {
                //If refreshing automatically not by scrolling down
                self.loadData(refreshing: true, animated: true, completionHandler: nil)
            }
        }
    }
    
    private func loadData(refreshing refresh: Bool, animated: Bool, completionHandler: ((Bool) -> Void)?) {
        
        let successBlock: (([User]?, String?) -> Void)? = {[weak self](users: [User]?, nextPageString: String?) -> Void in
            guard let _self = self else {
                return
            }
            
            if let newUsers = users {
                
                //If we are refreshing the content
                if refresh {
                    //Empty list by reinitilaize
                    _self._users = []
                    _self._users = _self._users! + newUsers
                    
                    _self._tableNode?.view.reloadDataWithCompletion({
                        if animated {
                            //Reset content offset
                            _self._tableNode?.view.shouldAnimating = true
                            _self._tableNode?.view.refreshControl?.endRefreshing()
                        }
                    })
                }
                else {
                    guard let users = _self._users else {
                        return
                    }
                    
                    if newUsers.count == 0 {
                        //Prevent to load more the next time
                        self?._tableNode?.view.shouldAnimating = false
                        completionHandler?(true)
                        return
                    }
                    
                    var indexPaths = [NSIndexPath]()
                    for i in users.count...(users.count + newUsers.count - 1) {
                        let indexPath = NSIndexPath(forItem: i, inSection: 0)
                        indexPaths.append(indexPath)
                    }
                    _self._users = users + newUsers
                    _self._tableNode?.view.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                    completionHandler?(true)
                }
                
                //Get next link
                _self._nextPageString = nextPageString
                
                // Disable loading more if needed
                if _self._nextPageString == nil {
                    self?._tableNode?.view.shouldAnimating = false
                }
            }
        }
        
        let failureBlock: ((Int?, Int?, NSError?) -> Void)? = {[weak self](statusCode: Int?, errorCode: Int?, error: NSError?) -> Void in
            // Update content status
            let status = self?.contentStatus
            self?.contentStatus = DTContentStatus.ErrorLoad
            if status == DTContentStatus.NotLoaded {
                dispatch_async_main_queue({
                    self?._tableNode?.view.reloadData()
                })
            }
            
            //Enable scroll view
            self?._tableNode?.view.userInteractionEnabled = true
            self?._tableNode?.view.refreshControl?.endRefreshing()
            completionHandler?(true)
            DTLog(error?.description)
        }
        
        BDFAuthenticatedUser.currentUser.getBlockedUsers(nextPageString: _nextPageString, successBlock: successBlock, failureBlock: failureBlock)
    }
}

extension BlockedUserDataSource: ASTableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _users.count
    }
    
    func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        let user = _users[indexPath.row]
        return {
            let node = UserUnblockNode(user: user)
            node.delegate = self
            return node
        }
    }
}

extension BlockedUserDataSource: UserUnblockNodeDelegate {
    func userUnblockNodeButtonTapped(node: UserUnblockNode) {
        if let indexPath = _tableNode?.view.indexPathForNode(node) {
            // Remove user
            
            
            let alertController = UIAlertController(title: nil, message: "Do you want to unblock this user?", preferredStyle: UIAlertControllerStyle.Alert)
            let unblock = UIAlertAction(title: "Unblock", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) in
                let user = self._users[indexPath.row]
                
                BDFAuthenticatedUser.currentUser.unblockUserWithUserId(user.userId, successBlock: {
                    // Confirmation alert
                    let alertController = UIAlertController(title: nil, message: "User unblocked!", preferredStyle: UIAlertControllerStyle.Alert)
                    let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: {(action: UIAlertAction) in
                        // Update data and UI
                        self._users.removeAtIndex(indexPath.row)
                        // Remove row
                        self._tableNode?.view.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    })
                    alertController.addAction(cancel)
                    self._viewController?.presentViewController(alertController, animated: true, completion: nil)
    
                    }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                        // Show error alert
                        let alertController = UIAlertController(title: nil, message: "Something went wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                        let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                        alertController.addAction(cancel)
                        self._viewController?.presentViewController(alertController, animated: true, completion: nil)
                })
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alertController.addAction(unblock)
            alertController.addAction(cancel)
            self._viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
