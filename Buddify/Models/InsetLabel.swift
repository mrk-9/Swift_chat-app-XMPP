//
//  InsetLabel.swift
//  Buddify
//
//  Created by Admin on 15/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

class InsetLabel: UILabel {
    var textInsets = UIEdgeInsetsZero
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, textInsets))
    }
}
