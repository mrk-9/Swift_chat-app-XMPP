//
//  ASDisplayNodeExtension.swift
//  Buddify
//
//  Created by Vo Duc Tung on 16/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import Shimmer

extension ASDisplayNode {
    func addShimmerToSubview(view: UIView) {
        let frame = view.frame
        let shimmer = FBShimmeringView(frame: frame)
        shimmer.contentView = view
        shimmer.shimmeringSpeed = frame.size.width
        shimmer.shimmeringPauseDuration = 1
        shimmer.shimmering = true
        self.view.addSubview(shimmer)
    }
    
    func addShimmerToSubview(view: UIView, speed: CGFloat, pauseDuration: CFTimeInterval) {
        let frame = view.frame
        let shimmer = FBShimmeringView(frame: frame)
        shimmer.contentView = view
        shimmer.shimmeringSpeed = speed
        shimmer.shimmeringPauseDuration = pauseDuration
        shimmer.shimmering = true
        self.view.addSubview(shimmer)
    }
}
