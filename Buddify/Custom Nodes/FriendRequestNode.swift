//
//  FriendRequestNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 17/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import Models

protocol FriendRequestNodeDelegate {
    func friendRequestNodeAcceptButtonTapped(node: FriendRequestNode)
    func friendRequestNodeADeclineButtonTapped(node: FriendRequestNode)
}

private let kProfileImageSize: CGFloat = 60
private let kButtonHeight: CGFloat = 30
private let kButtonWidth: CGFloat = 100
private let kVerticalInset: CGFloat = 10

class FriendRequestNode: ASCellNode {
    //Public variables
    var nodeDelete: FriendRequestNodeDelegate?
    
    //Private variables
    private let _profileImageNode = ASNetworkImageNode()
    private let _nameLabelNode = ASTextNode()
	private let _ageLabelNode = ASTextNode()
    private let _distanceLabelNode = ASTextNode()
    private let _acceptButton = ASHighLightButton()
    private let _declineButton = ASHighLightButton()
    private let _separator = ASDisplayNode()
    
    private var user : User!
    
    convenience init(user: User) {
        self.init()
        self.user = user
        self.commonInit()
    }
    
    private func commonInit() {
        //Profile image node
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.imageModificationBlock = roundedImageMotificationBlock()
        _profileImageNode.layerBacked = true
        _profileImageNode.URL = NSURL(string: user.profilePhoto)
        _profileImageNode.cornerRadius = kProfileImageSize/2
		self.addSubnode(_profileImageNode)

        //Name label node
        _nameLabelNode.layerBacked = true
        _nameLabelNode.attributedString = NSAttributedString.attributedStringFromFont(user.name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: .Center)
		self.addSubnode(_nameLabelNode)
		
		//Age label node
		_ageLabelNode.attributedString = NSAttributedString.attributedStringFromFont(String(user.age) + "  •  " + String(user.distance) + "km away", font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
		self.addSubnode(_ageLabelNode)
		
        //Accept button node
        _acceptButton.setTitle("Accept", withFont: UIFont.appFont(CGFloat.normalFontSize), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
        _acceptButton.backgroundColor = UIColor.appPurpleColor()
        _acceptButton.cornerRadius = 3
        _acceptButton.addTarget(self, action: #selector(FriendRequestNode.acceptButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(_acceptButton)

        //Decline button node
        _declineButton.cornerRadius = 3
        _declineButton.borderColor = UIColor.appPurpleColor().CGColor
        _declineButton.borderWidth = 1
        _declineButton.setTitle("Delete", withFont: UIFont.appFont(CGFloat.normalFontSize), withColor: UIColor.appPurpleColor(), forState: ASControlState.Normal)
        _declineButton.addTarget(self, action: #selector(FriendRequestNode.declineButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(_declineButton)
        
        //_separator
        _separator.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        self.addSubnode(_separator)
		
        //Node background color
        self.backgroundColor = UIColor.whiteColor()
        self.cornerRadius = 5
    }
    
    class func defaultHeight() -> CGFloat {
        return kProfileImageSize + kVerticalInset*2
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		//Image isze
        _profileImageNode.preferredFrameSize = CGSize(width: kProfileImageSize, height: kProfileImageSize)
        _acceptButton.sizeRange = ASRelativeSizeRange(size: CGSize(width: kButtonWidth, height: kButtonHeight))
        _declineButton.sizeRange = ASRelativeSizeRange(size: CGSize(width: kButtonWidth, height: kButtonHeight))
        
        //Accept + Delete button
        let horizontalStack1 = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Stretch, children: [ASStaticLayoutSpec(children: [_acceptButton]), ASStaticLayoutSpec(children: [_declineButton])])
        horizontalStack1.spacingBefore = 10
        
        //Vertical stack of Name + Description + Buttons
        let verticalStack1 = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [_nameLabelNode, _ageLabelNode, horizontalStack1])
        
        //Everything
        let wholeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: CGFloat.leftMargin, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_profileImageNode, verticalStack1])
        
        //Inset of name description stack
        let insetSpec1 = ASInsetLayoutSpec(insets: UIEdgeInsets(top: kVerticalInset, left: CGFloat.leftMargin, bottom: kVerticalInset, right: 0) , child: wholeStack)
        
        return insetSpec1
    }
    
    override func layout() {
        super.layout()
		_separator.frame.size.height = 1
    }
    
    //MARK: Event methods
    func acceptButtonTapped() {
        nodeDelete?.friendRequestNodeAcceptButtonTapped(self)
    }
    
    func declineButtonTapped() {
        nodeDelete?.friendRequestNodeADeclineButtonTapped(self)
    }
}

class FriendRequestPlaceholderNode: ASCellNode {
    private let _profileImageNode = ASDisplayNode()
    private let _nameNode = ASDisplayNode()
    private let _distanceNode = ASDisplayNode()
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        _profileImageNode.cornerRadius = kProfileImageSize/2
        
        _profileImageNode.backgroundColor = UIColor.placeholerShimmingColor()
        _nameNode.backgroundColor = UIColor.placeholerShimmingColor()
        _distanceNode.backgroundColor = UIColor.placeholerShimmingColor()
        
        self.addSubnode(_profileImageNode)
        self.addSubnode(_nameNode)
        self.addSubnode(_distanceNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        //Profile image
        _profileImageNode.preferredFrameSize = CGSize(width: kProfileImageSize, height: kProfileImageSize)
        _nameNode.preferredFrameSize = CGSize(width: 100, height: 10)
        _distanceNode.preferredFrameSize = CGSize(width: 140, height: 10)
        
        //Vertical stack of Name + Description
        _nameNode.spacingBefore = 10
        let verticalStack1 = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [_nameNode, _distanceNode])
        
        //Everything
        let wholeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: CGFloat.leftMargin, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [_profileImageNode, verticalStack1])
        
        //Inset of name description stack
        let insetSpec1 = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: CGFloat.leftMargin, bottom: 10, right: 0) , child: wholeStack)
        
        return insetSpec1
    }
    
    override func layout() {
        super.layout()
        
        self.addShimmerToSubview(_profileImageNode.view)
        self.addShimmerToSubview(_nameNode.view)
        self.addShimmerToSubview(_distanceNode.view)
    }
}
