//
//  UIView.swift
//  Buddify
//
//  Created by Vo Duc Tung on 29/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Shimmer

extension UIView {
    func addSidedBorder(edge: UIRectEdge = .Top, color: UIColor, thickness: CGFloat) -> CALayer {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        
        switch(edge) {
        case UIRectEdge.Top:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), thickness)
            self.layer.addSublayer(border)
            
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, CGRectGetWidth(self.frame), thickness)
            self.layer.addSublayer(border)
            
        case UIRectEdge.Left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame));
            self.layer.addSublayer(border)
            
        case UIRectEdge.Right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            self.layer.addSublayer(border)
            
        case UIRectEdge.All:
            self.layer.borderColor = color.CGColor
            self.layer.borderWidth = thickness
            
        default:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), thickness)
        }
        return border
    }
}

private var shimmerViewKey: UInt8 = 1

extension UIView {
    var shimmer : FBShimmeringView?{
        get {
            return objc_getAssociatedObject(self, &shimmerViewKey) as? FBShimmeringView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &shimmerViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func updateShimmer() {
        if self.shimmer == nil {
            self.shimmer = FBShimmeringView(frame: self.bounds)
        }
        self.shimmer?.frame = self.bounds
    }
    
    func removeShimmer() {
        self.shimmer?.removeFromSuperview()
        self.shimmer = nil
    }
}
