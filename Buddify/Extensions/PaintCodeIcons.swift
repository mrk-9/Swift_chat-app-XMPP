//
//  PaintCodeIcons.swift
//  Buddify
//
//  Created by Vo Duc Tung on 13/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {
        
	//SIZE 1x1
    public class func tabbarDiscoveryIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50139 * frame.width, frame.minY + 0.98753 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.50018 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.76415 * frame.width, frame.minY + 0.98753 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.76934 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50139 * frame.width, frame.minY + 0.01282 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.23102 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76415 * frame.width, frame.minY + 0.01282 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.02564 * frame.width, frame.minY + 0.50018 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.23864 * frame.width, frame.minY + 0.01282 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02564 * frame.width, frame.minY + 0.23102 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50139 * frame.width, frame.minY + 0.98753 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02564 * frame.width, frame.minY + 0.76934 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.23864 * frame.width, frame.minY + 0.98753 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50139 * frame.width, frame.minY + 0.89018 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11847 * frame.width, frame.minY + 0.49791 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.28991 * frame.width, frame.minY + 0.89018 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.11847 * frame.width, frame.minY + 0.71455 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50139 * frame.width, frame.minY + 0.10565 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.11847 * frame.width, frame.minY + 0.28127 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28991 * frame.width, frame.minY + 0.10565 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88432 * frame.width, frame.minY + 0.49791 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.71288 * frame.width, frame.minY + 0.10565 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.88432 * frame.width, frame.minY + 0.28127 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50139 * frame.width, frame.minY + 0.89018 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.88432 * frame.width, frame.minY + 0.71455 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.71288 * frame.width, frame.minY + 0.89018 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.64072 * frame.width, frame.minY + 0.31992 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.61516 * frame.width, frame.minY + 0.30333 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64845 * frame.width, frame.minY + 0.29256 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.63713 * frame.width, frame.minY + 0.28502 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.48972 * frame.width, frame.minY + 0.40780 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.40956 * frame.width, frame.minY + 0.53124 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.45703 * frame.width, frame.minY + 0.43503 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.42110 * frame.width, frame.minY + 0.49042 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.36514 * frame.width, frame.minY + 0.68833 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39069 * frame.width, frame.minY + 0.70492 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.35740 * frame.width, frame.minY + 0.71569 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36872 * frame.width, frame.minY + 0.72322 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.51613 * frame.width, frame.minY + 0.60045 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.59630 * frame.width, frame.minY + 0.47701 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54883 * frame.width, frame.minY + 0.57322 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58475 * frame.width, frame.minY + 0.51783 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.64072 * frame.width, frame.minY + 0.31992 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()
		
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
	//SIZE 1x1
    public class func tabbarProfileIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.15368 * frame.width, frame.minY + 0.84102 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.20104 * frame.width, frame.minY + 0.78110 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16749 * frame.width, frame.minY + 0.81711 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.18333 * frame.width, frame.minY + 0.79679 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39982 * frame.width, frame.minY + 0.68627 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25677 * frame.width, frame.minY + 0.73169 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33784 * frame.width, frame.minY + 0.69871 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.42620 * frame.width, frame.minY + 0.50834 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.47749 * frame.width, frame.minY + 0.67067 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.49163 * frame.width, frame.minY + 0.54826 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.33047 * frame.width, frame.minY + 0.31854 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36880 * frame.width, frame.minY + 0.47332 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33047 * frame.width, frame.minY + 0.40064 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49999 * frame.width, frame.minY + 0.10745 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.33047 * frame.width, frame.minY + 0.19619 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.40381 * frame.width, frame.minY + 0.10745 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66952 * frame.width, frame.minY + 0.31854 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.59582 * frame.width, frame.minY + 0.10745 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66952 * frame.width, frame.minY + 0.19689 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.57378 * frame.width, frame.minY + 0.50834 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66952 * frame.width, frame.minY + 0.40064 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.63118 * frame.width, frame.minY + 0.47332 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60016 * frame.width, frame.minY + 0.68627 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.50835 * frame.width, frame.minY + 0.54826 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.52250 * frame.width, frame.minY + 0.67067 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.79895 * frame.width, frame.minY + 0.78110 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66215 * frame.width, frame.minY + 0.69871 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.74321 * frame.width, frame.minY + 0.73169 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.84631 * frame.width, frame.minY + 0.84102 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.81666 * frame.width, frame.minY + 0.79679 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83250 * frame.width, frame.minY + 0.81711 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.86906 * frame.width, frame.minY + 0.89255 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.85987 * frame.width, frame.minY + 0.86452 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86906 * frame.width, frame.minY + 0.89255 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49857 * frame.width, frame.minY + 0.89255 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.13747 * frame.width, frame.minY + 0.89255 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.15368 * frame.width, frame.minY + 0.84102 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.13747 * frame.width, frame.minY + 0.89255 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.14011 * frame.width, frame.minY + 0.86452 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.01385 * frame.width, frame.minY + 0.93148 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.05978 * frame.width, frame.minY + 0.98718 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00789 * frame.width, frame.minY + 0.96224 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02848 * frame.width, frame.minY + 0.98718 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.06300 * frame.width, frame.minY + 0.98718 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49857 * frame.width, frame.minY + 0.98718 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93698 * frame.width, frame.minY + 0.98718 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.94021 * frame.width, frame.minY + 0.98718 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98614 * frame.width, frame.minY + 0.93148 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97153 * frame.width, frame.minY + 0.98718 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.99215 * frame.width, frame.minY + 0.96252 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.98611 * frame.width, frame.minY + 0.93132 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.97448 * frame.width, frame.minY + 0.88809 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98431 * frame.width, frame.minY + 0.92205 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98058 * frame.width, frame.minY + 0.90703 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.93394 * frame.width, frame.minY + 0.79562 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.96439 * frame.width, frame.minY + 0.85671 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95107 * frame.width, frame.minY + 0.82530 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.86719 * frame.width, frame.minY + 0.71200 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.91535 * frame.width, frame.minY + 0.76342 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89330 * frame.width, frame.minY + 0.73514 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.67201 * frame.width, frame.minY + 0.60618 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.80899 * frame.width, frame.minY + 0.66041 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73847 * frame.width, frame.minY + 0.62572 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.62786 * frame.width, frame.minY + 0.59524 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65702 * frame.width, frame.minY + 0.60177 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.64225 * frame.width, frame.minY + 0.59813 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.62786 * frame.width, frame.minY + 0.58521 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.76940 * frame.width, frame.minY + 0.31854 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.71502 * frame.width, frame.minY + 0.53203 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76940 * frame.width, frame.minY + 0.43162 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49999 * frame.width, frame.minY + 0.01282 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.76940 * frame.width, frame.minY + 0.14904 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65716 * frame.width, frame.minY + 0.01282 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.23058 * frame.width, frame.minY + 0.31854 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34255 * frame.width, frame.minY + 0.01282 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.23058 * frame.width, frame.minY + 0.14830 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.37212 * frame.width, frame.minY + 0.58521 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.23058 * frame.width, frame.minY + 0.43162 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28496 * frame.width, frame.minY + 0.53203 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.37212 * frame.width, frame.minY + 0.59524 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.13279 * frame.width, frame.minY + 0.71200 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29393 * frame.width, frame.minY + 0.61094 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.20411 * frame.width, frame.minY + 0.64878 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.06604 * frame.width, frame.minY + 0.79562 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.10669 * frame.width, frame.minY + 0.73514 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.08463 * frame.width, frame.minY + 0.76342 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.02550 * frame.width, frame.minY + 0.88809 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04891 * frame.width, frame.minY + 0.82530 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.03559 * frame.width, frame.minY + 0.85671 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01388 * frame.width, frame.minY + 0.93132 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01941 * frame.width, frame.minY + 0.90703 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01568 * frame.width, frame.minY + 0.92205 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.01385 * frame.width, frame.minY + 0.93148 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
	//SIZE 1x1
    public class func tabbarConversationIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.90509 * frame.width, frame.minY + 0.73647 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90509 * frame.width, frame.minY + 0.27232 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.09283 * frame.width, frame.minY + 0.27232 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.09283 * frame.width, frame.minY + 0.73647 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90509 * frame.width, frame.minY + 0.73647 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90509 * frame.width, frame.minY + 0.73647 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.22570 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.04646 * frame.width, frame.minY + 0.17949 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.20018 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02084 * frame.width, frame.minY + 0.17949 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.95146 * frame.width, frame.minY + 0.17949 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.99792 * frame.width, frame.minY + 0.22570 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97712 * frame.width, frame.minY + 0.17949 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.99792 * frame.width, frame.minY + 0.20037 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.99792 * frame.width, frame.minY + 0.78308 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.95146 * frame.width, frame.minY + 0.82930 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.99792 * frame.width, frame.minY + 0.80861 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97708 * frame.width, frame.minY + 0.82930 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.04646 * frame.width, frame.minY + 0.82930 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.78308 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02080 * frame.width, frame.minY + 0.82930 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.80841 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.22570 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.22570 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.18861 * frame.width, frame.minY + 0.27226 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49950 * frame.width, frame.minY + 0.52982 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.81073 * frame.width, frame.minY + 0.27199 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.18861 * frame.width, frame.minY + 0.27226 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.18861 * frame.width, frame.minY + 0.27226 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()
		
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
	//SIZE 1x1
    public class func tabbarTimelineIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.07558 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.07558 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.40013 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.35020 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.37260 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09234 * frame.width, frame.minY + 0.35020 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.35020 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.40013 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36916 * frame.width, frame.minY + 0.35020 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.37265 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.07558 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.12551 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.10310 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36920 * frame.width, frame.minY + 0.12551 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.12551 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.07558 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.09238 * frame.width, frame.minY + 0.12551 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.10306 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.07558 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.07558 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.02564 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.04800 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.03564 * frame.width, frame.minY + 0.02564 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.02564 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.07558 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42576 * frame.width, frame.minY + 0.02564 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.04786 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.40013 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.45007 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.42771 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.42590 * frame.width, frame.minY + 0.45007 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.45007 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.40013 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.03578 * frame.width, frame.minY + 0.45007 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.42785 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.07558 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.65385 * frame.width, frame.minY + 0.07564 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.65385 * frame.width, frame.minY + 0.92436 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60257 * frame.width, frame.minY + 0.87449 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65385 * frame.width, frame.minY + 0.89680 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.63101 * frame.width, frame.minY + 0.87449 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93589 * frame.width, frame.minY + 0.87449 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88462 * frame.width, frame.minY + 0.92436 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.90759 * frame.width, frame.minY + 0.87449 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.88462 * frame.width, frame.minY + 0.89694 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.88462 * frame.width, frame.minY + 0.07564 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.93589 * frame.width, frame.minY + 0.12551 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.88462 * frame.width, frame.minY + 0.10320 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.90746 * frame.width, frame.minY + 0.12551 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.60257 * frame.width, frame.minY + 0.12551 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.65385 * frame.width, frame.minY + 0.07564 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.63087 * frame.width, frame.minY + 0.12551 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65385 * frame.width, frame.minY + 0.10306 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.55128 * frame.width, frame.minY + 0.07564 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60257 * frame.width, frame.minY + 0.02564 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55128 * frame.width, frame.minY + 0.04803 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57410 * frame.width, frame.minY + 0.02564 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93589 * frame.width, frame.minY + 0.02564 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98718 * frame.width, frame.minY + 0.07564 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.96422 * frame.width, frame.minY + 0.02564 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98718 * frame.width, frame.minY + 0.04816 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.98718 * frame.width, frame.minY + 0.92436 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.93589 * frame.width, frame.minY + 0.97436 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98718 * frame.width, frame.minY + 0.95197 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.96436 * frame.width, frame.minY + 0.97436 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.60257 * frame.width, frame.minY + 0.97436 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.55128 * frame.width, frame.minY + 0.92436 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.57424 * frame.width, frame.minY + 0.97436 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.55128 * frame.width, frame.minY + 0.95184 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.55128 * frame.width, frame.minY + 0.07564 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.59987 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.92442 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.87449 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.89689 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09234 * frame.width, frame.minY + 0.87449 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.87449 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.92442 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36916 * frame.width, frame.minY + 0.87449 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.89694 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.59987 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.64980 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34615 * frame.width, frame.minY + 0.62740 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36920 * frame.width, frame.minY + 0.64980 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.64980 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.59987 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.09238 * frame.width, frame.minY + 0.64980 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.11538 * frame.width, frame.minY + 0.62735 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.59987 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.54993 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.57229 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.03564 * frame.width, frame.minY + 0.54993 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.54993 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.59987 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42576 * frame.width, frame.minY + 0.54993 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.57215 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.92442 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39743 * frame.width, frame.minY + 0.97436 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.44872 * frame.width, frame.minY + 0.95200 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.42590 * frame.width, frame.minY + 0.97436 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.06411 * frame.width, frame.minY + 0.97436 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.92442 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.03578 * frame.width, frame.minY + 0.97436 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.95214 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.59987 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.01282 * frame.width, frame.minY + 0.59987 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()
		
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
		
        return image
    }
    
    //SIZE 1x1
    public class func tabbarNotificationIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.56766 * frame.width, frame.minY + 0.07813 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.81728 * frame.width, frame.minY + 0.38130 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.70340 * frame.width, frame.minY + 0.11207 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.81728 * frame.width, frame.minY + 0.24108 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.92635 * frame.width, frame.minY + 0.75654 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.81728 * frame.width, frame.minY + 0.53702 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.85806 * frame.width, frame.minY + 0.68633 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93832 * frame.width, frame.minY + 0.76885 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.91025 * frame.width, frame.minY + 0.83532 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97400 * frame.width, frame.minY + 0.80554 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.96146 * frame.width, frame.minY + 0.83532 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.89308 * frame.width, frame.minY + 0.83532 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49855 * frame.width, frame.minY + 0.83532 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.10402 * frame.width, frame.minY + 0.83532 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.08685 * frame.width, frame.minY + 0.83532 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.05878 * frame.width, frame.minY + 0.76885 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.03567 * frame.width, frame.minY + 0.83532 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02307 * frame.width, frame.minY + 0.80556 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.07075 * frame.width, frame.minY + 0.75654 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.17982 * frame.width, frame.minY + 0.38130 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.13904 * frame.width, frame.minY + 0.68633 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.17982 * frame.width, frame.minY + 0.53702 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.42944 * frame.width, frame.minY + 0.07813 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.17982 * frame.width, frame.minY + 0.24108 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.29370 * frame.width, frame.minY + 0.11207 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.42893 * frame.width, frame.minY + 0.06962 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42910 * frame.width, frame.minY + 0.07534 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.42893 * frame.width, frame.minY + 0.07250 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49855 * frame.width, frame.minY + 0.00000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42893 * frame.width, frame.minY + 0.03117 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.46010 * frame.width, frame.minY + 0.00000 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.56817 * frame.width, frame.minY + 0.06962 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.53700 * frame.width, frame.minY + 0.00000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56817 * frame.width, frame.minY + 0.03117 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.56766 * frame.width, frame.minY + 0.07813 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56817 * frame.width, frame.minY + 0.07250 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56800 * frame.width, frame.minY + 0.07534 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.19402 * frame.width, frame.minY + 0.74249 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.27265 * frame.width, frame.minY + 0.38130 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.23501 * frame.width, frame.minY + 0.66209 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.27265 * frame.width, frame.minY + 0.50342 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49855 * frame.width, frame.minY + 0.16231 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.27265 * frame.width, frame.minY + 0.26996 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38511 * frame.width, frame.minY + 0.16231 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72445 * frame.width, frame.minY + 0.38130 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.61199 * frame.width, frame.minY + 0.16231 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72445 * frame.width, frame.minY + 0.26996 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.80747 * frame.width, frame.minY + 0.74249 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72445 * frame.width, frame.minY + 0.50084 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.75561 * frame.width, frame.minY + 0.65838 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49855 * frame.width, frame.minY + 0.74249 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19402 * frame.width, frame.minY + 0.74249 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.49855 * frame.width, frame.minY + 0.99777 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.61459 * frame.width, frame.minY + 0.88174 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56263 * frame.width, frame.minY + 0.99777 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.61459 * frame.width, frame.minY + 0.94582 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.38251 * frame.width, frame.minY + 0.88174 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49855 * frame.width, frame.minY + 0.99777 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.38251 * frame.width, frame.minY + 0.94582 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.43446 * frame.width, frame.minY + 0.99777 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()

		
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
 
}