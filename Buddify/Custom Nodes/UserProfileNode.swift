//
//  UserProfileNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 10/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

private var kElementSpacing: CGFloat = 5

private var kNodeLeftMargin: CGFloat = 40
private var kNodeRightMargin: CGFloat = 40

private var kUserProfileNodeWidth: CGFloat = 320
private var kUserProfileNodeHeight: CGFloat = 95

private var kProfileImageSize: CGFloat = 80

private var kAddFriendButtonWidth: CGFloat = 114
private var kAddFriendButtonHeight: CGFloat = 50
private var kAddFriendButtonHorizontalInset: CGFloat = 0
private var kAddFriendButtonVerticalInset: CGFloat = 7.5

private var kSendMessageButtonWidth: CGFloat = 114
private var kSendMessageButtonHeight: CGFloat = 50
private var kSendMessageButtonHorizontalInset: CGFloat = 25
private var kSendMessageButtonVerticalInset: CGFloat = 7.5

protocol UserProfileNodeDelegate {
	func userProfileNodeAddFriendButtonTapped(node: UserProfileNode)
}

class UserProfileNode: ASCellNode {
	var nodeDelegate: UserProfileNodeDelegate?
	
    //Private variables
    private let _nameTextNode = ASTextNode()
    private let _ageTextNode = ASTextNode()
    private let _distanceTextNode = ASTextNode()
    private let _genderTextNode = ASTextNode()
    private let _addFriendButtonNode = ASHighLightButton()
    private let _sendMessageButtonNode = ASHighLightButton()
    private let _profileImageNode = ASNetworkImageNode()
	
    init(user: User) {
        super.init()
        self.commonInit(user)
    }
    
    private func commonInit(user: User?) {
		
		//profile image
        _profileImageNode.layerBacked = true
		_profileImageNode.cornerRadius = kProfileImageSize/2
		_profileImageNode.preferredFrameSize = CGSize(width: kProfileImageSize, height: kProfileImageSize)
		_profileImageNode.imageModificationBlock = { (image: UIImage) in
			var newImage: UIImage?
			let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
			UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.mainScreen().scale)
			UIBezierPath(roundedRect: rect, cornerRadius: image.size.width/2 ).addClip()
			image.drawInRect(rect)
			newImage = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			
			return newImage
		}
		self.addSubnode(_profileImageNode)

		//Username
		self.addSubnode(_nameTextNode)

		//age text
		self.addSubnode(_ageTextNode)
		
		//distance text
		self.addSubnode(_distanceTextNode)

		//gender text
		self.addSubnode(_genderTextNode)

		//add friend button
		_addFriendButtonNode.backgroundColor = UIColor.appPurpleColor()
		_addFriendButtonNode.cornerRadius = kAddFriendButtonHeight/2
		_addFriendButtonNode.borderColor = UIColor.appRedColor().CGColor
		_addFriendButtonNode.borderWidth = 1.5
		_addFriendButtonNode.contentEdgeInsets = UIEdgeInsets(top: kAddFriendButtonVerticalInset, left: kAddFriendButtonHorizontalInset, bottom: kAddFriendButtonVerticalInset, right: kAddFriendButtonHorizontalInset)
		_addFriendButtonNode.userInteractionEnabled = true
		_addFriendButtonNode.addTarget(self, action: #selector(UserProfileNode.addFriendButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        self.addSubnode(_addFriendButtonNode)
        
        //add friend button
        _sendMessageButtonNode.backgroundColor = UIColor.appPurpleColor()
        _sendMessageButtonNode.cornerRadius = kAddFriendButtonHeight/2
        _sendMessageButtonNode.borderColor = UIColor.appRedColor().CGColor
        _sendMessageButtonNode.borderWidth = 1.5
        _sendMessageButtonNode.contentEdgeInsets = UIEdgeInsets(top: kAddFriendButtonVerticalInset, left: kAddFriendButtonHorizontalInset, bottom: kAddFriendButtonVerticalInset, right: kAddFriendButtonHorizontalInset)
        _sendMessageButtonNode.userInteractionEnabled = true
        _sendMessageButtonNode.addTarget(self, action: #selector(UserProfileNode.sendMessageButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        self.addSubnode(_sendMessageButtonNode)
		
		self.backgroundColor = UIColor.appPurpleColor()
        self.setInfo(user)
    }
    
    private func setInfo(user : User?) {
        if let _ = user {
            _profileImageNode.URL = NSURL(string: "https://s-media-cache-ak0.pinimg.com/736x/2c/22/92/2c229207d36e3b70d56a063a2319e2ff.jpg")
            _nameTextNode.attributedString = NSAttributedString.attributedStringFromFont("Tung Vo Duc", font: UIFont.boldAppFont(17), textColor: UIColor.whiteColor(), textAlignment: nil)
            _ageTextNode.attributedString = NSAttributedString.attributedStringFromFont("25Y • ", font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.whiteColor(), textAlignment: nil)
            _distanceTextNode.attributedString = NSAttributedString.attributedStringFromFont("150km away", font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.whiteColor(), textAlignment: nil)
            _genderTextNode.attributedString = NSAttributedString.attributedStringFromFont("Male • ", font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.whiteColor(), textAlignment: nil)
            _addFriendButtonNode.setTitle("ADD FRIEND", withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appRedColor(), forState: ASControlState.Normal)
			_addFriendButtonNode.setTitle("REQUEST SENT", withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appRedColor(), forState: ASControlState.Selected)

        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
        self.alignSelf = ASStackLayoutAlignSelf.Stretch
		let width = constrainedSize.max.width
		_profileImageNode.preferredFrameSize = CGSize(width: width * kProfileImageSize/kUserProfileNodeWidth, height: width * kProfileImageSize/kUserProfileNodeWidth )
		_addFriendButtonNode.preferredFrameSize = CGSize(width: width*(kAddFriendButtonWidth/320), height: kAddFriendButtonHeight)

		
        //Align age, gender,  node on same level horizontal
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_ageTextNode, _genderTextNode, _distanceTextNode])
		
		let imageTextSpacer = ASLayoutSpec()
		imageTextSpacer.spacingAfter = 15
		
		//username + horizontalStack + add friend button
		let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [_nameTextNode, horizontalStack, imageTextSpacer, _addFriendButtonNode])
		
		verticalStack.flexShrink = true
		
		verticalStack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width - kProfileImageSize, height: constrainedSize.max.width*(kUserProfileNodeHeight/kUserProfileNodeWidth) )
		
		//node stack
        let profileNodeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_profileImageNode, imageTextSpacer, verticalStack])
		
        let layoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top:0, left: kNodeLeftMargin, bottom: 0, right: kNodeLeftMargin), child: profileNodeStack)
        layoutSpec.flexGrow = true
        
        return layoutSpec
    }
    
    override func layout() {
        super.layout()
        
    }
	
	//Tap selectors
	func addFriendButtonTapped() {
		nodeDelegate?.userProfileNodeAddFriendButtonTapped(self)
	}
	
    func sendMessageButtonTapped() {
        
    }
}

private let sectionInsetTop: CGFloat = 5
private let sectionInsetBottom: CGFloat = 10

private let kSectionInsetRight: CGFloat = CGFloat.rightMargin
private let kSectionInsetLeft: CGFloat = CGFloat.leftMargin

private let kLabelsSpacing: CGFloat = 5

class UserInfoSectionNode: ASCellNode {
    private var titleLabel: ASTextNode!
    private var descriptionLabel: ASTextNode!
    
    init(title: String, description: String) {
        super.init()
        
        titleLabel = ASTextNode()
        titleLabel.attributedString = NSAttributedString.attributedStringFromFont(title, font: UIFont.appFont(CGFloat.bigFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
        
        descriptionLabel = ASTextNode()
        descriptionLabel.attributedString = NSAttributedString.attributedStringFromFont(description, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        
        self.addSubnode(titleLabel)
        self.addSubnode(descriptionLabel)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kLabelsSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [titleLabel, descriptionLabel])
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: sectionInsetTop, left: kSectionInsetLeft, bottom: sectionInsetBottom, right: kSectionInsetRight), child: verticalStack)
        inset.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height)
        
        return ASStaticLayoutSpec(children: [inset])
    }
    
    class func nodeHeightWithWidth(width: CGFloat, title: String, text: String) -> CGFloat {
        let realWidth = width - kSectionInsetRight - kSectionInsetLeft
        
        let height = text.heightInWidth(realWidth, font: UIFont.appFont(CGFloat.normalFontSize))
        let totalHeight = sectionInsetTop + 20 + kLabelsSpacing + height + sectionInsetBottom
        
        return totalHeight
    }
}