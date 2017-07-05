//
//  AnimatedContentsDisplayLayer.swift
//  Buddify
//
//  Created by Vo Duc Tung on 01/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AnimatedContentsDisplayLayer: CALayer {
    override func actionForKey(event: String) -> CAAction? {
        if let action = super.actionForKey(event) {
            return action
        }
        
        if event == "contents" && contents == nil {
            let transition = CATransition()
            transition.duration = 0.6
            transition.type = kCATransitionFade
            return transition
        }
        
        return nil
    }
}
