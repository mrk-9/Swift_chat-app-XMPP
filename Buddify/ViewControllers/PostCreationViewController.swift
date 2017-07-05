//
//  PostCreationViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 22/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import LoremIpsum
import Models
import KVNProgress

private let cellIdentifier = "Cell"

class PostCreationViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var _postButton: UIButton!
    private var _keyboardManager: KeyboardManager!
    
    private var cell: PostCreationCell!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New post"
        
        self.tableView.registerNib(UINib.init(nibName: "PostCreationCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.separatorStyle = .None
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        
        //Keyboard manager
        _keyboardManager = KeyboardManager(view: self.tableView, originalHeight: self.tableView.frame.size.height - 44)
        
        _postButton = UIButton.barButtonItemWithTitle("Post", alignment: UIControlContentHorizontalAlignment.Right)
        _postButton.enabled = false
        _postButton.addTarget(self, action: #selector(PostCreationViewController.postButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: _postButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let cancelButton = HighLightButton(image: UIImage.cancelIcon(size: CGSize(width: 15, height: 15), color: UIColor.whiteColor()), alignment: UIControlContentHorizontalAlignment.Left)
        cancelButton.addTarget(self, action: #selector(PostCreationViewController.cancelButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        _keyboardManager.startObserving()
        cell.statusTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCreationCell
        cell.delegate = self
        
        // Configure cell
        cell.nameLabel.font = UIFont.boldAppFont(CGFloat.normalFontSize)
        cell.statusTextView.font = UIFont.appFont(CGFloat.normalFontSize)
        cell.photoButton.setTitleColor(UIColor.appPurpleColor(), forState: UIControlState.Normal)
        cell.statusTextView.text = cell.statusTextView.text
        cell.statusTextView.textColor = UIColor.blackColor()
        cell.statusTextView.font = UIFont.appFont(CGFloat.normalFontSize)
        cell.statusTextView.placeholderColor = UIColor.appLightTextColor()
        cell.statusTextView.placeholder = "Write something nice..."
        cell.statusTextView.tintColor = UIColor.appPurpleColor()
        
        cell.nameLabel.text = BDFAuthenticatedUser.currentUser.name
        cell.nameLabel.font = UIFont.boldAppFont(CGFloat.normalFontSize)
        cell.nameLabel.textColor = UIColor.blackColor()
        
        cell.counterLabel.font = UIFont.appFont(CGFloat.smallFontSize)
        cell.counterLabel.textColor = UIColor.appLightTextColor()
        
        let imageURL = NSURL(string: BDFAuthenticatedUser.currentUser.photoThumbnails[0])!
        ASPINRemoteImageDownloader.sharedDownloader().downloadImageWithURL(imageURL, callbackQueue: dispatch_get_main_queue(), downloadProgress: nil) { (container: ASImageContainerProtocol?, error: NSError?, object: AnyObject?) in
            cell.profileImageView.image = container?.asdk_image()
        }
        
        self.cell = cell
        return cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        _keyboardManager.stopObserving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func postButtonTapped() {
        cell.statusTextView.endEditing(true)
        
        var caption: String?
        
        //Check if there is status
        if let text = cell.status() {
            caption = text
        }
        
        // Show status
        KVNProgress.showWithStatus("Posting...")
        
        BDFAuthenticatedUser.currentUser.createNewPostWith(caption, image: self.cell.postImage(), progressBlock: { (progress: NSProgress) in
            // Handle progress
            dispatch_async_main_queue({ 
                KVNProgress.updateProgress(CGFloat(progress.fractionCompleted), animated: true)
            })
            
            }, successBlock: { (post: Post) in
                // Show status
                KVNProgress.showSuccessWithStatus("Success", completion: { 
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                // Success call
                // Notify the app that a new post is created
                BDFUIUpdaterManager.sharedManager.newPostPosted(post)
                
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Show status
            if error?.code == NSURLErrorNotConnectedToInternet {
                KVNProgress.showErrorWithStatus("No intenet connection available. Please try again.")
            }
            else {
                KVNProgress.showErrorWithStatus("Posting failed. Please try again.")
            }
            
            
            // Handle error code
            DTLog(error?.description)
        }
    }
    
    internal func cancelButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage!
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = image
        }
        else {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                newImage = image
            }
        }
        
        self.cell.updateImage(newImage)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension PostCreationViewController: PostCreationCellDelegate {
    func addPhotoButtonTapped() {
        //Image picker
        let alertController = UIAlertController.imagePickerAlertController(delegate: self, viewController: self, galleryAllowsEditing: false, cameraAllowsEditing: true)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func postCreationCellPostImageViewTapped(cell: PostCreationCell) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let replaceButton = UIAlertAction(title: "Change photo", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.addPhotoButtonTapped()
        })
        
        let removeButton = UIAlertAction(title: "Remove photo", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.cell.updateImage(nil)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
        })
        
        alertController.addAction(replaceButton)
        alertController.addAction(removeButton)
        alertController.addAction(cancelButton)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func postCreationCellPostStatusDidChange(cell: PostCreationCell, status: String?) {
        if let _ = self.cell.postImage() {
            
        }
        else {
            guard let _ = status else {
                _postButton.enabled = false
                return
            }
            
            _postButton.enabled = true
        }
    }
    
    func postCreationCellAddPhotoButtonTapped(cell: PostCreationCell) {
        self.addPhotoButtonTapped()
    }
    
    func postCreationCellNeedsHeightUpdate(cell: PostCreationCell) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
