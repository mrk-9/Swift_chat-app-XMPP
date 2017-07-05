//
//  SettingsViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 25/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import LoremIpsum
import uservoice_iphone_sdk
import FBSDKLoginKit
import Models
import AFDateHelper
import KVNProgress

private let contentVerticalInset: CGFloat = 20

// Section 0
private let kGeneralInfo = 0
private let kUsername = 1
private let kGender = 2
private let kBirthdate = 3
private let kProfileInfo = 4
private let kPrivacySettings = 5
private let kChangePassword = 6
private let kFacebookConnect = 7

// Section 1
private let kRateUs = 0
private let kFeedback = 1
private let kReportBug = 2
private let kRecommendFeature = 3

// Section 2
private let kTermOfService = 0
private let kPrivacyPolicy = 1
private let kBlockedUsers = 2
private let kVersion = 3
private let kLogOut = 4

///
/// Class SettingsViewController
///
class SettingsViewController: ASViewController, ASTableDataSource, ASTableDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let tableNode = ASTableNode(style: UITableViewStyle.Grouped)
    
    private var _saveButton: HighLightButton = HighLightButton(title: "Save", alignment: UIControlContentHorizontalAlignment.Right)
    private let _profileInfoNode: SettingsProfileInfoNode
    private var _newProfileImage: UIImage?
    
    // Date formatter to convert date to string
    private let _dateFormatter = NSDateFormatter()
    
    // Private flags which indicate which information have been changed
    private var _isNameEdited = false
    
    init() {
        _profileInfoNode = SettingsProfileInfoNode(user: BDFAuthenticatedUser.currentUser)
        _profileInfoNode.nameTextField.tintColor = UIColor.appPurpleColor()
        
        super.init(node: tableNode)
        
        _profileInfoNode.nameTextField.delegate = self
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        self.hidesBottomBarWhenPushed = true
        self.title = "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _profileInfoNode.profilePhotoNode.addTarget(self, action: #selector(SettingsViewController.profilePhotoNodeTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        _saveButton.addTarget(self, action: #selector(SettingsViewController.saveButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let barButtonItem = UIBarButtonItem(customView: _saveButton)
        self.navigationItem.rightBarButtonItem = barButtonItem
        _saveButton.enabled = false
        
        // Date formatter
        _dateFormatter.dateFormat = ""
        
        UVStyleSheet.instance().navigationBarBackgroundImage = UIImage.image(UIColor.appPurpleColor())
        UVStyleSheet.instance().navigationBarTextColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Action methods
    internal func saveButtonTapped() {
        // Show progress if changing profile image
        let newImage = _newProfileImage
        if newImage != nil {
            KVNProgress.showProgress(0, status: "Updating...")
        }
        
        BDFAuthenticatedUser.currentUser.updateUserInformation(name: _isNameEdited ? _profileInfoNode.getName() : nil, username: nil, birthdate: nil, bio: nil, gender: nil, profileImage: newImage, progressBlock: { (progress: NSProgress) in
            if newImage != nil {
                dispatch_async_main_queue({ 
                    KVNProgress.updateProgress(CGFloat(progress.fractionCompleted), animated: true)
                })
            }
            }, successBlock: { (user: User?) in
                KVNProgress.showSuccessWithStatus("Updating succeeded", completion: { 
                    self.navigationController?.popViewControllerAnimated(true)
                })
                
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            KVNProgress.showErrorWithStatus("Cannot update profile. Please try again.")
            DTLog(error)
        }
    }
    
    internal func profilePhotoNodeTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let changeButton = UIAlertAction(title: "Change photo", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let imagePickerAlertController = UIAlertController.imagePickerAlertController(delegate: self, viewController: self)
            self.presentViewController(imagePickerAlertController, animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
        })
        alertController.addAction(cancelButton)
        alertController.addAction(changeButton)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            _newProfileImage = image
            _profileInfoNode.profilePhotoNode.image = image
            _saveButton.enabled = true
        }
        else {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                _newProfileImage = image
                _profileInfoNode.profilePhotoNode.image = image
                _saveButton.enabled = true
            }
        }
    }
    
    //MARK: ASTableDataSource, ASTableDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        else if section == 1 {
            return 4
        }
        else {
            return 5
        }
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        if indexPath.section == 0 {
            if indexPath.row == kGeneralInfo {
                return {
                    return _profileInfoNode
                }()
            }
            else if indexPath.row == kProfileInfo || indexPath.row == kPrivacySettings || indexPath.row == kChangePassword {
                return {
                    let node = ASTextCellNode(attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldAppFont(CGFloat.normalFontSize)], insets: UIEdgeInsets(top: contentVerticalInset, left: CGFloat.leftMargin, bottom: contentVerticalInset, right: CGFloat.rightMargin))
                    node.backgroundColor = UIColor.whiteColor()
                    
                    if indexPath.row == kProfileInfo {
                        node.text = "Personal information"
                    }
                    else if indexPath.row == kPrivacySettings {
                        node.text = "Privacy setting"
                    }
                    else {
                        node.text = "Change password"
                    }
                    
                    return node
                }()
            }
            else if indexPath.row == kUsername || indexPath.row == kGender || indexPath.row == kBirthdate {
                var detail: String = ""
                var title: String = ""
                
                if indexPath.row == kUsername {
                    // Username
                    title = "Username"
                    detail = BDFAuthenticatedUser.currentUser.username
                }
                else if indexPath.row == kGender {
                    // Gender
                    title = "Gender"
                    if BDFAuthenticatedUser.currentUser.gender == .Male {
                        detail = "Male"
                    }
                    else if BDFAuthenticatedUser.currentUser.gender == .Female {
                        detail = "Female"
                    }
                    else {
                        detail = "Not available"
                    }
                }
                else if indexPath.row == kBirthdate {
                    // Birthdate
                    title = "Birthdate"
                    if let date = BDFAuthenticatedUser.currentUser.birthdate {
                        detail = date.toString(dateStyle: NSDateFormatterStyle.FullStyle, timeStyle: NSDateFormatterStyle.NoStyle)
                    }
                    else {
                        detail = "Not available"
                    }
                }
                
                return {
                    let node = SettingsDetailNode(title: title, detail: detail, insets: nil)
                    return node
                }()
            }
            else {
                let node = SettingsFacebookNode()
                
                if FBSDKAccessToken.currentAccessToken() != nil {
                    FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) in
                        if error == nil {
                            // Check error body
                            if let dictionary = result as? NSDictionary {
                                if let name = dictionary["name"] as? String {
                                    node.setInfo(name)
                                }
                            }
                        }
                        else {
                            //
                        }
                    })
                }
                else {
                    node.setInfo(nil)
                }
                
                return {
                    return node
                }()
            }
        }
        else if indexPath.section == 1 {
            return {
                let node = ASTextCellNode(attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldAppFont(CGFloat.normalFontSize)], insets: UIEdgeInsets(top: contentVerticalInset, left: CGFloat.leftMargin, bottom: contentVerticalInset, right: CGFloat.rightMargin))
                node.backgroundColor = UIColor.whiteColor()
                
                if indexPath.row == kRateUs {
                    node.text = "Rate us"
                }
                else if indexPath.row == kFeedback {
                    node.text = "Send us feedback"
                }
                else if indexPath.row == kReportBug {
                    node.text = "Report a bug"
                }
                else {
                    node.text = "Recommend a feature"
                }
                
                return node
                }()
        }
        else {
            if indexPath.row == kVersion {
                return {
                    let node = SettingsDetailNode(title: "Version", detail: "1.0", insets: nil)
                    return node
                    }()
            }
            else {
                return {
                    let node = ASTextCellNode(attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldAppFont(CGFloat.normalFontSize)], insets: UIEdgeInsets(top: contentVerticalInset, left: CGFloat.leftMargin, bottom: contentVerticalInset, right: CGFloat.rightMargin))
                    node.backgroundColor = UIColor.whiteColor()
                    
                    if indexPath.row == kTermOfService {
                        node.text = "Terms of service"
                    }
                    else if indexPath.row == kPrivacyPolicy {
                        node.text = "Privacy policy"
                    }
                    else if indexPath.row == kBlockedUsers {
                        node.text = "Blocked users"
                    }
                    else {
                        node.text = "Log out"
                    }
                    
                    return node
                }()
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == kUsername {
                // Username
                let usernameViewController = UsernameTableViewController()
                usernameViewController.delegate = self
                usernameViewController.currentUsername = BDFAuthenticatedUser.currentUser.username
                self.navigationController?.pushViewController(usernameViewController, animated: true)
            }
            else if indexPath.row == kProfileInfo {
                let editProfileInfoViewController = EditProfileInfoViewController()
                self.navigationController?.pushViewController(editProfileInfoViewController, animated: true)
            }
            else if indexPath.row == kGender {
                // Gender settings
                let genderSelectionViewController = GenderSelectionViewController()
                genderSelectionViewController.delegate = self
                genderSelectionViewController.originalGender = BDFAuthenticatedUser.currentUser.gender
                self.navigationController?.pushViewController(genderSelectionViewController, animated: true)
            }
            else if indexPath.row == kChangePassword {
                let passwordViewController = PasswordTableViewController()
                self.navigationController?.pushViewController(passwordViewController, animated: true)
            }
            else if indexPath.row == kBirthdate {
                //Date picker
                let datePicker = AIDatePickerController.pickerWithDate(BDFAuthenticatedUser.currentUser.birthdate, selectedBlock: { (selectedDate: NSDate!) in
                    /// Update user's birthdate
                    BDFAuthenticatedUser.currentUser.updateUserInformation(name: nil, username: nil, birthdate: selectedDate, bio: nil, gender: nil, profileImage: nil, progressBlock: nil, successBlock: { (user: User?) in
                        DTLog("Birthdate update succeeded")
                        }, failureBlock: { (status: Int?, errorCode: Int?, error: NSError?) in
                        DTLog("Birthdate update failed")
                    })
                    
                    let string = selectedDate.toString(dateStyle: NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.NoStyle)
                    if let cell = (tableView as? ASTableView)?.nodeForRowAtIndexPath(indexPath) as? SettingsDetailNode {
                        cell.detail = string
                    }
                    
                    self.dismissViewControllerAnimated(true, completion: { 
                        
                    })
                    }, cancelBlock: { 
                        self.dismissViewControllerAnimated(true, completion: { 
                            
                        })
                })
                self.presentViewController(datePicker, animated: true, completion: nil)
            }
            else if indexPath.row == kFacebookConnect {
                FacebookUtility.getFacebookInfo(self, handler: { (result: FBSDKLoginManagerLoginResult!, error: NSError!) in
                    if error != nil {
                        DTLog("Error")
                    }
                    else if result.isCancelled {
                        DTLog("Canceled")
                    }
                    else {
                        //FBSDKAccessToken.setCurrentAccessToken(nil)
                        FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) in
                            if error == nil {
                                // Check error body
                                if let dictionary = result as? NSDictionary {
                                    if let name = dictionary["name"] as? String {
                                        if let node = (tableView as? ASTableView)?.nodeForRowAtIndexPath(indexPath) as? SettingsFacebookNode {
                                            node.setInfo(name)
                                        }
                                    }
                                }
                            }
                            else {
                                //
                            }
                        })
                    }
                })
            }
        }
        else if indexPath.section == 1 {
            if indexPath.row == kRateUs {
                
            }
            else if indexPath.row == kFeedback {
                UserVoice.presentUserVoiceContactUsFormForParentViewController(self)
            }
            else if indexPath.row == kReportBug {
                UserVoice.presentUserVoiceForumForParentViewController(self)
            }
            else if indexPath.row == kRecommendFeature {
                UserVoice.presentUserVoiceNewIdeaFormForParentViewController(self)
            }
        }
        else if indexPath.section == 2 {
            if indexPath.row == kTermOfService {
                
            }
            else if indexPath.row == kPrivacyPolicy {
                
            }
            else if indexPath.row == kBlockedUsers {
                // Blocked users list
                let blockedUserViewController = BlockedUsersViewController()
                self.navigationController?.pushViewController(blockedUserViewController, animated: true)
            }
            else if indexPath.row == kVersion {
                
            }
            else {
                let alertController = UIAlertController(title: nil, message: "Do you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
                let logOutButton = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    // Update UI
                    let deviceToken = ""
                    BDFAuthenticatedUser.currentUser.logOut(deviceToken, successBlock: {
                        BDFAuthenticatedUser.currentUser.destroy()
                        AppDelegate.logOut()
                        
                        }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                            //Request failed not because of connection
                            if let _ = statusCode {
                                BDFAuthenticatedUser.currentUser.destroy()
                                AppDelegate.logOut()
                            }
                    })
                })
                let cancelButton = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
                })
                alertController.addAction(logOutButton)
                alertController.addAction(cancelButton)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
}

//MARK: ASEditableTextNodeDelegate
extension SettingsViewController: ASEditableTextNodeDelegate {
    func editableTextNodeDidUpdateText(editableTextNode: ASEditableTextNode) {
        _isNameEdited = true
        _saveButton.enabled = true
    }
    
    func editableTextNode(editableTextNode: ASEditableTextNode, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            editableTextNode.resignFirstResponder()
            return false
        }
        
        return true 
    }
}

//MARK: GenderSelectionViewController
extension SettingsViewController: GenderSelectionViewControllerDelegate {
    func genderSelectionViewControllerDidChangeGender(viewController: GenderSelectionViewController, gender: BDFUserGender) {
        // Reload gender cell
        let indexPath = NSIndexPath(forRow: kGender, inSection: 0)
        self.tableNode.view.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
}

//MARK: UsernameTableViewControllerDelegate
extension SettingsViewController: UsernameTableViewControllerDelegate {
    func usernameTableViewControllerDidUpdateUsername(viewController: UsernameTableViewController, username: String) {
        // Update cell
        let indexPath = NSIndexPath(forRow: kUsername, inSection: 0)
        self.tableNode.view.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
}
