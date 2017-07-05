//
//  PaintCodeIcon3.swift
//  Buddify
//
//  Created by Huy Le on 3/30/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {
	
	//1x1
	public class func maleIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
        //// Subframes
        let bounds: CGRect = CGRect(x: size.width * 0.0361, y: 0.006 * size.height, width: size.width * 0.928, height: size.height * 0.987)
        
        
        //// bounds
        //// Artboard-1
        //// Fill-1 Drawing
        let fill1Path = UIBezierPath()
        fill1Path.moveToPoint(CGPointMake(bounds.minX + 0.46204 * bounds.width, bounds.minY + 0.89537 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.11126 * bounds.width, bounds.minY + 0.56499 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.26859 * bounds.width, bounds.minY + 0.89537 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.11126 * bounds.width, bounds.minY + 0.74717 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.46204 * bounds.width, bounds.minY + 0.23461 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.11126 * bounds.width, bounds.minY + 0.38282 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.26859 * bounds.width, bounds.minY + 0.23461 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.81335 * bounds.width, bounds.minY + 0.56499 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.65576 * bounds.width, bounds.minY + 0.23461 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.81335 * bounds.width, bounds.minY + 0.38282 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.46204 * bounds.width, bounds.minY + 0.89537 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.81335 * bounds.width, bounds.minY + 0.74717 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.65576 * bounds.width, bounds.minY + 0.89537 * bounds.height))
        fill1Path.closePath()
        fill1Path.moveToPoint(CGPointMake(bounds.minX + 0.98979 * bounds.width, bounds.minY + 0.02216 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.98037 * bounds.width, bounds.minY + 0.01280 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.98822 * bounds.width, bounds.minY + 0.02019 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.98508 * bounds.width, bounds.minY + 0.01625 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.97382 * bounds.width, bounds.minY + 0.00812 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.97853 * bounds.width, bounds.minY + 0.01132 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.97592 * bounds.width, bounds.minY + 0.00935 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.97120 * bounds.width, bounds.minY + 0.00665 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.97330 * bounds.width, bounds.minY + 0.00788 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.97173 * bounds.width, bounds.minY + 0.00689 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.96440 * bounds.width, bounds.minY + 0.00394 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.96937 * bounds.width, bounds.minY + 0.00591 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.96702 * bounds.width, bounds.minY + 0.00468 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.94424 * bounds.width, bounds.minY + 0.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.95812 * bounds.width, bounds.minY + 0.00148 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.95131 * bounds.width, bounds.minY + 0.00000 * bounds.height))
        fill1Path.addLineToPoint(CGPointMake(bounds.minX + 0.74136 * bounds.width, bounds.minY + 0.00000 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.68586 * bounds.width, bounds.minY + 0.05244 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.71073 * bounds.width, bounds.minY + 0.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.68586 * bounds.width, bounds.minY + 0.02363 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.74136 * bounds.width, bounds.minY + 0.10463 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.68586 * bounds.width, bounds.minY + 0.08173 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.71021 * bounds.width, bounds.minY + 0.10463 * bounds.height))
        fill1Path.addLineToPoint(CGPointMake(bounds.minX + 0.81885 * bounds.width, bounds.minY + 0.10463 * bounds.height))
        fill1Path.addLineToPoint(CGPointMake(bounds.minX + 0.72199 * bounds.width, bounds.minY + 0.20556 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.46204 * bounds.width, bounds.minY + 0.12999 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.64476 * bounds.width, bounds.minY + 0.15608 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.55524 * bounds.width, bounds.minY + 0.12999 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.56499 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.20733 * bounds.width, bounds.minY + 0.12999 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.32521 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.46204 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.80478 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.20733 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.92461 * bounds.width, bounds.minY + 0.56499 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.71702 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.92461 * bounds.width, bounds.minY + 0.80478 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.80576 * bounds.width, bounds.minY + 0.27425 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.92461 * bounds.width, bounds.minY + 0.45716 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.88246 * bounds.width, bounds.minY + 0.35451 * bounds.height))
        fill1Path.addLineToPoint(CGPointMake(bounds.minX + 0.88874 * bounds.width, bounds.minY + 0.18833 * bounds.height))
        fill1Path.addLineToPoint(CGPointMake(bounds.minX + 0.88874 * bounds.width, bounds.minY + 0.24988 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.94424 * bounds.width, bounds.minY + 0.30207 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.88874 * bounds.width, bounds.minY + 0.27917 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.91309 * bounds.width, bounds.minY + 0.30207 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.24988 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.97487 * bounds.width, bounds.minY + 0.30207 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.27868 * bounds.height))
        fill1Path.addLineToPoint(CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.05244 * bounds.height))
        fill1Path.addCurveToPoint(CGPointMake(bounds.minX + 0.98979 * bounds.width, bounds.minY + 0.02216 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.04136 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.99634 * bounds.width, bounds.minY + 0.03077 * bounds.height))
        fill1Path.closePath()
        fill1Path.miterLimit = 4;
        
        fill1Path.usesEvenOddFillRule = true;
        
        fillColor.setFill()
        fill1Path.fill()
        
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//1x1
	public class func femaleIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
        //// Subframes
        let bounds: CGRect = CGRect(x: 0.12 * size.width, y: 0.007 * size.height, width: 0.76 * size.width, height: 0.986 * size.height)
        
        
        //// bounds
        //// Artboard-1
        //// Fill-3 Drawing
        let fill3Path = UIBezierPath()
        fill3Path.moveToPoint(CGPointMake(bounds.minX + 0.50014 * bounds.width, bounds.minY + 0.09273 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.76847 * bounds.width, bounds.minY + 0.17827 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.60119 * bounds.width, bounds.minY + 0.09273 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.69658 * bounds.width, bounds.minY + 0.12306 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.87971 * bounds.width, bounds.minY + 0.38534 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.84036 * bounds.width, bounds.minY + 0.23369 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.87971 * bounds.width, bounds.minY + 0.30744 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.76875 * bounds.width, bounds.minY + 0.59241 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.87971 * bounds.width, bounds.minY + 0.46345 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.84036 * bounds.width, bounds.minY + 0.53698 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.50014 * bounds.width, bounds.minY + 0.67816 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.69658 * bounds.width, bounds.minY + 0.64761 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.60119 * bounds.width, bounds.minY + 0.67816 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.23153 * bounds.width, bounds.minY + 0.59241 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.39881 * bounds.width, bounds.minY + 0.67816 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.30342 * bounds.width, bounds.minY + 0.64761 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.12029 * bounds.width, bounds.minY + 0.38534 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.15992 * bounds.width, bounds.minY + 0.53698 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.12029 * bounds.width, bounds.minY + 0.46345 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.23153 * bounds.width, bounds.minY + 0.17827 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.12029 * bounds.width, bounds.minY + 0.30744 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.15992 * bounds.width, bounds.minY + 0.23391 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.50014 * bounds.width, bounds.minY + 0.09273 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.30371 * bounds.width, bounds.minY + 0.12306 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.39909 * bounds.width, bounds.minY + 0.09273 * bounds.height))
        fill3Path.closePath()
        fill3Path.moveToPoint(CGPointMake(bounds.minX + 0.85338 * bounds.width, bounds.minY + 0.65765 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.38534 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.94792 * bounds.width, bounds.minY + 0.58521 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.48854 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.85367 * bounds.width, bounds.minY + 0.11303 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.28235 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.94792 * bounds.width, bounds.minY + 0.18547 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.50014 * bounds.width, bounds.minY + 0.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.75941 * bounds.width, bounds.minY + 0.04015 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.63374 * bounds.width, bounds.minY + 0.00000 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.14690 * bounds.width, bounds.minY + 0.11303 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.36654 * bounds.width, bounds.minY + 0.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.24115 * bounds.width, bounds.minY + 0.04015 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.38534 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.05208 * bounds.width, bounds.minY + 0.18547 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.28213 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.14662 * bounds.width, bounds.minY + 0.65765 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.48854 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.05208 * bounds.width, bounds.minY + 0.58521 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.43985 * bounds.width, bounds.minY + 0.76784 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.22559 * bounds.width, bounds.minY + 0.71896 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.32918 * bounds.width, bounds.minY + 0.75780 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.43985 * bounds.width, bounds.minY + 0.83417 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.40476 * bounds.width, bounds.minY + 0.83417 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.34447 * bounds.width, bounds.minY + 0.88043 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.37107 * bounds.width, bounds.minY + 0.83417 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.34447 * bounds.width, bounds.minY + 0.85446 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.40476 * bounds.width, bounds.minY + 0.92690 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.34447 * bounds.width, bounds.minY + 0.90596 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.37164 * bounds.width, bounds.minY + 0.92690 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.43985 * bounds.width, bounds.minY + 0.92690 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.43985 * bounds.width, bounds.minY + 0.95374 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.50014 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.43985 * bounds.width, bounds.minY + 0.97927 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.46674 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.56015 * bounds.width, bounds.minY + 0.95374 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.53326 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.56015 * bounds.width, bounds.minY + 0.97927 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.56015 * bounds.width, bounds.minY + 0.92690 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.59581 * bounds.width, bounds.minY + 0.92690 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.65582 * bounds.width, bounds.minY + 0.88043 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.62893 * bounds.width, bounds.minY + 0.92690 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.65582 * bounds.width, bounds.minY + 0.90596 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.59581 * bounds.width, bounds.minY + 0.83417 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.65582 * bounds.width, bounds.minY + 0.85490 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.62893 * bounds.width, bounds.minY + 0.83417 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.56015 * bounds.width, bounds.minY + 0.83417 * bounds.height))
        fill3Path.addLineToPoint(CGPointMake(bounds.minX + 0.56015 * bounds.width, bounds.minY + 0.76784 * bounds.height))
        fill3Path.addCurveToPoint(CGPointMake(bounds.minX + 0.85338 * bounds.width, bounds.minY + 0.65765 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.67082 * bounds.width, bounds.minY + 0.75780 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.77441 * bounds.width, bounds.minY + 0.71896 * bounds.height))
        fill3Path.closePath()
        fill3Path.miterLimit = 4;
        
        fill3Path.usesEvenOddFillRule = true;
        
        fillColor.setFill()
        fill3Path.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//Size 1x1
	public class func airPlaneIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.72445 * frame.width, frame.minY + 0.29737 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72469 * frame.width, frame.minY + 0.29761 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.54633 * frame.width, frame.minY + 0.69952 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.47886 * frame.width, frame.minY + 0.54296 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72445 * frame.width, frame.minY + 0.29737 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.66838 * frame.width, frame.minY + 0.24050 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.66830 * frame.width, frame.minY + 0.24041 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.26623 * frame.width, frame.minY + 0.41884 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.42243 * frame.width, frame.minY + 0.48645 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.66838 * frame.width, frame.minY + 0.24050 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.52410 * frame.width, frame.minY + 0.94217 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.38079 * frame.width, frame.minY + 0.61107 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.04971 * frame.width, frame.minY + 0.46776 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.04934 * frame.width, frame.minY + 0.42506 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02288 * frame.width, frame.minY + 0.45615 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02254 * frame.width, frame.minY + 0.43695 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93100 * frame.width, frame.minY + 0.03397 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.95800 * frame.width, frame.minY + 0.06097 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95773 * frame.width, frame.minY + 0.02212 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.96990 * frame.width, frame.minY + 0.03417 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.56680 * frame.width, frame.minY + 0.94254 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.52410 * frame.width, frame.minY + 0.94217 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55494 * frame.width, frame.minY + 0.96926 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.53579 * frame.width, frame.minY + 0.96918 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//Size 1x1
	public class func exportIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.89177 * frame.width, frame.minY + 0.39242 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72778 * frame.width, frame.minY + 0.22561 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72778 * frame.width, frame.minY + 0.27834 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.68477 * frame.width, frame.minY + 0.32211 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72778 * frame.width, frame.minY + 0.30252 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.70889 * frame.width, frame.minY + 0.32211 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.37701 * frame.width, frame.minY + 0.42887 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55068 * frame.width, frame.minY + 0.32211 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44742 * frame.width, frame.minY + 0.35803 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.30845 * frame.width, frame.minY + 0.53119 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34493 * frame.width, frame.minY + 0.46114 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32324 * frame.width, frame.minY + 0.49717 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.61779 * frame.width, frame.minY + 0.45967 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.41025 * frame.width, frame.minY + 0.47056 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.53877 * frame.width, frame.minY + 0.45967 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.68958 * frame.width, frame.minY + 0.46301 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65856 * frame.width, frame.minY + 0.45967 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68560 * frame.width, frame.minY + 0.46257 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72778 * frame.width, frame.minY + 0.50653 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.71169 * frame.width, frame.minY + 0.46548 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72778 * frame.width, frame.minY + 0.48421 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72778 * frame.width, frame.minY + 0.55926 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.89177 * frame.width, frame.minY + 0.39242 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.98558 * frame.width, frame.minY + 0.42315 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.71657 * frame.width, frame.minY + 0.69681 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66859 * frame.width, frame.minY + 0.70659 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.70413 * frame.width, frame.minY + 0.70946 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68501 * frame.width, frame.minY + 0.71333 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.64119 * frame.width, frame.minY + 0.66608 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65219 * frame.width, frame.minY + 0.69986 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.64119 * frame.width, frame.minY + 0.68384 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.64119 * frame.width, frame.minY + 0.54778 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.27143 * frame.width, frame.minY + 0.68756 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55458 * frame.width, frame.minY + 0.54531 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.34646 * frame.width, frame.minY + 0.55400 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.23352 * frame.width, frame.minY + 0.70987 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.26356 * frame.width, frame.minY + 0.70158 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.24901 * frame.width, frame.minY + 0.70987 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.22259 * frame.width, frame.minY + 0.70845 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22986 * frame.width, frame.minY + 0.70987 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22625 * frame.width, frame.minY + 0.70941 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.18994 * frame.width, frame.minY + 0.66625 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.20340 * frame.width, frame.minY + 0.70345 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.19002 * frame.width, frame.minY + 0.68611 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.31506 * frame.width, frame.minY + 0.36707 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.18991 * frame.width, frame.minY + 0.65921 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.19046 * frame.width, frame.minY + 0.49243 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.64119 * frame.width, frame.minY + 0.23574 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.39426 * frame.width, frame.minY + 0.28740 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.50046 * frame.width, frame.minY + 0.24331 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.64119 * frame.width, frame.minY + 0.11879 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66859 * frame.width, frame.minY + 0.07828 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64119 * frame.width, frame.minY + 0.10103 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65219 * frame.width, frame.minY + 0.08501 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.71642 * frame.width, frame.minY + 0.08805 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68499 * frame.width, frame.minY + 0.07153 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.70397 * frame.width, frame.minY + 0.07540 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.98549 * frame.width, frame.minY + 0.36169 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98558 * frame.width, frame.minY + 0.42315 * frame.height), controlPoint1: CGPointMake(frame.minX + 1.00225 * frame.width, frame.minY + 0.37873 * frame.height), controlPoint2: CGPointMake(frame.minX + 1.00233 * frame.width, frame.minY + 0.40610 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.98558 * frame.width, frame.minY + 0.42315 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.79273 * frame.width, frame.minY + 0.82706 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.79273 * frame.width, frame.minY + 0.88165 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74816 * frame.width, frame.minY + 0.91909 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.79273 * frame.width, frame.minY + 0.90583 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77228 * frame.width, frame.minY + 0.91909 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.04178 * frame.width, frame.minY + 0.91909 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.00250 * frame.width, frame.minY + 0.88165 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01766 * frame.width, frame.minY + 0.91909 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00250 * frame.width, frame.minY + 0.90583 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00250 * frame.width, frame.minY + 0.34647 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.04178 * frame.width, frame.minY + 0.30105 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00250 * frame.width, frame.minY + 0.32229 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01766 * frame.width, frame.minY + 0.30105 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.16861 * frame.width, frame.minY + 0.30105 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.21230 * frame.width, frame.minY + 0.34442 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.19273 * frame.width, frame.minY + 0.30105 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.21230 * frame.width, frame.minY + 0.32024 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.16861 * frame.width, frame.minY + 0.38779 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.21230 * frame.width, frame.minY + 0.36859 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.19273 * frame.width, frame.minY + 0.38779 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.08911 * frame.width, frame.minY + 0.38779 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.08911 * frame.width, frame.minY + 0.83235 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.70613 * frame.width, frame.minY + 0.83235 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.70613 * frame.width, frame.minY + 0.82706 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74944 * frame.width, frame.minY + 0.78327 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.70613 * frame.width, frame.minY + 0.80287 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72530 * frame.width, frame.minY + 0.78327 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.79273 * frame.width, frame.minY + 0.82706 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77356 * frame.width, frame.minY + 0.78327 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.79273 * frame.width, frame.minY + 0.80287 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.79273 * frame.width, frame.minY + 0.82706 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//Size 1x1
	public class func filterIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.82504 * frame.width, frame.minY + 0.12500 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.82504 * frame.width, frame.minY + 0.12500 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.83015 * frame.width, frame.minY + 0.12500 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.82951 * frame.width, frame.minY + 0.12767 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.82993 * frame.width, frame.minY + 0.12586 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.82971 * frame.width, frame.minY + 0.12675 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.83590 * frame.width, frame.minY + 0.17614 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.82618 * frame.width, frame.minY + 0.14279 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.82782 * frame.width, frame.minY + 0.16000 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.87098 * frame.width, frame.minY + 0.21033 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84400 * frame.width, frame.minY + 0.19231 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.85683 * frame.width, frame.minY + 0.20394 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.87351 * frame.width, frame.minY + 0.21142 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.87183 * frame.width, frame.minY + 0.21072 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.87268 * frame.width, frame.minY + 0.21108 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.87046 * frame.width, frame.minY + 0.21551 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.12295 * frame.width, frame.minY + 0.21551 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.11991 * frame.width, frame.minY + 0.21143 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.12241 * frame.width, frame.minY + 0.21036 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.12073 * frame.width, frame.minY + 0.21110 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.12157 * frame.width, frame.minY + 0.21074 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.15737 * frame.width, frame.minY + 0.17646 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.13647 * frame.width, frame.minY + 0.20403 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.14925 * frame.width, frame.minY + 0.19251 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.16394 * frame.width, frame.minY + 0.12787 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16554 * frame.width, frame.minY + 0.16033 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16725 * frame.width, frame.minY + 0.14308 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.16326 * frame.width, frame.minY + 0.12500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16373 * frame.width, frame.minY + 0.12689 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16350 * frame.width, frame.minY + 0.12593 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.16836 * frame.width, frame.minY + 0.12500 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.44482 * frame.width, frame.minY + 0.49582 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.46276 * frame.width, frame.minY + 0.51989 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.46276 * frame.width, frame.minY + 0.54991 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.46276 * frame.width, frame.minY + 0.85319 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.42531 * frame.width, frame.minY + 0.87021 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.37225 * frame.width, frame.minY + 0.83605 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.37225 * frame.width, frame.minY + 0.79491 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.58370 * frame.width, frame.minY + 0.69880 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53064 * frame.width, frame.minY + 0.78119 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53064 * frame.width, frame.minY + 0.54991 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53064 * frame.width, frame.minY + 0.51989 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.54859 * frame.width, frame.minY + 0.49582 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.82504 * frame.width, frame.minY + 0.12500 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.91093 * frame.width, frame.minY + 0.16123 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.91093 * frame.width, frame.minY + 0.16123 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.62115 * frame.width, frame.minY + 0.54991 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.62115 * frame.width, frame.minY + 0.78119 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.37225 * frame.width, frame.minY + 0.89433 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.37225 * frame.width, frame.minY + 0.54991 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.08248 * frame.width, frame.minY + 0.16123 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.10075 * frame.width, frame.minY + 0.12500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.06750 * frame.width, frame.minY + 0.14114 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.07574 * frame.width, frame.minY + 0.12500 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.89265 * frame.width, frame.minY + 0.12500 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.91093 * frame.width, frame.minY + 0.16123 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.91784 * frame.width, frame.minY + 0.12500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.92584 * frame.width, frame.minY + 0.14122 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.91093 * frame.width, frame.minY + 0.16123 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()

		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
}