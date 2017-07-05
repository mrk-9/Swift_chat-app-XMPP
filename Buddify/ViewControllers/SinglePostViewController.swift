//
//  SinglePostViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 15/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import SlackTextViewController
import LoremIpsum
import Models

private let kToolBarHeight: CGFloat = 44

class SinglePostViewController: ASViewController, SLKTextViewDelegate, HPGrowingTextViewDelegate {
    var post: Post!
    
    private var tableNode: ASTableNode
    private var _dataSource: SinglePostDataSource!
    private var _commentToolBar: InputToolbar!
    private var _isFirstLoad = true
    private var _tableViewTapGesture: UITapGestureRecognizer!
    
    // This flag indicates that the view is already deleted
    // Only change this value in BDFPostUIUpdater delegate method
    // Default value should be false
    private var _isDeleted = false
    
    init() {
        let node = ASDisplayNode()
        tableNode = ASTableNode()
        tableNode.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        super.init(node: node)
        self.hidesBottomBarWhenPushed = true
        self.node.backgroundColor = UIColor.appScrollViewBackgrouncColor()
    }
    
    deinit {
        BDFUIUpdaterManager.sharedManager.removePostUIUpdater(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.setUpViewControllerExpands()
        self.hidesBottomBarWhenPushed = true
        
        let button = HighLightButton(image: UIImage.moreIcon(size: CGSize(width: 25, height: 5), color: UIColor.whiteColor()), highlightedImage: UIImage.moreIcon(size: CGSize(width: 25, height: 5), color: UIColor.whiteColor().colorWithAlphaComponent(0.5)), alignment: UIControlContentHorizontalAlignment.Right)
        button.addTarget(self, action: #selector(SinglePostViewController.moreButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Post"
        
        _dataSource = SinglePostDataSource(tableNode: tableNode, viewController: self)
        _dataSource.postId = post.postId
        _dataSource.post = post
        tableNode.view.addRefreshControl(self, action: #selector(SinglePostViewController.refresh(_:)), tintColor: UIColor.appPurpleColor())
        tableNode.view.alwaysBounceVertical = true
        
        //Create tool bar
        _commentToolBar = InputToolbar(frame: CGRect(x: 0, y: self.view.bounds.size.height - kToolBarHeight - 64, width: self.view.bounds.size.width, height: kToolBarHeight))
        _commentToolBar.addSidedBorder(color: UIColor.grayColor(), thickness: 0.5)
        _commentToolBar.delegate = self
        _commentToolBar.sendButton.addTarget(self, action: #selector(SinglePostViewController.rightButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        _commentToolBar.sendButton.setImage(UIImage.airPlaneIcon(size: CGSize(width: 20, height: 20), color: UIColor.appPurpleColor()), forState: UIControlState.Normal)
        _commentToolBar.sendButton.setImage(UIImage.airPlaneIcon(size: CGSize(width: 20, height: 20), color: UIColor.appLightTextColor()), forState: UIControlState.Disabled)
        _commentToolBar.sendButton.enabled = false
        
        tableNode.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - kToolBarHeight - 64)
        self.view.addSubnode(tableNode)
        self.view.addSubview(_commentToolBar)
        
        //Create tap gesture to dismiss keyboard
        _tableViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(SinglePostViewController.tapToDismissKeyboard(_:)))
        _tableViewTapGesture.enabled = false
        self.tableNode.view.addGestureRecognizer(_tableViewTapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        _commentToolBar.resignFirstResponder()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SinglePostViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        _dataSource.loadComments()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if _isDeleted {
            self._notifyPostDeleted()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        _commentToolBar.resignFirstResponder()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        // Notify post info changes before go to other view
        _dataSource.notifyPostInfoChanges()
        
        // Only add UI Updater when going to another view
        // In case pop view controller, deinit will take care of removing it
        BDFUIUpdaterManager.sharedManager.addPostUIUpdater(self)
    }
    
    //MARK: Action methods
    //MARK: Keyboard frame change notification
    internal func moreButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        if BDFAuthenticatedUser.currentUser.isIdentical(post.owner) {
            let deleteButton = UIAlertAction(title: "Delete post", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                BDFAuthenticatedUser.currentUser.deletePost(self.post.postId, successBlock: {
                    // Pop view controller
                    self._notifyPostDeleted()
                    
                    // Notify post deleted
                    BDFUIUpdaterManager.sharedManager.postDeleted(self.post)
                    
                    }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    
                })
            })
            alertController.addAction(deleteButton)
        }
        else {
            let reportButton = UIAlertAction(title: "Report post", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                // Report post
                BDFAuthenticatedUser.currentUser.reportPost(self.post.postId, successBlock: { 
                    // Confirmation alert
                    let alertController = UIAlertController(title: nil, message: "This post has been reported", preferredStyle: UIAlertControllerStyle.Alert)
                    let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:nil)
                    alertController.addAction(cancelButton)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                        // Error alert
                        let alertController = UIAlertController(title: nil, message: "Something went wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                        let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:nil)
                        alertController.addAction(cancelButton)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                })
            })
            alertController.addAction(reportButton)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
        })
        alertController.addAction(cancelButton)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Update frame of table view when keyboard changes frame
    internal func keyboardWillChangeFrame(notification : NSNotification){
        var userInfo = notification.userInfo!
        
        let frameEnd = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        //Change tool bar frame
        var toolbarFrame = self._commentToolBar.frame
        toolbarFrame.origin.y = frameEnd.origin.y - toolbarFrame.size.height - (self.navigationController?.navigationBar.translucent ?? true ? 0 : 64)
        
        // If keyboard is visible, enable table view tap gesture
        // otherwise disable it
        if frameEnd.origin.y == CGSize.screenSize.height {
            _tableViewTapGesture.enabled = false
        }
        else {
            _tableViewTapGesture.enabled = true
        }
        
        var tableViewFrame = tableNode.frame
        tableViewFrame.size.height = frameEnd.origin.y - toolbarFrame.size.height - 64
        
        //Change share bar frame
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.unsignedIntValue
        
        UIView.animateWithDuration(
            userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue,
            delay: 0,
            options: UIViewAnimationOptions(rawValue: UInt(curve)),
            animations: {
                self._commentToolBar.frame = toolbarFrame
                self.tableNode.view.frame = tableViewFrame
                self.node.setNeedsDisplay()
            },
            completion: nil)
    }
    
    internal func refresh(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        self.tableNode.view.setContentOffset(CGPointZero, animated: true)
    }
    
    internal func rightButtonTapped() {
        //If the text view is not empty
        if !_commentToolBar.text.isEmpty {
            let comment = _commentToolBar.text
            _commentToolBar.text = ""
            let user = BDFAuthenticatedUser.currentUser
            _dataSource.addNewComment(comment, fromUser: user)
        }
    }
    
    internal func tapToDismissKeyboard(recognizer: UITapGestureRecognizer){
        _commentToolBar.resignFirstResponder()
    }
    
    private func _notifyPostDeleted() {
        let alertController = UIAlertController(title: nil, message: "Post deleted", preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (action) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okButton)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: HPGrowingTextViewDelegate
    func growingTextView(growingTextView: HPGrowingTextView!, willChangeHeight height: CGFloat) {
        let difference = CGRectGetHeight(growingTextView.frame) - height
        var rect = self._commentToolBar.frame
        rect.size.height -= difference
        rect.origin.y += difference
        
        var tableViewFrame = tableNode.frame
        tableViewFrame.size.height += difference
        
        var offset = tableNode.view.contentOffset
        offset.y -= difference
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self._commentToolBar.frame = rect
            self.tableNode.frame = tableViewFrame
            self.tableNode.view.contentOffset = offset
            }) { (finished) -> Void in
                
        }
    }
    
    internal func growingTextViewShouldReturn(growingTextView: HPGrowingTextView!) -> Bool {
        growingTextView.resignFirstResponder()
        return true
    }
    
    internal func growingTextView(growingTextView: HPGrowingTextView!, shouldChangeTextInRange range: NSRange, replacementText text: String!) -> Bool {
//        let string = (growingTextView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
//        let left = maxNumberOfChars - string.characters.count
//        if left >= 0 {
//            self.inputToolbar.counterLabel.text = String(left)
//            return true
//        }
//        return false
        return true
    }
    
    func growingTextViewDidBeginEditing(growingTextView: HPGrowingTextView!) {
        //Scroll table view to bottom
        let newOffset = self.tableNode.view.contentSize.height - self.tableNode.view.frame.size.height
        
        // Prevent scrolling beyond top bound because of small content size
        if newOffset > 0 {
            self.tableNode.view.setContentOffset(CGPoint(x: 0, y: self.tableNode.view.contentSize.height - self.tableNode.view.frame.size.height), animated: true)
        }
    }
    
    func growingTextViewDidChange(growingTextView: HPGrowingTextView!) {
        if growingTextView.text.isEmpty {
            _commentToolBar.sendButton.enabled = false
        }
        else {
            _commentToolBar.sendButton.enabled = true
        }
    }
    
    func growingTextViewDidChangeSelection(growingTextView: HPGrowingTextView!) {
        //let cursorPosition = growingTextView.selectedRange.location
        //var name : String = ""
        //let data = growingTextView.text.dataUsingEncoding(NSNonLossyASCIIStringEncoding, allowLossyConversion: false)
        //let newString = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
//        let string = growingTextView.text
//        let correctPosition = string.composedPositionFromPosition(cursorPosition)
//        if correctPosition > 0 {
//            for var i = correctPosition; i >= 0; i-- {
//                let index = string.startIndex.advancedBy(i)
//                let char = growingTextView.text[index]
//                if Validation.usernameAcceptableCharacters.contains(String(char)) {
//                    name.insert(char, atIndex: string.startIndex.advancedBy(0))
//                }
//                else if char == "@" {
//                    suggestionIndex = mentionIndex
//                    suggestionTableView.hidden = false
//                    self.filterFollowingListWithName(name)
//                    return
//                }
//                else if char == "#" {
//                    suggestionIndex = hashtagIndex
//                    suggestionTableView.hidden = false
//                    self.filterHashTagListWithString(name)
//                    return
//                }
//                else {
//                    suggestionTableView.hidden = true
//                    return
//                }
//            }
//        }
//        suggestionTableView.hidden = true
    }
}

//MARK: BDFPostUIUpdater
extension SinglePostViewController: BDFPostUIUpdater {
    func updaterUpdateUIWithPost(post: Post) {
        // Update post info
        if post.isIdentical(self.post) {
            self.post.numberOfLikes = post.numberOfLikes
            self.post.liked = post.liked
            self.post.numberOfComments = post.numberOfComments
        }
    }
    
    func updaterDeletePost(post: Post) {
        if post.isIdentical(self.post) {
            // Flag the view controller that this post is deleted
            // So when this view did appear, notify user and get out of the view
            self._isDeleted = true
        }
    }
}
