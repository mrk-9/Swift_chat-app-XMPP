//
//  UIColor.swift
//  Buddify
//
//  Created by Vo Duc Tung on 11/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func appPinkColor() -> UIColor {
        return UIColor(red: 228, green: 90, blue: 132)
    }
    
    static func appPurpleColor() -> UIColor {
        return UIColor(red: 88, green: 60, blue: 135)
    }
    
    static func appDarkPurpleColor() -> UIColor {
        return UIColor(red: 62, green: 30, blue: 104)
    }
    
    static func appRedColor() -> UIColor {
        return UIColor(red: 255, green: 63, blue: 77)
    }
    
    static func appScrollViewBackgrouncColor() -> UIColor {
        return UIColor(red: 242, green: 242, blue: 242)
    }
    
    static func appGrayColor() -> UIColor {
        return UIColor(red: 239, green: 239, blue: 239)
    }
	
	static func appLightGrayColor() -> UIColor {
		return UIColor(red: 237, green: 237, blue: 237)
	}
    
    static func appLightTextColor() -> UIColor {
        return UIColor.grayColor()
    }
	
    static func appGradientColors() -> [UIColor] {
        return [UIColor(red: 255, green: 84, blue: 188), UIColor.appPinkColor(), UIColor(red: 255, green: 100, blue: 135)]
    }
    
    static func facebookColor() -> UIColor {
        return UIColor(red: 59, green: 89, blue: 152)
    }
    
    static func photoPlaceHolderColor() -> UIColor {
        return UIColor.grayColor()
    }
    
    static func placeholerShimmingColor() -> UIColor {
        return UIColor(red: 230, green: 230, blue: 230)
    }
}