//
//  EditableUserInfoSectionNode.swift
//  Buddify
//
//  Created by Admin on 14/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import AsyncDisplayKit

private let kSectionInsetTop: CGFloat = 10
private let kSectionInsetBottom: CGFloat = 10

private let kSectionInsetRight: CGFloat = CGFloat.rightMargin
private let kSectionInsetLeft: CGFloat = CGFloat.leftMargin

private let kLabelsSpacing: CGFloat = 5

protocol EditableUserInfoSectionNodeDelegate: NSObjectProtocol {
    func editableUserInfoSectionNodeDelegateDidUpdateText(node: EditableUserInfoSectionNode)
}

class EditableUserInfoSectionNode: ASCellNode, ASEditableTextNodeDelegate, UITextViewDelegate {
    var titleLabel: ASTextNode!
    var textLimitLabel: ASTextNode!
    var descriptionLabel: ASEditableTextNode!
    var nodeDelegate: EditableUserInfoSectionNodeDelegate?
    
    init(title: String, description: String) {
        super.init()
        self.cornerRadius = 2
        
        titleLabel = ASTextNode()
        titleLabel.attributedString = NSAttributedString.attributedStringFromFont(title, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
        self.addSubnode(titleLabel)
        
        textLimitLabel = ASTextNode()
        textLimitLabel.placeholderInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        textLimitLabel.attributedString = NSAttributedString.attributedStringFromFont( String(256 - description.characters.count) + "/256", font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: NSTextAlignment.Right)
        self.addSubnode(textLimitLabel)
        
        //Description editable
        descriptionLabel = ASEditableTextNode()
        descriptionLabel.typingAttributes = [NSForegroundColorAttributeName: UIColor.appLightTextColor(), NSFontAttributeName: UIFont.appFont(CGFloat.normalFontSize)]
        descriptionLabel.delegate = self
        descriptionLabel.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        descriptionLabel.tintColor = UIColor.appLightTextColor()
        descriptionLabel.returnKeyType = .Done
        descriptionLabel.placeholderEnabled = true
        descriptionLabel.attributedPlaceholderText = NSAttributedString.attributedStringFromFont("Write something ..", font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
        descriptionLabel.attributedText = NSAttributedString.attributedStringFromFont(description, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
        self.addSubnode(descriptionLabel)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        self.flexShrink = true
        
        descriptionLabel.flexShrink = true
        descriptionLabel.flexGrow = true
        descriptionLabel.sizeRange = ASRelativeSizeRange(size: CGSize(width: constrainedSize.max.width - kSectionInsetLeft - kSectionInsetRight, height: constrainedSize.max.height - kSectionInsetTop - kSectionInsetBottom - kLabelsSpacing - 15))
        textLimitLabel.sizeRange = ASRelativeSizeRange(size: CGSize(width: 100, height: 15))
        
        textLimitLabel.flexShrink = false
        titleLabel.flexGrow = true
        titleLabel.flexShrink = true
        // Horizontal stack: Title + counter
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [titleLabel, ASStaticLayoutSpec(children: [textLimitLabel])])
        horizontalStack.alignSelf = .Stretch
        
        let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kLabelsSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [horizontalStack, ASStaticLayoutSpec(children: [descriptionLabel])])
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: kSectionInsetTop, left: kSectionInsetLeft, bottom: kSectionInsetBottom, right: kSectionInsetRight), child: verticalStack)
        inset.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height)
        
        return ASStaticLayoutSpec(children: [inset])
    }
    
    class func nodeHeightWithWidth(width: CGFloat, title: String, text: String) -> CGFloat {
        let totalHeight: CGFloat
        let realWidth = width - kSectionInsetRight - kSectionInsetLeft - 10
        
        let rect = (text as NSString).boundingRectWithSize(CGSize(width: realWidth, height: 1000), options:[NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes: [NSFontAttributeName: UIFont.appFont(CGFloat.normalFontSize)], context: nil)
        
        if text == "" || rect.height < 110 {
            
            totalHeight = kSectionInsetTop + 15 + kLabelsSpacing + 110 + 10 + kSectionInsetBottom
            
        } else {
            
            totalHeight = kSectionInsetTop + 15 + kLabelsSpacing + rect.size.height + 10 + kSectionInsetBottom
            
        }
        
        return totalHeight
    }
    
    func editableTextNodeDidUpdateText(editableTextNode: ASEditableTextNode) {
        nodeDelegate?.editableUserInfoSectionNodeDelegateDidUpdateText(self)
        textLimitLabel.attributedString = NSAttributedString.attributedStringFromFont( String(256 - descriptionLabel.textView.text.characters.count) + "/256", font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: NSTextAlignment.Right)
        self.setNeedsLayout()
        self.invalidateCalculatedLayout()
        
    }
    
    
    func editableTextNode(editableTextNode: ASEditableTextNode, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            self.descriptionLabel.resignFirstResponder()
        }
        return descriptionLabel.textView.text.characters.count + (text.characters.count - range.length) <= 256
    }
    
    
}