//
//  SettingsDetailNode.swift
//  Buddify
//
//  Created by Tung Vo  on 05/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import Models

private let contentVerticalInset: CGFloat = 20

///
/// Class SettingsDetailNode
///
class SettingsDetailNode: ASCellNode {
    let titleTextNode = ASTextNode()
    let detailTextNode = ASTextNode()
    var insets: UIEdgeInsets
    
    var detail: String! {
        set {
            detailTextNode.attributedString = NSAttributedString.attributedStringFromFont(newValue, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
            detailTextNode.invalidateCalculatedLayout()
            self.setNeedsLayout()
        }
        
        get {
            return detailTextNode.attributedString?.string
        }
    }
    
    init(title: String, detail: String, insets: UIEdgeInsets?) {
        if let _insets = insets {
            self.insets = _insets
        }
        else {
            self.insets = UIEdgeInsets(top: contentVerticalInset, left: CGFloat.leftMargin, bottom: contentVerticalInset, right: CGFloat.rightMargin)
        }
        
        super.init()
        
        titleTextNode.attributedString = NSAttributedString.attributedStringFromFont(title, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        detailTextNode.attributedString = NSAttributedString.attributedStringFromFont(detail, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
        
        self.addSubnode(titleTextNode)
        self.addSubnode(detailTextNode)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        
        let stackSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [titleTextNode, spacer, detailTextNode])
        
        let insetSpec = ASInsetLayoutSpec(insets: self.insets, child: stackSpec)
        
        return insetSpec
    }
}