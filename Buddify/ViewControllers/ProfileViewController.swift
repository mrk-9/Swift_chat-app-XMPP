//
//  ProfileViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 10/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import LoremIpsum
import FBSDKShareKit
import Models

private let kBarHeight : CGFloat = 38

private let kLikeIconSize : CGFloat = 17
private let postIndex = 1
private let infoIndex = 0
private let kProfileImageHeightOnWidthRatio: CGFloat = 0.75 //Ratio of height/width of profile photo

class ProfileViewController: ASViewController, PagerViewControllerDelegate, UIScrollViewDelegate, TabbarItemDelegate, FBSDKAppInviteDialogDelegate {
    //Public variables
    var userId: Int64! {
        return user.userId
    }
    
    var user: User!
    
    private let _scrollNode: ASScrollNode = ASScrollNode()
    
    //First content offset is 0 for both scroll views
    private var _previousOffset: [CGFloat] = [0, 0]
    
    //Private
    private var _profilePostViewController: ProfilePostViewController!
	private var _pagerViewController: PagerViewController!
    private var _profileInfoViewController: ProfileInfoViewController!
    private let _postsContext = UnsafeMutablePointer<Void>(nil)
	private let _infoContext = UnsafeMutablePointer<Void>(nil)
    private var _collectionViews: [ASCollectionView]!
    private var _profileInfoNode: ProfileInfoNode!
    
    // First time load the view, default value if true
    private var isFirstLoad = true
    
    init() {
        
        super.init(node: _scrollNode)
        
        self.edgesForExtendedLayout = UIRectEdge.Bottom
		
        _scrollNode.view.delegate = self
        _scrollNode.view.addRefreshControl(self, action: #selector(self.dynamicType.refresh), tintColor: UIColor.appPurpleColor())
        
        _profilePostViewController = ProfilePostViewController()
        _profileInfoViewController = ProfileInfoViewController()
        _collectionViews = [ASCollectionView]()
        
        _profilePostViewController.collectionNode.view.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        _profileInfoViewController.collectionNode.view.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    deinit {
        _profilePostViewController.collectionNode.view.removeObserver(self, forKeyPath: "contentSize")
        _profileInfoViewController.collectionNode.view.removeObserver(self, forKeyPath: "contentSize")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentSize" {
            if let collectionView = object as? ASCollectionView {
                if collectionView == _profilePostViewController.collectionNode.view {
                    if _pagerViewController.selectedIndex == postIndex {
                        self.updateScrollViewWithCollectionView(_profilePostViewController.collectionNode.view)
                    }
                }
                else {
                    if _pagerViewController.selectedIndex == infoIndex {
                        self.updateScrollViewWithCollectionView(_profileInfoViewController.collectionNode.view)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
		view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        _scrollNode.view.alwaysBounceVertical = true
        
        // Synchonize the user object if it is current logged in user
        if user.isIdentical(BDFAuthenticatedUser.currentUser) && user !== BDFAuthenticatedUser.currentUser {
            user = BDFAuthenticatedUser.currentUser
        }
        
        //Child view controllers
        _profilePostViewController.userId = self.userId
        _profilePostViewController.title = "Activities"
        _profilePostViewController.collectionNode.view.scrollEnabled = false
        
        _profileInfoViewController.title = "Info"
        _profileInfoViewController.collectionNode.view.scrollEnabled = false
        
        _pagerViewController = PagerViewController.init(viewControllers: [_profileInfoViewController, _profilePostViewController])
        _pagerViewController.delegate = self
        addChildViewController(_pagerViewController)
        _pagerViewController.didMoveToParentViewController(self)
        
        _collectionViews.append(_profileInfoViewController.collectionNode.view)
        _collectionViews.append(_profilePostViewController.collectionNode.view)
        
        _profileInfoNode = ProfileInfoNode(user: user)
        _profileInfoNode.delegate = self
        _profileInfoNode.measureWithSizeRange(ASSizeRange(min: CGSize(width: node.bounds.size.width, height: 0), max: CGSize(width: node.bounds.size.width, height: node.bounds.size.width * kProfileImageHeightOnWidthRatio)))
        _profileInfoNode.frame = CGRect(origin: CGPointZero, size: _profileInfoNode.calculatedSize)
        self.node.addSubnode(_profileInfoNode)
        
        //Pager controller
        _pagerViewController.view.frame = CGRect(x: 0, y: profileInfoNodeHeight(), width: self.node.frame.size.width, height: self.node.frame.size.height)
        self.view.addSubview(_pagerViewController.view)
        self.addBarButtonItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFirstLoad {
            isFirstLoad = false
            self.loadUserInfo()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func profileInfoNodeHeight() -> CGFloat {
        //Return info node height
        return CGRectGetHeight(_profileInfoNode.frame)
    }
    
    private func addBarButtonItems() {
        if BDFAuthenticatedUser.currentUser.isIdentical(self.user) {
            //Settings button
            let settingsButton = HighLightButton(image: UIImage.settingIcon(size: CGSize(width: 25, height: 25), color: UIColor.whiteColor()), alignment: UIControlContentHorizontalAlignment.Right)
            settingsButton.addTarget(self, action: #selector(ProfileViewController.settingsButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
            let rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
            
            //If it is the first view controller in navigation controller
            if self.navigationController?.viewControllers[0] == self {
                //Add invite button
                let inviteButton = HighLightButton(image: UIImage.likeIconSolid(size: CGSize(width: 20, height: 20), color: UIColor.whiteColor()), alignment: UIControlContentHorizontalAlignment.Left)
                inviteButton.addTarget(self, action: #selector(ProfileViewController.inviteFriendsButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
                let leftBarButtonItem = UIBarButtonItem(customView: inviteButton)
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        }
        else {
            //Settings button
            let moreButton = HighLightButton(image: UIImage.moreIcon(size: CGSize(width: 25, height: 5), color: UIColor.whiteColor()), alignment: UIControlContentHorizontalAlignment.Right)
            moreButton.addTarget(self, action: #selector(ProfileViewController.moreButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
            let rightBarButtonItem = UIBarButtonItem(customView: moreButton)
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    private func updateScrollViewWithCollectionView(collectionView: ASCollectionView) {
        _scrollNode.view.contentSize.height = collectionView.contentSize.height + profileInfoNodeHeight() + _pagerViewController.segmentedBarHeight + collectionView.contentInset.bottom + collectionView.contentInset.top
    }
    
    private func moveToContentOffsetFromMainScrollView(offset: CGFloat, collectionView: ASCollectionView) {
        var _offset = offset
        if _offset < profileInfoNodeHeight() {
            _offset = profileInfoNodeHeight()
        }
        collectionView.contentOffset.y = _offset - profileInfoNodeHeight()
        _scrollNode.view.contentOffset.y = _offset
    }
    
    //MARK: Button methods
    internal func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    internal func inviteFriendsButtonTapped() {
        let content = FBSDKAppInviteContent()
        content.appLinkURL = NSURL(string: String.facebookAppLink())
        content.appInvitePreviewImageURL = nil
        FBSDKAppInviteDialog.showFromViewController(self, withContent: content, delegate: self)
    }
    
    internal func moreButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let reportButton = UIAlertAction(title: "Report user", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            // Report user
            let alertController = UIAlertController(title: nil, message: "Do you want to report this user?", preferredStyle: UIAlertControllerStyle.Alert)
            let blockButton = UIAlertAction(title: "Report", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                // Send request
                BDFAuthenticatedUser.currentUser.reportUserWithUserId(self.userId, successBlock: {
                    // show confirmation alert
                    let alertController = UIAlertController(title: nil, message: "This user has been reported", preferredStyle: UIAlertControllerStyle.Alert)
                    let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:nil)
                    alertController.addAction(cancelButton)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                        // Show error alert
                        let alertController = UIAlertController(title: nil, message: "Something went wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                        let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:nil)
                        alertController.addAction(cancelButton)
                        self.presentViewController(alertController, animated: true, completion: nil)
                })
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(blockButton)
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
        })
        
        let blockButton = UIAlertAction(title: "Block user", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            let alertController = UIAlertController(title: nil, message: "Do you really want to block this user? You and him will not be able to see each other unless you unblock him.", preferredStyle: UIAlertControllerStyle.Alert)
            let blockButton = UIAlertAction(title: "Block", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                BDFAuthenticatedUser.currentUser.blockUserWithUserId(self.userId, successBlock: { 
                    // show confirmation alert
                    let alertController = UIAlertController(title: nil, message: "This user has been blocked. You can unblock users in your profile settings.", preferredStyle: UIAlertControllerStyle.Alert)
                    let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:{ (action) -> Void in
                        // Pop view controller
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                    alertController.addAction(cancelButton)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                        // Show error alert
                        let alertController = UIAlertController(title: nil, message: "Something went wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                        let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:nil)
                        alertController.addAction(cancelButton)
                        self.presentViewController(alertController, animated: true, completion: nil)
                })
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
            })
            alertController.addAction(blockButton)
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
        })
        
        alertController.addAction(reportButton)
        alertController.addAction(blockButton)
        alertController.addAction(cancelButton)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= profileInfoNodeHeight() {
            _pagerViewController.view.frame.origin.y = scrollView.contentOffset.y
            
            if _pagerViewController.selectedIndex == postIndex {
                _profilePostViewController.collectionNode.view.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y - profileInfoNodeHeight())
            }
            else {
                _profileInfoViewController.collectionNode.view.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y - profileInfoNodeHeight())
            }
        }
        else {
            _profileInfoViewController.collectionNode.view.contentOffset = CGPointZero
            _collectionViews[_pagerViewController.selectedIndex].contentOffset = CGPointZero
            _pagerViewController.view.frame.origin.y = profileInfoNodeHeight()
            
            // Make parallax effect on profile photo from profile info cell
            if scrollView.contentOffset.y < 0 {
                _profileInfoNode.profilePhotoNode.frame.origin.y = scrollView.contentOffset.y/2
            }
            else {
                _profileInfoNode.profilePhotoNode.frame.origin.y = 0
            }
        }
    }
    
    //MARK: TabbarItemDelegate
    func viewControllerScrollViewGoesToTop() {
        _scrollNode.view.setContentOffset(CGPointZero, animated: true)
    }
    
    //MARK: PagerViewControllerDelegate
    func pagerViewControllerSelectedIndexDidChange(pagerViewController: PagerViewController, selectedIndex: Int) {
        if _scrollNode.view.contentOffset.y < profileInfoNodeHeight() {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                if self._previousOffset[selectedIndex] <= self.profileInfoNodeHeight() {
                    self._scrollNode.view.contentOffset.y = self._previousOffset[selectedIndex]//self.profileInfoNodeHeight()
                }
                else {
                    self._scrollNode.view.contentOffset.y = self._previousOffset[selectedIndex]
                }
            })
        }
        else {
            if _previousOffset[selectedIndex] <= profileInfoNodeHeight() {
                _scrollNode.view.contentOffset.y = profileInfoNodeHeight()
            }
            else {
                _scrollNode.view.contentOffset.y = _previousOffset[selectedIndex]
            }
        }
    }
    
    func pagerViewControllerSelectedIndexProbablyChange(pagerViewController: PagerViewController, oldSelectedIndex: Int, newSelectedIndex: Int) {
        //Save previous offset
        _previousOffset[oldSelectedIndex] = _scrollNode.view.contentOffset.y
        
        //Prepare correct content size
        _scrollNode.view.contentSize.height = _collectionViews[newSelectedIndex].contentSize.height + _pagerViewController.segmentedBarHeight + profileInfoNodeHeight()
        
        if _previousOffset[newSelectedIndex] > profileInfoNodeHeight() {
            _collectionViews[newSelectedIndex].contentOffset.y = _previousOffset[newSelectedIndex] - profileInfoNodeHeight()
        }
        else {
            _collectionViews[newSelectedIndex].contentOffset.y = 0
        }
    }
    
//    func pagerViewControllerSelectedIndexWillChange(pagerViewController: PagerViewController, oldSelectedIndex: Int, newSelectedIndex: Int) {
////        /* Check if not scroll on top */
//        previousOffset[oldSelectedIndex] = self.scrollNode.view.contentOffset.y
//        
//        
//    }

    //Like bar button tapped
	func likeButtonTapped(button: UIButton) {
		button.selected = !button.selected
	}
    
    //MARK: FBSDKAppInviteDialogDelegate
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        
    }
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        
    }
}

extension ProfileViewController {
    // Make an API call to get user information
    private func loadUserInfo() {
        if BDFAuthenticatedUser.currentUser.isIdentical(self.user) {
            BDFAuthenticatedUser.currentUser.getCurrentUserInformation(successBlock: { (newUser: User) in
                self.user.updateInformation(newUser)
                }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    
            })
        }
        else {
            BDFAuthenticatedUser.currentUser.getUserInformationWithUserId(self.user.userId, successBlock: { (newUser: User) in
                self.user.updateInformation(newUser)
            }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                
            }
        }
    }
    
    // Refresh current profile view
    func refresh() {
        if _pagerViewController.selectedIndex == 0 {
            // Refresh info
            self._scrollNode.view.refreshControl?.endRefreshing()
        }
        else {
            // Refresh posts
            _profilePostViewController.refreshData({ (finished: Bool) in
                self._scrollNode.view.refreshControl?.endRefreshing()
            })
        }
    }
}

//MARK: ProfileInfoNodeDelegate
extension ProfileViewController: ProfileInfoNodeDelegate {
    func profileInfoNodeDidTapFriendStatusButton(node: ProfileInfoNode) {
        
        if self.user.friendStatus == .NotFriend {
            self.sendFriendRequest()
        }
        else if self.user.friendStatus == .Friend {
            // Show unfriend action sheet
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            // Unfriend button
            let unfriendButton = UIAlertAction(title: "Unfriend", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.unfriend()
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
            })
            
            alertController.addAction(unfriendButton)
            alertController.addAction(cancelButton)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if self.user.friendStatus == .RequestSent {
            // Show cancel friend request sheet
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            // Cancel friend request
            let cancelRequestButton = UIAlertAction(title: "Cancel friend request", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.cancelMyFriendRequest()
            })
            
            // Cancel
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            
            alertController.addAction(cancelRequestButton)
            alertController.addAction(cancelButton)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if self.user.friendStatus == .RequestReceived {
            // Show cancel friend request sheet
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            // Accept friend request
            let acceptRequestButton = UIAlertAction(title: "Accept friend request", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.acceptFriendRequest()
            })
            
            // Delete friend request
            let deleteRequestButton = UIAlertAction(title: "Delete friend request", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.unfriend()
            })
            
            // Cancel button
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            
            alertController.addAction(acceptRequestButton)
            alertController.addAction(deleteRequestButton)
            alertController.addAction(cancelButton)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func profileInfoNodeDidTapSendMessageButton(node: ProfileInfoNode) {
        let chatViewController = ChatViewController()
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}

// MARK: Friend Status
extension ProfileViewController {
    // This is a helper method that return the title for Friend button based on friend status
    private func titleBasedOnFriendStatus() -> String {
        switch user.friendStatus {
        case BDFFriendStatus.NotFriend:
            return "Add as friend"
            
        case BDFFriendStatus.Friend:
            return "Friends"
            
        case BDFFriendStatus.RequestSent:
            return "Friend request sent"
            
        case BDFFriendStatus.RequestReceived:
            return "Friend request received"
        }
    }
    
    private func actionTitleBasedOnFriendStatus() -> String {
        switch user.friendStatus {
        case BDFFriendStatus.NotFriend:
            return "Add as friend"
            
        case BDFFriendStatus.Friend:
            return "Unfriend"
            
        case BDFFriendStatus.RequestSent:
            return "Cancel request"
            
        case BDFFriendStatus.RequestReceived:
            return "Respond to request" // Delete or Accept
        }
    }
    
    private func friendStatusToString() -> String {
        switch user.friendStatus {
        case BDFFriendStatus.NotFriend:
            return "Not friend"
            
        case BDFFriendStatus.Friend:
            return "Friends"
            
        case BDFFriendStatus.RequestSent:
            return "Request sent"
            
        case BDFFriendStatus.RequestReceived:
            return "Request received" // Delete or Accept
        }
    }
    
    private func sendFriendRequest() {
        BDFAuthenticatedUser.currentUser.sendFriendRequetsToUserWithUserId(user.userId, successBlock: { 
            // Change friend status
            self.user.friendStatus = BDFFriendStatus.RequestSent
            DTLog(self.friendStatusToString())
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Handle error
        }
    }
    
    private func unfriend() {
        BDFAuthenticatedUser.currentUser.unfriendUserWithUserId(user.userId, successBlock: {
            // Change friend status
            self.user.friendStatus = BDFFriendStatus.NotFriend
            DTLog(self.friendStatusToString())
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Handle error
        }
    }
    
    private func acceptFriendRequest() {
        BDFAuthenticatedUser.currentUser.deleteFriendRequestFromUserWithUserId(user.userId, successBlock: {
            // Change friend status
            self.user.friendStatus = BDFFriendStatus.Friend
            DTLog(self.friendStatusToString())
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Handle error
        }
    }
    
    private func declineFriendRequest() {
        BDFAuthenticatedUser.currentUser.deleteFriendRequestFromUserWithUserId(user.userId, successBlock: {
            // Change friend status
            self.user.friendStatus = BDFFriendStatus.NotFriend
            DTLog(self.friendStatusToString())
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Handle error
        }
    }
    
    private func cancelMyFriendRequest() {
        BDFAuthenticatedUser.currentUser.cancelMyFriendRequestToUserWithUserId(user.userId, successBlock: {
            // Change friend status
            self.user.friendStatus = BDFFriendStatus.NotFriend
            DTLog(self.friendStatusToString())
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Handle error
        }
    }
}
