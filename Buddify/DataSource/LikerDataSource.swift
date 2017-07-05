//
//  UserListDataSource.swift
//  Buddify
//
//  Created by Huy Le on 3/17/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import LoremIpsum
import Models

enum UserListType {
    case Likers(Int64)
    case Blocked
}

class UserListDataSource: NSObject, ASTableDataSource, ASTableDelegate, LoadingManagerDelegate {
    var listType: UserListType
    
    weak private var _viewController: UIViewController?
    weak private var _tableNode: ASTableNode?
    private var _users: [User]?
    private var _nextPageString: String?
    
    /// Content status
    private var contentStatus = DTContentStatus.NotLoaded
    
    init(type: UserListType, tableNode: ASTableNode, viewController: UIViewController) {
        listType = type
        super.init()
        tableNode.backgroundColor = UIColor.whiteColor()
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .None
        tableNode.view.addLoadingManager(nil, loadingManagerDelegate: self, scrollDirection: ScrollDirection.Vertical)
        tableNode.view.addRefreshControl(self, action: #selector(self.dynamicType.refresh(_:)), tintColor: UIColor.appPurpleColor())
        
        _tableNode = tableNode
        _viewController = viewController
    }
    
    //MARK: ASTableview delegate methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _users = _users else {
            return 0//Int(tableView.bounds.size.height / UserListPlaceholderNode.defaultHeight())
        }
        
        return _users.count
    }
    
    func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        //Placeholder cell node
        guard let _users = _users else {
            tableView.userInteractionEnabled = false
            return {
                return UserListPlaceholderNode()
            }
        }
        
        tableView.userInteractionEnabled = true
        let user = _users[indexPath.row]
        let userListNode = UserListNode(user: user)
		
        if indexPath.row%2 == 1 {
			userListNode.backgroundColor = UIColor.appScrollViewBackgrouncColor()
		}
		else {
			userListNode.backgroundColor = UIColor.whiteColor()
		}
        
        return {
            userListNode
        }
    }
	
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let _users = _users else {
            return
        }
        
        let profileViewController = ProfileViewController()
        profileViewController.user = _users[indexPath.row]
        _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension UserListDataSource {
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
                self.loadData(refreshing: true, animated: true, completionHandler: nil)
            }
        }
    }
    
    func loadData(refreshing refresh: Bool, animated: Bool, completionHandler: ((Bool) -> Void)?) {
        let successBlock: (([User]?, String?) -> Void) = {[weak self](users: [User]?, nextPageString: String?) -> Void in
            guard let _self = self else {
                return
            }
            
            if let newUsers = users {
                //If we are refreshing the content
                if refresh {
                    //Remove all items by reinitializing the array
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
                
                //Disable next loading if needed
                if _self._nextPageString == nil {
                    self?._tableNode?.view.shouldAnimating = false
                }
            }
        }
        
        let failureBlock: ((Int?, Int?, NSError?) -> Void) = {[weak self](statusCode: Int?, errorCode: Int?, error: NSError?) -> Void in
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
        
        // Load data
        switch listType {
        case UserListType.Likers(let postId):
            BDFAuthenticatedUser.currentUser.getLikersFromPost(postId, limit: 50, nextPageString: _nextPageString, successBlock: successBlock, failureBlock: failureBlock)
        default:
            DTLog("Do nothing")
        }
    }
}