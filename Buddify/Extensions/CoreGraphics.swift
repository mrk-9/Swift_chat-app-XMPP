//
//  CoreGraphics.swift
//  Buddify
//
//  Created by Vo Duc Tung on 09/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit

extension CGFloat {
    static var screenWidth: CGFloat {
        return CGSize.screenSize.width
    }
    
    static var leftMargin: CGFloat {
        return 10
    }
    
    static var rightMargin: CGFloat {
        return 10
    }
    
    static var topMargin: CGFloat {
        return 10
    }
    
    static var screenHeight: CGFloat {
        return CGSize.screenSize.height
    }
    
    static var normalFontSize: CGFloat {
        return 15
    }
    
    static var smallFontSize: CGFloat {
        return 13
    }
    
    static var bigFontSize: CGFloat {
        return 20
    }
    
    static func translateToScreenWidthRatioWith320(value: CGFloat) -> CGFloat {
        return value * CGFloat.screenWidth / 320
    }
    
    static func translateToScreenHeightRatioWith568(value: CGFloat) -> CGFloat {
        return value * CGFloat.screenHeight / 568
    }
}

extension CGSize {
    static var screenSize: CGSize {
        return UIScreen.mainScreen().bounds.size
    }
}