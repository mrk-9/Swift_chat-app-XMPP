//
//  String.swift
//  Buddify
//
//  Created by Vo Duc Tung on 08/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit

extension NSAttributedString {
    class func attributedStringFromFont(string : String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment?) -> NSAttributedString {
        if let _textAlignment = textAlignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = _textAlignment
            return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: textColor, NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle])
        }
        return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: textColor, NSFontAttributeName: font])
    }
    
    func heightInWidth(width: CGFloat) -> CGFloat {
        let framesetter = CTFramesetterCreateWithAttributedString(self)
        var fitRange = CFRange()
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSize(width: width, height:  CGFloat.max), &fitRange)
        
        return size.height
    }
    
    func widthInHeight(height: CGFloat) -> CGFloat {
        let framesetter = CTFramesetterCreateWithAttributedString(self)
        var fitRange = CFRange()
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSize(width: CGFloat.max, height:  height), &fitRange)
        
        return size.width
    }
}

extension String {
    //Capitalize first letter
    func stringByCapitalizingFirstLetter() -> String {
        if self.characters.count == 0 {
            return ""
        }
        return self.stringByReplacingCharactersInRange(self.startIndex..<self.startIndex.advancedBy(1), withString: self.substringToIndex(self.startIndex.advancedBy(1)).uppercaseString)
    }
    
    static func WoobiHashKey() -> String {
        return "b9f645092523c140"
    }
    
    static func WoobiAppID() -> String {
        return "18362"
    }
    
    static func NativeXAppID() -> String {
        return "20910"
    }
    
    static func NativeXOfferWallPlacementName() -> String {
        return "Store Open"
    }
    
    static func facebookAppLink() -> String {
        return "https://fb.me/963046733791751"
    }
    
    func heightInWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let attributedString = NSAttributedString(string: self, attributes: [NSFontAttributeName: font])
        return attributedString.heightInWidth(width)
    }
    
    func widthInHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let attributedString = NSAttributedString(string: self, attributes: [NSFontAttributeName: font])
        return attributedString.widthInHeight(height)
    }
}
