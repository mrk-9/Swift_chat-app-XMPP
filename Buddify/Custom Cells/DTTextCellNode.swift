//
//  DTTextCellNode.swift
//  Buddify
//
//  Created by Admin on 14/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit


class DTTextCellNode: ASCellNode {
    private var textNode: ASTextNode!
    private var insets: UIEdgeInsets
    var textAttributes: [String: AnyObject]!
    var text: String! {
        didSet {
            textNode.attributedText = NSAttributedString(string: text, attributes: textAttributes)
            self.setNeedsLayout()
        }
    }
    
    private var _staticHeight: CGFloat = 60
    private var _isHeightStatic = false
    
    init(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment?, textInsets: UIEdgeInsets) {
        self.insets = textInsets
        super.init()
        
        textNode = ASTextNode()
        self.addSubnode(textNode)
        
        if let alignment = textAlignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            textAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.appFont(CGFloat.normalFontSize), NSParagraphStyleAttributeName: paragraphStyle]
        }
        else {
            textAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.appFont(CGFloat.normalFontSize)]
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: textNode)
        
        
        if _isHeightStatic {
            insetSpec.sizeRange = ASRelativeSizeRange(minWidth: constrainedSize.max.width, minHeight: _staticHeight, maxWidth: constrainedSize.max.width, maxHeight: _staticHeight)
        }
        else {
            insetSpec.sizeRange = ASRelativeSizeRange(minWidth: constrainedSize.max.width, minHeight: 0, maxWidth: constrainedSize.max.width, maxHeight: constrainedSize.max.height)
        }
        
        return ASStaticLayoutSpec(children: [insetSpec])
    }
    
    func setStaticHeight(isStatic: Bool, height: CGFloat) {
        _isHeightStatic = isStatic
        _staticHeight = height
    }
}

extension DTTextCellNode {
    func setUpAsHeader() {
        self.backgroundColor = UIColor.whiteColor()
        self.cornerRadius = 5
        self.shadowColor = UIColor.blackColor().CGColor
        self.shadowOpacity = 0.1
        self.shadowRadius = 5
        self.clipsToBounds = false
        self.shadowOffset = CGSize(width: 0, height: 7)
    }
}
