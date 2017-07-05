//
//  SettingsFacebookNode.swift
//  Buddify
//
//  Created by Tung Vo  on 05/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import Models
import FBSDKLoginKit

private let contentVerticalInset: CGFloat = 20

///
/// Class SettingsFacebookNode
///
class SettingsFacebookNode: ASCellNode {
    let titleTextNode = ASTextNode()
    let nameTextNode = ASTextNode()
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        self.addSubnode(titleTextNode)
        self.addSubnode(nameTextNode)
    }
    
    func setInfo(facebookName: String?) {
        if let name = facebookName {
            titleTextNode.attributedString = NSAttributedString.attributedStringFromFont("Facebook logged in with", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
            nameTextNode.attributedString = NSAttributedString.attributedStringFromFont(name, font: UIFont.boldAppFont(CGFloat.smallFontSize), textColor: UIColor.facebookColor(), textAlignment: nil)
        }
        else {
            titleTextNode.attributedString = NSAttributedString.attributedStringFromFont("Connect with Facebook", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
            nameTextNode.attributedString = nil
        }
        
        self.nameTextNode.invalidateCalculatedLayout()
        self.titleTextNode.invalidateCalculatedLayout()
        self.setNeedsLayout()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var children = [ASLayoutable]()
        children.append(titleTextNode)
        var verticalStack: ASStackLayoutSpec
        if FBSDKAccessToken.currentAccessToken() != nil {
            children.append(nameTextNode)
            verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: children)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 14, left: CGFloat.leftMargin, bottom: 14, right: CGFloat.rightMargin), child: verticalStack)
        }
        else {
            verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 5, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: children)
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: contentVerticalInset, left: CGFloat.leftMargin, bottom: contentVerticalInset, right: CGFloat.rightMargin), child: verticalStack)
        }
    }
}