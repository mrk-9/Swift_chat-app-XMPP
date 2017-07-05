//
//  InsetTextNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 14/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit

class InsetTextNode: ASDisplayNode {
    var textInsets: UIEdgeInsets! {
        didSet {
            _textInsets = textInsets
            self.invalidateCalculatedLayout()
        }
    }
    
    var attributedString: NSAttributedString? {
        set {
            textNode.attributedString = newValue
            self.textNode.invalidateCalculatedLayout()
            self.setNeedsLayout()
        }
        
        get {
            return textNode.attributedString
        }
    }
    
    
    var textNode: ASTextNode!
    
    //Custom insets
    private var _textInsets: UIEdgeInsets!
    
    override init() {
        super.init()
        textNode = ASTextNode()
        textNode.layerBacked = true
        self.addSubnode(textNode)
        textInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        _textInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let textWidth = constrainedSize.width - textInsets.left - textInsets.right
        let textHeight = constrainedSize.height - textInsets.top - textInsets.bottom
        let textSize = textNode.measure(CGSize(width: textWidth, height: textHeight))
        let realWidth = textSize.width + textInsets.right + textInsets.left
        let realHeight = textSize.height + textInsets.top + textInsets.bottom
        
        //If width < height --> make width = height & fix insets left
        if textSize.width == 0 {
            return CGSize(width: 0, height: 0)
        }
        else if realWidth < realHeight {
            //Fix to correct insets
            _textInsets.left += (realHeight - realWidth)/2
            return CGSize(width: realHeight, height: realHeight)
        }
        
        _textInsets.left = (realWidth - textSize.width)/2
        return CGSize(width: realWidth, height: realHeight)
    }
    
    override func layout() {
        super.layout()
        let textSize = textNode.calculatedSize
        if textSize.width == 0 {
            self.frame = CGRect(x: _textInsets.left, y: _textInsets.top, width: 0, height: 0)
        }
        else {
            textNode.frame = CGRect(x: _textInsets.left, y: _textInsets.top, width: textSize.width, height: textSize.height)
        }
    }
}
