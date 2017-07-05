//
//  UIButton.swift
//  Buddify
//
//  Created by Vo Duc Tung on 26/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

extension UIButton {
    class func barButtonItemWithTitle(title: String, size: CGSize, alignment: UIControlContentHorizontalAlignment) -> UIButton {
        return UIButton.barButtonItemWithTitle(title, size: size, alignment: alignment,titleColor: UIColor.whiteColor(), disabledColor: UIColor.whiteColor().colorWithAlphaComponent(0.3))
    }
    
    class func barButtonItemWithTitle(title: String, size: CGSize, alignment: UIControlContentHorizontalAlignment,titleColor: UIColor, disabledColor: UIColor) -> UIButton {
        let button = UIButton(type: UIButtonType.Custom)
        button.contentHorizontalAlignment = alignment
        button.setAttributedTitle(NSAttributedString.attributedStringFromFont(title, font: UIFont.appFont(CGFloat.normalFontSize), textColor: titleColor, textAlignment: nil), forState: UIControlState.Normal)
        button.setAttributedTitle(NSAttributedString.attributedStringFromFont(title, font: UIFont.appFont(CGFloat.normalFontSize), textColor: titleColor.colorWithAlphaComponent(0.5), textAlignment: nil), forState: UIControlState.Highlighted)
        button.setAttributedTitle(NSAttributedString.attributedStringFromFont(title, font: UIFont.appFont(CGFloat.normalFontSize), textColor: disabledColor, textAlignment: nil), forState: UIControlState.Disabled)
        button.frame = CGRect(origin: CGPointZero, size: size)
        
        return button
    }
    
    class func barButtonItemWithTitle(title: String, alignment: UIControlContentHorizontalAlignment) -> UIButton {
        return UIButton.barButtonItemWithTitle(title, size: CGSize(width: 44, height: 44), alignment: alignment)
    }
}
