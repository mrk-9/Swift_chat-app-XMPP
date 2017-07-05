//
//  SearchViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 31/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import LoremIpsum
import Models

private let searchBarHeight: CGFloat = 44

enum SearchViewControllerType {
    case Message
    case Search
}

protocol SearchViewControllerDelegate: NSObjectProtocol {
    func searchViewControllerDidSelectUser(searchViewController: SearchViewController, user: User)
}

class SearchViewController: ASViewController, ASTableDataSource, ASTableDelegate, BDSearchBarDelegate {
    var type: SearchViewControllerType = .Search
    weak var delegate: SearchViewControllerDelegate?
    
    private var _currentSearchItem: SearchItem?
    
    // Keep track of the current searching key.
    // Current key is used for mroe users loading.
    // It should only changed after successfully research, and get data from api calls.
    private var _currentKey: String?
    
    private let tableNode = ASTableNode()
    private var _searchBar: BDSearchBar!
    private var _searchCaches = [String: SearchItem]()
    private var _typingTimer: NSTimer?
    private var _shouldShowKeyboard = true
    
    init() {
        let node = ASDisplayNode()
        super.init(node: node)
        self.hidesBottomBarWhenPushed = true
        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.view.addLoadingManager(nil, loadingManagerDelegate: self, scrollDirection: ScrollDirection.Vertical)
    }
    
    deinit {
        tableNode.view.removeLoadingManager()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        _searchBar = BDSearchBar(frame: CGRect(x: 0, y: 0, width: self.node.bounds.size.width, height: searchBarHeight))
        _searchBar.placeHolder = "Enter username"
        _searchBar.backgroundColor = UIColor.appDarkPurpleColor()
        _searchBar.delegate = self
        
        tableNode.frame = CGRect(x: 0, y: searchBarHeight, width: self.node.bounds.width, height: self.node.bounds.height - searchBarHeight - 64)
        tableNode.view.backgroundColor = UIColor.whiteColor()
        tableNode.view.alwaysBounceVertical = true
        tableNode.view.rowHeight = 60
        tableNode.view.shouldAnimating = false
        
        self.view.addSubview(_searchBar)
        self.node.addSubnode(tableNode)
        
        
        if navigationController?.viewControllers[0] == self {
            let cancelButton = HighLightButton(image: UIImage.cancelIcon(size: CGSize(width: 15, height: 15), color: UIColor.whiteColor()), alignment: UIControlContentHorizontalAlignment.Left)
            cancelButton.addTarget(self, action: #selector(SearchViewController.cancelButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if _shouldShowKeyboard {
            _shouldShowKeyboard = false
            _searchBar.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        //Correct frame
        var tableViewFrame = tableNode.frame
        tableViewFrame.size.height = self.node.frame.size.height - searchBarHeight
        tableNode.frame = tableViewFrame
        
        //Remove observer before dismiss keyboard
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillChangeFrameNotification)
        _searchBar.resignFirstResponder()
        
        super.viewWillDisappear(animated)
    }
    
    internal func cancelButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: Keyboard frame change notification
    internal func keyboardWillChangeFrame(notification : NSNotification){
        var userInfo = notification.userInfo!
        
        let frameEnd = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        //Change tool bar frame
        
        var tableViewFrame = tableNode.frame
        tableViewFrame.size.height = frameEnd.origin.y - searchBarHeight - 64
        
        //Change share bar frame
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.unsignedIntValue
        
        UIView.animateWithDuration(
            userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue,
            delay: 0,
            options: UIViewAnimationOptions(rawValue: UInt(curve)),
            animations: {
                self.tableNode.view.frame = tableViewFrame
            },
            completion: nil)
    }
    
    //MARK: Private methods
    internal func searchUser() {
        if let text = _searchBar.text {
            self.searchUsersWithKey(text)
        }
    }
    
    private func searchUsersWithKey(key: String) {
        if let result = _searchCaches[key] {
            //Display cached results
            _currentSearchItem = result
            self.tableNode.view.reloadData()
            // Update current key
            self._currentKey = key
            
            // Should animating only if next is not nil
            self.tableNode.view.shouldAnimating = (result.nextSearchURL != nil)
            
            DTLog("Get for users from caches with key \(key)")
        }
        else {
            DTLog("Searching for users with key \(key)")
            BDFAuthenticatedUser.currentUser.searchUserWithName(key, nextPageString: nil, successBlock: { (users: [User]?, nextPageURL :String?) in
                // Update current key
                self._currentKey = key
                
                // Reload table view
                if let newUsers = users {
                    //Refresh search results
                    let item = SearchItem()
                    item.users = newUsers
                    item.nextSearchURL = nextPageURL
                    self._currentSearchItem = item
                    self._searchCaches[key] = item
                    self.tableNode.view.reloadData()
                }
                }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    // Failure do nothing
                    
            })
        }
    }
    
    //MARK: BDSearchBarDelegate
    func searchBarDidChangeText(searchBar: BDSearchBar, text: String) {
        //Waiting for next char
        tableNode.view.shouldAnimating = false
        _typingTimer?.invalidate()
        _typingTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(self.dynamicType.searchUser), userInfo: nil, repeats: false)
    }
    
    func searchBarDidClearText(searchBar: BDSearchBar) {
        _typingTimer?.invalidate()
        _currentSearchItem = nil
        tableNode.view.shouldAnimating = false
        tableNode.view.reloadData()
    }
    
    //MARK: ASTableDataSource + ASTableDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = _currentSearchItem {
            if item.users.count == 0 {
                // Return place holder node
                return 1
            }
            
            return item.users.count
        }
        
        // Empty list
        return 0
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        if let item = _currentSearchItem {
            if item.users.count == 0 {
                // Return place holder node
                let node = DTTextCellNode(font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Center, textInsets: UIEdgeInsets(top: 22.5, left: 0, bottom: 22.5, right: 0))
                node.setStaticHeight(true, height: 60)
                node.text = "No users found with \"\(_currentKey!)\""
                return node
            }
            
            let user = item.users[indexPath.row]
            return {
                return UserListNode(user: user)
            }()
        }
        
        // This should never be called
        return UserListNode(user: BDFAuthenticatedUser.currentUser)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let user = _currentSearchItem?.users[indexPath.row] else {
            return
        }
        
        if type == .Search {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let profileViewController = ProfileViewController()
            profileViewController.user = user
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
        else if type == .Message {
            delegate?.searchViewControllerDidSelectUser(self, user: user)
        }
    }
}

//MARK: LoadingManagerDelegate
extension SearchViewController: LoadingManagerDelegate {
    func loadingManagerLoaderDidStartAnimating(loadingManager: LoadingManager) {
        // Load more users from next page
        if let next = _currentSearchItem?.nextSearchURL {
            if let name = _currentKey {
                BDFAuthenticatedUser.currentUser.searchUserWithName(name, nextPageString: next, successBlock: { (users: [User]?, nextSearchURL: String?) in
                    //Enable after every call
                    self.tableNode.view.shouldAnimating = true
                    
                    // Update table view
                    if let currentUsers = self._currentSearchItem?.users {
                        if let newUsers = users {
                            if newUsers.count > 0 {
                                var indexPaths = [NSIndexPath]()
                                let count = currentUsers.count
                                for row in count...(count + newUsers.count - 1) {
                                    let indexPath = NSIndexPath(forRow: row, inSection: 0)
                                    indexPaths.append(indexPath)
                                }
                                
                                // Update
                                self._currentSearchItem?.users = currentUsers + newUsers
                                self._currentSearchItem?.nextSearchURL = next
                                // Update caches
                                self._searchCaches[name] = self._currentSearchItem
                                
                                // Update table view
                                self.tableNode.view.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                            }
                            else {
                                // No more loading if cannot load any more users
                                self._currentSearchItem?.nextSearchURL = nil
                                
                                // Update caches
                                self._searchCaches[name] = self._currentSearchItem
                                
                                self.tableNode.view.shouldAnimating = false
                            }
                        }
                    }
                    
                    // Stop loading
                    self.tableNode.view.stopLoading()
                    
                    }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                        // Stop loading
                        self.tableNode.view.stopLoading()
                        
                        // Failure
                        self._currentSearchItem?.nextSearchURL = next
                        // Update caches
                        self._searchCaches[name] = self._currentSearchItem
                        if let _ = errorCode {
                            self.tableNode.view.shouldAnimating = false
                        }
                        else {
                            self.tableNode.view.shouldAnimating = true
                        }
                })
            }
        }
    }
}

private class SearchItem {
    var users: [User]!
    var nextSearchURL: String?
}


