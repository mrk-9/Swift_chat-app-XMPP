//
//  SettingsProfileInfoNode.swift
//  Buddify
//
//  Created by Tung Vo  on 05/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import Models

private let kProfilePhotoNodeSize: CGFloat = 80
private let kNamePhotoSpacing: CGFloat = 20
private let kNameTextFieldWidth: CGFloat = 150
private let contentVerticalInset: CGFloat = 20

///
/// Class SettingsProfileInfoNode
///
class SettingsProfileInfoNode: ASCellNode {
    let profilePhotoNode = ASNetworkImageNode()
    let nameTextField = ASEditableTextNode()
    
    init(user: User) {
        super.init()
        nameTextField.typingAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldAppFont(CGFloat.normalFontSize)]
        nameTextField.attributedPlaceholderText = NSAttributedString.attributedStringFromFont("Enter your name", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
        
        profilePhotoNode.cornerRadius = kProfilePhotoNodeSize/2
        profilePhotoNode.imageModificationBlock = roundedImageMotificationBlock()
        profilePhotoNode.backgroundColor = UIColor.photoPlaceHolderColor()
        
        self.addSubnode(nameTextField)
        self.addSubnode(profilePhotoNode)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.whiteColor()
        
        self.setInfo(user)
    }
    
    func setInfo(user: User) {
        profilePhotoNode.URL = NSURL(string: user.profilePhoto)
        nameTextField.attributedText = NSAttributedString.attributedStringFromFont(user.name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
    }
    
    func getName() -> String? {
        return nameTextField.attributedText?.string
    }
    
    func getImage() -> UIImage? {
        return profilePhotoNode.image
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        profilePhotoNode.preferredFrameSize = CGSize(width: kProfilePhotoNodeSize, height: kProfilePhotoNodeSize)
        nameTextField.sizeRange = ASRelativeSizeRange(width: kNameTextFieldWidth, height: 30)
        
        let spacer = ASLayoutSpec()
        let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [spacer, ASStaticLayoutSpec(children: [nameTextField])])
        
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kNamePhotoSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [profilePhotoNode, verticalStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: contentVerticalInset, left: CGFloat.leftMargin, bottom: contentVerticalInset, right: CGFloat.rightMargin), child: horizontalStack)
    }
}