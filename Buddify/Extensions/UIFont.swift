//
//  UIFont.swift
//  Buddify
//
//  Created by Vo Duc Tung on 08/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit

extension UIFont {
    class func appFont(fontSize: CGFloat) -> UIFont {
        return UIFont.systemFontOfSize(fontSize)
    }
    
    class func boldAppFont(fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFontOfSize(fontSize)
    }
}