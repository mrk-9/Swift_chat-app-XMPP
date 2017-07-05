//
//  BorderButton.swift
//  Buddify
//
//  Created by Vo Duc Tung on 11/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private var verticalInset: CGFloat = 5
private var horizontalInset: CGFloat = 10

class BorderButton: ASButtonNode {
    override init() {
        super.init()
        self.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    override func layout() {
        super.layout()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1
    }
}
