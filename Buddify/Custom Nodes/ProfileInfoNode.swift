//
//  ProfileInfoNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 24/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import Models
import SDWebImage

/* Node used in profile view controller where to show profile image, add friend button and other elements */

private let kProfilePhotoSize: CGFloat =  CGFloat.translateToScreenWidthRatioWith320(70)
private let kButtonMinWidth: CGFloat = 100
private let kButtonMaxWidth: CGFloat = 100
private let kDistanceFromProfilePhoto: CGFloat = 10
private let kDistanceWithFollowButton: CGFloat = 10
private let kHorizontalSpacing: CGFloat = CGFloat.leftMargin
private let kVerticalSpacing: CGFloat = 10

/// For add friend and send messages buttons
private let kButtonsVerticalSpacing: CGFloat = 10
private let kButtonsHorizontalSpacing: CGFloat = 20
private let kButtonHeight: CGFloat = 40


///
/// Protocol ProfileInfoNodeDelegate
///
protocol ProfileInfoNodeDelegate: NSObjectProtocol {
    ///
    /// Call when Send message button is tapped
    ///
    func profileInfoNodeDidTapSendMessageButton(node: ProfileInfoNode)
    
    ///
    /// Call when Friend status button is tapped
    ///
    func profileInfoNodeDidTapFriendStatusButton(node: ProfileInfoNode)
}

///
/// Class ProfileInfoNode.
// This node is used to display user information in profile view controller.
///
class ProfileInfoNode: ASDisplayNode {
    // Delegate
    weak var delegate: ProfileInfoNodeDelegate?
    
    let profilePhotoNode = UIImageView()
    private let _nameLabel = ASTextNode()
    private let _descriptionLabel = ASTextNode()
    private let _gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().colorWithAlphaComponent(0.7).CGColor]
        return layer
    }()
    
    // Elements for other user profile
    private var _buttonsBackgroundNode: ASDisplayNode?
    private var _friendStatusButton: ASHighLightButton?
    private var _sendMessageButton: ASHighLightButton?
    
    // User
    private var _user: User!
    
    ///
    /// Initializer
    /// currentUser indicates if this user is current logged in user.
    /// user is user information.
    ///
    init(user: User) {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(profilePhotoNode)
        
        //profilePhotoNode.layerBacked = true
        profilePhotoNode.contentMode = UIViewContentMode.ScaleAspectFill
        profilePhotoNode.backgroundColor = UIColor.photoPlaceHolderColor()
        //profilePhotoNode.clipsToBounds = true
        
        _nameLabel.layerBacked = true
        _descriptionLabel.layerBacked = true
        
        // Only create those two buttons in other view controller
        if !user.isIdentical(BDFAuthenticatedUser.currentUser) {
            let friendStatusButton = ASHighLightButton()
            friendStatusButton.layer.masksToBounds = true
            friendStatusButton.layer.borderWidth = 1
            friendStatusButton.layer.borderColor = UIColor.appPurpleColor().CGColor
            friendStatusButton.layer.cornerRadius = 5
            friendStatusButton.setBackgroundImage(UIImage.image(UIColor.whiteColor()), forState: ASControlState.Normal)
            friendStatusButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor()), forState: ASControlState.Highlighted)
            friendStatusButton.addTarget(self, action: #selector(self.dynamicType.friendStatusButtonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
            
            let sendMessageButton = ASHighLightButton()
            sendMessageButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Send messages", font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: NSTextAlignment.Center), forState: ASControlState.Normal)
            sendMessageButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Send messages", font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.whiteColor(), textAlignment: NSTextAlignment.Center), forState: ASControlState.Highlighted)
            sendMessageButton.layer.masksToBounds = true
            sendMessageButton.layer.borderWidth = 1
            sendMessageButton.layer.borderColor = UIColor.appPurpleColor().CGColor
            sendMessageButton.layer.cornerRadius = 5
            sendMessageButton.setBackgroundImage(UIImage.image(UIColor.whiteColor()), forState: ASControlState.Normal)
            sendMessageButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor()), forState: ASControlState.Highlighted)
            sendMessageButton.addTarget(self, action: #selector(self.dynamicType.sendMessageButtonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
            
            _friendStatusButton = friendStatusButton
            _sendMessageButton = sendMessageButton
            
            let backgroundNode = ASDisplayNode()
            backgroundNode.backgroundColor = UIColor.whiteColor()
            _buttonsBackgroundNode = backgroundNode
            
            self.addSubnode(backgroundNode) // Need to add backgroundNode before adding two buttons
            self.addSubnode(friendStatusButton)
            self.addSubnode(sendMessageButton)
        }
        
        self.addSubnode(_nameLabel)
        self.addSubnode(_descriptionLabel)
        
        self.setInfo(user)
        _user = user
        
        // Add observer to user object if it is current logged in user
        (_user as? NSObject)?.addObserver(self, forKeyPath: "name", options: NSKeyValueObservingOptions.New, context: nil)
        (_user as? NSObject)?.addObserver(self, forKeyPath: "birthdate", options: NSKeyValueObservingOptions.New, context: nil)
        (_user as? NSObject)?.addObserver(self, forKeyPath: "profilePhoto", options: NSKeyValueObservingOptions.New, context: nil)
        (_user as? NSObject)?.addObserver(self, forKeyPath: "gender", options: NSKeyValueObservingOptions.New, context: nil)
        (_user as? NSObject)?.addObserver(self, forKeyPath: "friendStatus", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    // Deinit
    deinit {
        // Remove observer
        (_user as? NSObject)?.removeObserver(self, forKeyPath: "name", context: nil)
        (_user as? NSObject)?.removeObserver(self, forKeyPath: "birthdate", context: nil)
        (_user as? NSObject)?.removeObserver(self, forKeyPath: "profilePhoto", context: nil)
        (_user as? NSObject)?.removeObserver(self, forKeyPath: "gender", context: nil)
        (_user as? NSObject)?.removeObserver(self, forKeyPath: "friendStatus", context: nil)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Top part
        self.flexGrow = true
        self.alignSelf = .Stretch
        
        let spacer1 = ASLayoutSpec()
        spacer1.flexGrow = true
        
        //Vertical stack of profile photo and other labels
        let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 5, justifyContent: ASStackLayoutJustifyContent.End, alignItems: ASStackLayoutAlignItems.Start, children: [spacer1, _nameLabel, _descriptionLabel])
        
        let topFinalSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: kVerticalSpacing, left: kHorizontalSpacing, bottom: kVerticalSpacing, right: kHorizontalSpacing), child: verticalStack)
        
        // Friend button + message button
        if let friendStatusButton = _friendStatusButton, let sendMessageButton = _sendMessageButton, let backgroundNode = _buttonsBackgroundNode {
            // background nodde size
            backgroundNode.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: 60)
            
            let buttonWidth: CGFloat = (constrainedSize.max.width - 3*kButtonsHorizontalSpacing)/2
            friendStatusButton.sizeRange = ASRelativeSizeRange(width: buttonWidth, height: kButtonHeight)
            sendMessageButton.sizeRange = ASRelativeSizeRange(width: buttonWidth, height: kButtonHeight)
            // Horizontal stack of 2 buttons [Add friend]--[Send message]
            let buttonsHorizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kButtonsHorizontalSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [ASStaticLayoutSpec(children: [friendStatusButton]), ASStaticLayoutSpec(children: [sendMessageButton])])
            
            // Adding space on 4 sides
            let buttonsEdgeInsets = UIEdgeInsets(top: kButtonsVerticalSpacing, left: kButtonsHorizontalSpacing, bottom: kButtonsVerticalSpacing, right: kButtonsHorizontalSpacing)
            
            // Inset spec of the whole thing(2 buttons)
            let buttonsInsetStack = ASInsetLayoutSpec(insets: buttonsEdgeInsets, child: buttonsHorizontalStack)
            
            // Overlay
            let overlaySpec = ASOverlayLayoutSpec(child: ASStaticLayoutSpec(children: [backgroundNode]), overlay: buttonsInsetStack)
            
            let finalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 5, justifyContent: ASStackLayoutJustifyContent.End, alignItems: ASStackLayoutAlignItems.Start, children: [topFinalSpec, overlaySpec])
            finalSpec.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height)
            
            return ASStaticLayoutSpec(children: [finalSpec])
        }
        else {
            topFinalSpec.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height)
            return ASStaticLayoutSpec(children: [topFinalSpec])
        }
    }
    
    // Button tapped events
    func friendStatusButtonTapped(button: ASButtonNode) {
        delegate?.profileInfoNodeDidTapFriendStatusButton(self)
    }
    
    func sendMessageButtonTapped(button: ASButtonNode) {
        delegate?.profileInfoNodeDidTapSendMessageButton(self)
    }
    
    // Update everything
    private func setInfo(user: User) {
        // Set profile photo
        self.setProfilePhoto(user)
        
        // Name
        self.setProfileName(user)
        
        // Description
        self.setProfileDescription(user)
        
        // Set button title based on friend status
        self.setFriendStatus(user)
    }
    
    // Update profile image
    private func setProfilePhoto(user: User) {
        let imageURL = NSURL(string: user.profilePhoto)!
        ASPINRemoteImageDownloader.sharedDownloader().downloadImageWithURL(imageURL, callbackQueue: dispatch_get_main_queue(), downloadProgress: nil) { (container: ASImageContainerProtocol?, error: NSError?, object: AnyObject?) in
            self.profilePhotoNode.image = container?.asdk_image()
        }
    }
    
    // Update description
    private func setProfileDescription(user: User) {
        var infoStrings: [String]
        
        // If current logged in user
        if user.isIdentical(BDFAuthenticatedUser.currentUser) {
            infoStrings = [String(user.age), user.gender == .Male ? "Male" : "Female"]
        }
        else {
            var distanceString: String
            if user.distance < 1000 {
                distanceString  = String(user.distance) + " m"
            }
            else {
                distanceString  = String(user.distance/1000) + " km"
            }
            infoStrings  = [String(user.age), user.gender == .Male ? "Male" : "Female", distanceString]
        }
        
        let string = infoStrings.joinWithSeparator(" • ")
        _descriptionLabel.attributedString = NSAttributedString.attributedStringFromFont(string, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.whiteColor(), textAlignment: nil)
    }
    
    // Update name
    private func setProfileName(user: User) {
        _nameLabel.attributedString = NSAttributedString.attributedStringFromFont(user.name, font: UIFont.boldAppFont(18), textColor: UIColor.whiteColor(), textAlignment: nil)
    }
    
    // Update friend status
    private func setFriendStatus(user: User) {
        var addFriendStatus = "Add friend"
        if user.friendStatus == BDFFriendStatus.Friend {
            addFriendStatus = "Friends"
        }
        else if user.friendStatus == BDFFriendStatus.RequestSent {
            addFriendStatus = "Request sent"
        }
        else if user.friendStatus == BDFFriendStatus.RequestReceived {
            addFriendStatus = "Respond to request"
        }
        
        _friendStatusButton?.setAttributedTitle(NSAttributedString.attributedStringFromFont(addFriendStatus, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: NSTextAlignment.Center), forState: ASControlState.Normal)
        
        _friendStatusButton?.setAttributedTitle(NSAttributedString.attributedStringFromFont(addFriendStatus, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.whiteColor(), textAlignment: NSTextAlignment.Center), forState: ASControlState.Highlighted)
    }
    
    override func layout() {
        super.layout()
        let gradientY = _nameLabel.frame.origin.y - 20
        
        // Bring background node to top 
        if let node = _buttonsBackgroundNode {
            DTLog(node.frame)
        }
        
        // Space of 2 buttons white part
        var buttonsVerticalSpace: CGFloat = 0
        
        // Reduce image height if there are buttons(not user's own profile)
        if let _ = _friendStatusButton, let _ = _sendMessageButton {
            buttonsVerticalSpace = kButtonHeight + 2 * kButtonsVerticalSpacing
        }
        
        _gradientLayer.frame = CGRect(origin: CGPoint(x: 0, y: gradientY), size: CGSize(width: self.frame.size.width, height: self.frame.size.height - gradientY - buttonsVerticalSpace))
        self.layer.insertSublayer(_gradientLayer, above: profilePhotoNode.layer)
        // photoHeight is based on buttonsVerticalSpace
        let photoViewHeight = self.frame.size.height - buttonsVerticalSpace
        profilePhotoNode.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.frame.size.width, height: photoViewHeight))
    }
    
    //MARK: Observers
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object === _user {
            if keyPath == "birthdate" || keyPath == "gender" {
                self.setProfileDescription(_user)
            }
            else if keyPath == "profilePhoto" {
                self.setProfilePhoto(_user)
            }
            else if keyPath == "name" {
                self.setProfileName(_user)
            }
            else if keyPath == "friendStatus" {
                self.setFriendStatus(_user)
            }
        }
    }
}
