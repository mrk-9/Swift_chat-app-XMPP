//
//  FriendRequestDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 17/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import LoremIpsum
import Models

//This needs to be change for performance
private let itemWidth: CGFloat = CGFloat.screenWidth
private let itemHeight: CGFloat = 120

class FriendRequestDataSource: NSObject, MosaicCollectionViewLayoutDelegate, FriendRequestNodeDelegate, LoadingManagerDelegate, ASTableViewDataSource, ASTableViewDelegate {
    weak private var _tableNode: ASTableNode?
    weak private var _viewController: UIViewController?
    private var _users: [User]?
    
    ///
    /// Next page url string to load more data
    ///
    private var _nextPageString: String?
    
    /// Content status
    private var contentStatus = DTContentStatus.NotLoaded
    
    convenience init(tableNode: ASTableNode, viewController: UIViewController) {
        self.init()
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = UIColor.whiteColor()
        tableNode.view.addLoadingManager(nil, loadingManagerDelegate: self, scrollDirection: .Vertical)
        tableNode.view.rowHeight = FriendRequestNode.defaultHeight()
        tableNode.view.addRefreshControl(self, action: #selector(FriendRequestDataSource.refresh(_:)), tintColor: UIColor.appPurpleColor())
        
        _viewController = viewController
        _tableNode = tableNode
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let users = _users else {
            return
        }
        
        let profileViewController = ProfileViewController()
        profileViewController.user = users[indexPath.row]
        self._viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    //MARK: ASTableNodeDelegate, ASTableNodeDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = _users else {
            if contentStatus == .NotLoaded {
                self._tableNode?.view.userInteractionEnabled = false
                return 10
            }
            
            self._tableNode?.view.userInteractionEnabled = true
            return 0
        }
        self._tableNode?.view.userInteractionEnabled = true
        return users.count
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        guard let users = _users else {
            return {
                return FriendRequestPlaceholderNode()
            }()
        }
        
        let user = users[indexPath.row]
        
        return {
            let node = FriendRequestNode(user: user)
            node.nodeDelete = self
            return node
        }()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let users = _users else {
            return
        }
        
        let profileViewController = ProfileViewController()
        profileViewController.user = users[indexPath.row]
        self._viewController?.navigationController?.pushViewController(profileViewController, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
            label.textAlignment = .Center
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            
            if contentStatus == .NoContent {
                label.text = "No friend requests."
            }
            else if contentStatus == .ErrorLoad {
                label.text = "There is problem loading friend requests.\nPlease try again."
            }
            
            return label
        }
        return nil
    }
    
    //MARK: MosaicCollectionViewLayoutDelegate
    func collectionView(collectionView: UICollectionView!, layout: MosaicCollectionViewLayout!, originalItemSizeAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    //MARK: DiscoveryUserNodeDelegate
    func friendRequestNodeAcceptButtonTapped(node: FriendRequestNode) {
        if let indexPath = _tableNode?.view.indexPathForNode(node) {
            //Send repuest and then delete item
            guard let user = _users?[indexPath.row] else {
                return
            }
            
            BDFAuthenticatedUser.currentUser.acceptFriendRequestFromUserWithUserId(user.userId, successBlock: {[weak self] in
                // Remove user
                self?._users?.removeAtIndex(indexPath.row)
                self?._tableNode?.view.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    // Show error
                    DTLog(error)
            })
        }
    }
    
    func friendRequestNodeADeclineButtonTapped(node: FriendRequestNode) {
        let alertController = UIAlertController(title: nil, message: "Do you want to delete this friend request?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let deleteButton = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if let indexPath = self._tableNode?.view.indexPathForNode(node) {
                //Send repuest and then delete item
                guard let user = self._users?[indexPath.row] else {
                    return
                }
                
                BDFAuthenticatedUser.currentUser.deleteFriendRequestFromUserWithUserId(user.userId, successBlock: { [weak self] in
                    self?._users?.removeAtIndex(indexPath.row)
                    self?._tableNode?.view.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                        // Show error
                        DTLog(error)
                })
                
            }
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
        })
        
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        _viewController?.presentViewController(alertController, animated: true, completion: nil)
    }
}

extension FriendRequestDataSource {
    //MARK: Methods
    func loadMoreUsers(completionHandler: ((Bool) -> Void)?) {
        self.loadData(refreshing: false, animated: false, completionHandler: completionHandler)
    }
    
    //MARK: LoadingManagerDelegate
    /* This indicates wheather or not loader should starts loading when scrolls to bottom*/
    func loadingManagerLoaderDidStartAnimating(loadingManager: LoadingManager) {
        //Load more content here
        //Add more contents
        self.loadMoreUsers({[weak self] (succeeded) in
            self?._tableNode?.view.stopLoading()
            })
        
        if _nextPageString != nil {
            
        }
    }
    
    //MARK: Data source methods
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
    
    func loadData(refreshing refresh: Bool, animated: Bool, completionHandler: ((Bool) -> Void)?) {
        
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
                    
                    // Update content status
                    if newUsers.count == 0 {
                        _self.contentStatus = DTContentStatus.NoContent
                        _self._tableNode?.view.shouldAnimating = false
                    }
                    else {
                        _self.contentStatus = DTContentStatus.Loaded
                        _self._tableNode?.view.shouldAnimating = true
                    }
                    
                    _self._tableNode?.view.reloadDataWithCompletion({
                        if animated {
                            //Reset content offset
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
            self?.contentStatus = DTContentStatus.ErrorLoad
            self?._tableNode?.view.userInteractionEnabled = true
            self?._tableNode?.view.refreshControl?.endRefreshing()
            completionHandler?(true)
            DTLog(error?.description)
        }

        BDFAuthenticatedUser.currentUser.getFriendRequests(nextPageString: _nextPageString, successBlock: successBlock, failureBlock: failureBlock)
    }
}