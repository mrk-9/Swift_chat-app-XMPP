//
//  UserBlockNode.swift
//  Buddify
//
//  Created by Tung Vo  on 31/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import Models

private let kProfileImageSize: CGFloat = 60
private let kButtonHeight: CGFloat = 30
private let kButtonWidth: CGFloat = 100
private let kVerticalInset: CGFloat = 10

///
/// Protocol UserUnblockNodeDelegate
///
protocol UserUnblockNodeDelegate: NSObjectProtocol {
    func userUnblockNodeButtonTapped(node: UserUnblockNode)
}

///
/// Class UserBlockNode
/// Showed in list of blocked users.
///
class UserUnblockNode: ASCellNode {
    weak var delegate: UserUnblockNodeDelegate?
    
    private let _nameLabelNode = ASTextNode()
    private let _profileImageNode = ASNetworkImageNode()
    private let _unblockButton = ASHighLightButton()
    
    convenience init(user: User) {
        self.init()
        
        // Profile image node
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.imageModificationBlock = roundedImageMotificationBlock()
        _profileImageNode.layerBacked = true
        _profileImageNode.URL = NSURL(string: user.profilePhoto)
        _profileImageNode.cornerRadius = kProfileImageSize/2
        self.addSubnode(_profileImageNode)
        
        // Name label node
        _nameLabelNode.layerBacked = true
        _nameLabelNode.attributedString = NSAttributedString.attributedStringFromFont(user.name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: .Center)
        self.addSubnode(_nameLabelNode)
        
        // Unblock button
        _unblockButton.setTitle("Unblock", withFont: UIFont.appFont(CGFloat.normalFontSize), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
        _unblockButton.backgroundColor = UIColor.appPurpleColor()
        _unblockButton.cornerRadius = 3
        _unblockButton.addTarget(self, action: #selector(self.dynamicType.unblockButtonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
        self.addSubnode(_unblockButton)
    }
    
    func unblockButtonTapped(button: ASButtonNode) {
        delegate?.userUnblockNodeButtonTapped(self)
    }
    
    class func defaultHeight() -> CGFloat {
        return kProfileImageSize + kVerticalInset*2
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        _profileImageNode.preferredFrameSize = CGSize(width: kProfileImageSize, height: kProfileImageSize)
        _unblockButton.sizeRange = ASRelativeSizeRange(size: CGSize(width: kButtonWidth, height: kButtonHeight))
        
        // Horizontal stack
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        
        let wholeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: CGFloat.leftMargin, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_profileImageNode, _nameLabelNode, spacer, ASStaticLayoutSpec(children:[_unblockButton])])
        
        let insetSpec1 = ASInsetLayoutSpec(insets: UIEdgeInsets(top: kVerticalInset, left: CGFloat.leftMargin, bottom: kVerticalInset, right: CGFloat.rightMargin) , child: wholeStack)
        
        return insetSpec1
    }
}
