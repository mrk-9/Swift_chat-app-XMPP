//
//  PaintCodeIcon4.swift
//  Buddify
//
//  Created by Huy Le on 3/30/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {
	
	//1x1
	public class func cancecIconRound(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Oval 4 Drawing
		let oval4Path = UIBezierPath(ovalInRect: CGRectMake(frame.minX + floor(frame.width * 0.05303) + 0.5, frame.minY + floor(frame.height * 0.04242 + 0.4) + 0.1, floor(frame.width * 0.96364 - 0.1) - floor(frame.width * 0.05303) + 0.1, floor(frame.height * 0.95303 + 0.3) - floor(frame.height * 0.04242 + 0.4) + 0.1))
		fillColor.setStroke()
		oval4Path.miterLimit = 4
		oval4Path.stroke()
		
		
		//// Bezier 46 Drawing
		let bezier46Path = UIBezierPath()
		bezier46Path.moveToPoint(CGPointMake(frame.minX + 0.68117 * frame.width, frame.minY + 0.63693 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.68117 * frame.width, frame.minY + 0.67026 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69039 * frame.width, frame.minY + 0.64615 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.69039 * frame.width, frame.minY + 0.66102 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.66440 * frame.width, frame.minY + 0.67711 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.67645 * frame.width, frame.minY + 0.67497 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.67054 * frame.width, frame.minY + 0.67711 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.64761 * frame.width, frame.minY + 0.67026 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65823 * frame.width, frame.minY + 0.67711 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65233 * frame.width, frame.minY + 0.67497 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.50837 * frame.width, frame.minY + 0.53102 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.36914 * frame.width, frame.minY + 0.67026 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.35236 * frame.width, frame.minY + 0.67711 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36442 * frame.width, frame.minY + 0.67497 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35851 * frame.width, frame.minY + 0.67711 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.33558 * frame.width, frame.minY + 0.67026 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34622 * frame.width, frame.minY + 0.67711 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.34031 * frame.width, frame.minY + 0.67497 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.33558 * frame.width, frame.minY + 0.63693 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.32636 * frame.width, frame.minY + 0.66102 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32636 * frame.width, frame.minY + 0.64615 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.47504 * frame.width, frame.minY + 0.49768 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.33558 * frame.width, frame.minY + 0.35823 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.33558 * frame.width, frame.minY + 0.32490 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.32636 * frame.width, frame.minY + 0.34902 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32636 * frame.width, frame.minY + 0.33411 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.36914 * frame.width, frame.minY + 0.32490 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34480 * frame.width, frame.minY + 0.31568 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35969 * frame.width, frame.minY + 0.31568 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.50837 * frame.width, frame.minY + 0.46411 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.64761 * frame.width, frame.minY + 0.32490 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.68117 * frame.width, frame.minY + 0.32490 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65683 * frame.width, frame.minY + 0.31568 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.67170 * frame.width, frame.minY + 0.31568 * frame.height))
		bezier46Path.addCurveToPoint(CGPointMake(frame.minX + 0.68117 * frame.width, frame.minY + 0.35823 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69039 * frame.width, frame.minY + 0.33411 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.69039 * frame.width, frame.minY + 0.34902 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.54193 * frame.width, frame.minY + 0.49768 * frame.height))
		bezier46Path.addLineToPoint(CGPointMake(frame.minX + 0.68117 * frame.width, frame.minY + 0.63693 * frame.height))
		bezier46Path.closePath()
		bezier46Path.lineCapStyle = .Round;
		
		bezier46Path.lineJoinStyle = .Round;
		
		fillColor.setFill()
		bezier46Path.fill()


		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//1x1
	public class func penIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier 133 Drawing
		let bezier133Path = UIBezierPath()
		bezier133Path.moveToPoint(CGPointMake(frame.minX + 0.88404 * frame.width, frame.minY + 0.24058 * frame.height))
		bezier133Path.addLineToPoint(CGPointMake(frame.minX + 0.18259 * frame.width, frame.minY + 0.93011 * frame.height))
		bezier133Path.addLineToPoint(CGPointMake(frame.minX + 0.02077 * frame.width, frame.minY + 0.97280 * frame.height))
		bezier133Path.addLineToPoint(CGPointMake(frame.minX + 0.06418 * frame.width, frame.minY + 0.81372 * frame.height))
		bezier133Path.addLineToPoint(CGPointMake(frame.minX + 0.76561 * frame.width, frame.minY + 0.12416 * frame.height))
		bezier133Path.lineCapStyle = .Round;
		bezier133Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier133Path.miterLimit = 4
		bezier133Path.stroke()
		
		//// Bezier 134 Drawing
		let bezier134Path = UIBezierPath()
		bezier134Path.moveToPoint(CGPointMake(frame.minX + 0.94457 * frame.width, frame.minY + 0.21088 * frame.height))
		bezier134Path.addCurveToPoint(CGPointMake(frame.minX + 0.96238 * frame.width, frame.minY + 0.19335 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.94447 * frame.width, frame.minY + 0.21096 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.96238 * frame.width, frame.minY + 0.19335 * frame.height))
		bezier134Path.addCurveToPoint(CGPointMake(frame.minX + 0.96242 * frame.width, frame.minY + 0.04713 * frame.height), controlPoint1: CGPointMake(frame.minX + 1.00347 * frame.width, frame.minY + 0.15296 * frame.height), controlPoint2: CGPointMake(frame.minX + 1.00347 * frame.width, frame.minY + 0.08751 * frame.height))
		bezier134Path.addCurveToPoint(CGPointMake(frame.minX + 0.81362 * frame.width, frame.minY + 0.04713 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.92130 * frame.width, frame.minY + 0.00673 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.85471 * frame.width, frame.minY + 0.00678 * frame.height))
		bezier134Path.addCurveToPoint(CGPointMake(frame.minX + 0.79581 * frame.width, frame.minY + 0.06466 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.81362 * frame.width, frame.minY + 0.04713 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.79569 * frame.width, frame.minY + 0.06476 * frame.height))
		bezier134Path.addLineToPoint(CGPointMake(frame.minX + 0.94457 * frame.width, frame.minY + 0.21088 * frame.height))
		bezier134Path.closePath()
		bezier134Path.lineCapStyle = .Round;
		bezier134Path.lineJoinStyle = .Round;
		fillColor.setFill()
		bezier134Path.fill()
		
		//// Bezier 135 Drawing
		let bezier135Path = UIBezierPath()
		bezier135Path.moveToPoint(CGPointMake(frame.minX + 0.06812 * frame.width, frame.minY + 0.80982 * frame.height))
		bezier135Path.addLineToPoint(CGPointMake(frame.minX + 0.18656 * frame.width, frame.minY + 0.92624 * frame.height))
		bezier135Path.addLineToPoint(CGPointMake(frame.minX + 0.03101 * frame.width, frame.minY + 0.96272 * frame.height))
		bezier135Path.addLineToPoint(CGPointMake(frame.minX + 0.06812 * frame.width, frame.minY + 0.80982 * frame.height))
		bezier135Path.closePath()
		bezier135Path.lineCapStyle = .Round;
		bezier135Path.lineJoinStyle = .Round;
		fillColor.setFill()
		bezier135Path.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//79x61
	public class func cameraIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier 47 Drawing
		let bezier47Path = UIBezierPath()
		bezier47Path.moveToPoint(CGPointMake(frame.minX + 0.89470 * frame.width, frame.minY + 0.33229 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.86199 * frame.width, frame.minY + 0.28960 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.87672 * frame.width, frame.minY + 0.33229 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86199 * frame.width, frame.minY + 0.31320 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.89470 * frame.width, frame.minY + 0.24691 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.86199 * frame.width, frame.minY + 0.26598 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.87672 * frame.width, frame.minY + 0.24691 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.92742 * frame.width, frame.minY + 0.28960 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.91271 * frame.width, frame.minY + 0.24691 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.92742 * frame.width, frame.minY + 0.26598 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.89470 * frame.width, frame.minY + 0.33229 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.92742 * frame.width, frame.minY + 0.31320 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.91271 * frame.width, frame.minY + 0.33229 * frame.height))
		bezier47Path.closePath()
		bezier47Path.moveToPoint(CGPointMake(frame.minX + 0.50176 * frame.width, frame.minY + 0.83178 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.28579 * frame.width, frame.minY + 0.55147 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.38280 * frame.width, frame.minY + 0.83178 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28579 * frame.width, frame.minY + 0.70584 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.50176 * frame.width, frame.minY + 0.27112 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.28579 * frame.width, frame.minY + 0.39676 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38280 * frame.width, frame.minY + 0.27112 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.71776 * frame.width, frame.minY + 0.55147 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.62099 * frame.width, frame.minY + 0.27112 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.71776 * frame.width, frame.minY + 0.39676 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.50176 * frame.width, frame.minY + 0.83178 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.71776 * frame.width, frame.minY + 0.70584 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62099 * frame.width, frame.minY + 0.83178 * frame.height))
		bezier47Path.closePath()
		bezier47Path.moveToPoint(CGPointMake(frame.minX + 0.90943 * frame.width, frame.minY + 0.17032 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.75166 * frame.width, frame.minY + 0.17032 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.65722 * frame.width, frame.minY + 0.04683 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.65652 * frame.width, frame.minY + 0.04620 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65722 * frame.width, frame.minY + 0.04683 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65675 * frame.width, frame.minY + 0.04620 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.65605 * frame.width, frame.minY + 0.04558 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.60160 * frame.width, frame.minY + 0.01594 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64202 * frame.width, frame.minY + 0.02745 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62309 * frame.width, frame.minY + 0.01594 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.40523 * frame.width, frame.minY + 0.01594 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.34774 * frame.width, frame.minY + 0.04893 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.38233 * frame.width, frame.minY + 0.01594 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36199 * frame.width, frame.minY + 0.02865 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.34774 * frame.width, frame.minY + 0.04922 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.25542 * frame.width, frame.minY + 0.17032 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.09410 * frame.width, frame.minY + 0.17032 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.01557 * frame.width, frame.minY + 0.27081 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05064 * frame.width, frame.minY + 0.17032 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01557 * frame.width, frame.minY + 0.21452 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.01557 * frame.width, frame.minY + 0.88261 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.09410 * frame.width, frame.minY + 0.98465 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01557 * frame.width, frame.minY + 0.93894 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05064 * frame.width, frame.minY + 0.98465 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.90943 * frame.width, frame.minY + 0.98465 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.98796 * frame.width, frame.minY + 0.88261 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95267 * frame.width, frame.minY + 0.98465 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98796 * frame.width, frame.minY + 0.93894 * frame.height))
		bezier47Path.addLineToPoint(CGPointMake(frame.minX + 0.98796 * frame.width, frame.minY + 0.27081 * frame.height))
		bezier47Path.addCurveToPoint(CGPointMake(frame.minX + 0.90943 * frame.width, frame.minY + 0.17032 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98796 * frame.width, frame.minY + 0.21452 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95267 * frame.width, frame.minY + 0.17032 * frame.height))
		bezier47Path.closePath()
		bezier47Path.lineCapStyle = .Round;
		bezier47Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier47Path.miterLimit = 4
		bezier47Path.stroke()
		
		//// Oval 5 Drawing
		let oval5Path = UIBezierPath(ovalInRect: CGRectMake(frame.minX + floor(frame.width * 0.33797 - 0.2) + 0.7, frame.minY + floor(frame.height * 0.34016 + 0.05) + 0.45, floor(frame.width * 0.66582 - 0.1) - floor(frame.width * 0.33797 - 0.2) - 0.1, floor(frame.height * 0.76311 + 0.25) - floor(frame.height * 0.34016 + 0.05) - 0.2))
		fillColor.setStroke()
		oval5Path.miterLimit = 4
		oval5Path.stroke()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//size 1x1
	public class func flagIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 26.57, frame.minY + 17.46))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 20.93, frame.minY + 16.78), controlPoint1: CGPointMake(frame.minX + 24.46, frame.minY + 17.94), controlPoint2: CGPointMake(frame.minX + 22.82, frame.minY + 17.4))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 13.61, frame.minY + 16.01), controlPoint1: CGPointMake(frame.minX + 18.88, frame.minY + 16.11), controlPoint2: CGPointMake(frame.minX + 16.56, frame.minY + 15.35))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 7.13, frame.minY + 19.84), controlPoint1: CGPointMake(frame.minX + 10.76, frame.minY + 16.65), controlPoint2: CGPointMake(frame.minX + 8.6, frame.minY + 18.31))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 6.95, frame.minY + 19.08))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 4.48, frame.minY + 8.32))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 10.51, frame.minY + 4.08), controlPoint1: CGPointMake(frame.minX + 5.18, frame.minY + 7.25), controlPoint2: CGPointMake(frame.minX + 7.17, frame.minY + 4.7))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 17.69, frame.minY + 6.98), controlPoint1: CGPointMake(frame.minX + 13.03, frame.minY + 3.6), controlPoint2: CGPointMake(frame.minX + 15.19, frame.minY + 5.17))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 26.23, frame.minY + 10.58), controlPoint1: CGPointMake(frame.minX + 20.11, frame.minY + 8.73), controlPoint2: CGPointMake(frame.minX + 22.86, frame.minY + 10.71))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 34.22, frame.minY + 7.04), controlPoint1: CGPointMake(frame.minX + 29.06, frame.minY + 10.46), controlPoint2: CGPointMake(frame.minX + 31.98, frame.minY + 8.85))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 26.57, frame.minY + 17.46), controlPoint1: CGPointMake(frame.minX + 33.21, frame.minY + 12), controlPoint2: CGPointMake(frame.minX + 30.72, frame.minY + 16.53))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 36.76, frame.minY + 0.53))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 34.87, frame.minY + 1.51), controlPoint1: CGPointMake(frame.minX + 35.97, frame.minY + 0.37), controlPoint2: CGPointMake(frame.minX + 35.18, frame.minY + 0.79))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 26.08, frame.minY + 7.28), controlPoint1: CGPointMake(frame.minX + 34.41, frame.minY + 2.58), controlPoint2: CGPointMake(frame.minX + 29.95, frame.minY + 7.12))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 19.69, frame.minY + 4.32), controlPoint1: CGPointMake(frame.minX + 23.91, frame.minY + 7.37), controlPoint2: CGPointMake(frame.minX + 21.86, frame.minY + 5.89))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 9.88, frame.minY + 0.83), controlPoint1: CGPointMake(frame.minX + 16.95, frame.minY + 2.33), controlPoint2: CGPointMake(frame.minX + 13.85, frame.minY + 0.08))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 1.18, frame.minY + 7.3), controlPoint1: CGPointMake(frame.minX + 4.04, frame.minY + 1.92), controlPoint2: CGPointMake(frame.minX + 1.3, frame.minY + 7.08))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 1.04, frame.minY + 8.41), controlPoint1: CGPointMake(frame.minX + 1.01, frame.minY + 7.64), controlPoint2: CGPointMake(frame.minX + 0.95, frame.minY + 8.04))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 2.74, frame.minY + 15.79))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 2.74, frame.minY + 15.79))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 7.66, frame.minY + 37.22))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 9.31, frame.minY + 38.51), controlPoint1: CGPointMake(frame.minX + 7.84, frame.minY + 37.99), controlPoint2: CGPointMake(frame.minX + 8.54, frame.minY + 38.51))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 9.68, frame.minY + 38.47), controlPoint1: CGPointMake(frame.minX + 9.43, frame.minY + 38.51), controlPoint2: CGPointMake(frame.minX + 9.56, frame.minY + 38.5))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 10.96, frame.minY + 36.5), controlPoint1: CGPointMake(frame.minX + 10.59, frame.minY + 38.27), controlPoint2: CGPointMake(frame.minX + 11.16, frame.minY + 37.39))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 8.08, frame.minY + 23.98))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 14.37, frame.minY + 19.24), controlPoint1: CGPointMake(frame.minX + 8.83, frame.minY + 22.83), controlPoint2: CGPointMake(frame.minX + 10.98, frame.minY + 19.99))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 19.86, frame.minY + 19.92), controlPoint1: CGPointMake(frame.minX + 16.39, frame.minY + 18.78), controlPoint2: CGPointMake(frame.minX + 18, frame.minY + 19.31))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 27.33, frame.minY + 20.69), controlPoint1: CGPointMake(frame.minX + 21.94, frame.minY + 20.6), controlPoint2: CGPointMake(frame.minX + 24.29, frame.minY + 21.37))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 38.11, frame.minY + 2.17), controlPoint1: CGPointMake(frame.minX + 33.67, frame.minY + 19.27), controlPoint2: CGPointMake(frame.minX + 38, frame.minY + 11.82))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 36.76, frame.minY + 0.53), controlPoint1: CGPointMake(frame.minX + 38.12, frame.minY + 1.38), controlPoint2: CGPointMake(frame.minX + 37.55, frame.minY + 0.69))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//size 1x1
	public class func trashIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.59179 * frame.width, frame.minY + 0.83758 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.63049 * frame.width, frame.minY + 0.79997 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.61275 * frame.width, frame.minY + 0.83758 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62999 * frame.width, frame.minY + 0.82037 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.64174 * frame.width, frame.minY + 0.33750 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60394 * frame.width, frame.minY + 0.29888 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64224 * frame.width, frame.minY + 0.31679 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62532 * frame.width, frame.minY + 0.29937 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.56432 * frame.width, frame.minY + 0.33534 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58222 * frame.width, frame.minY + 0.29857 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56481 * frame.width, frame.minY + 0.31465 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.55306 * frame.width, frame.minY + 0.79827 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.59086 * frame.width, frame.minY + 0.83758 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55255 * frame.width, frame.minY + 0.81896 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56947 * frame.width, frame.minY + 0.83758 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.59179 * frame.width, frame.minY + 0.83758 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.40931 * frame.width, frame.minY + 0.83758 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.41024 * frame.width, frame.minY + 0.83758 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.44804 * frame.width, frame.minY + 0.79696 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.43162 * frame.width, frame.minY + 0.83758 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44854 * frame.width, frame.minY + 0.81767 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.43679 * frame.width, frame.minY + 0.33388 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39716 * frame.width, frame.minY + 0.29672 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.43628 * frame.width, frame.minY + 0.31317 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.41875 * frame.width, frame.minY + 0.29626 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.35937 * frame.width, frame.minY + 0.33480 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.37578 * frame.width, frame.minY + 0.29720 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35886 * frame.width, frame.minY + 0.31409 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.37062 * frame.width, frame.minY + 0.79887 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.40931 * frame.width, frame.minY + 0.83758 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.37112 * frame.width, frame.minY + 0.81926 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38834 * frame.width, frame.minY + 0.83758 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.40931 * frame.width, frame.minY + 0.83758 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.39075 * frame.width, frame.minY + 0.14135 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.61203 * frame.width, frame.minY + 0.14135 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.61203 * frame.width, frame.minY + 0.08780 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.39075 * frame.width, frame.minY + 0.08780 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.39075 * frame.width, frame.minY + 0.14135 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.18420 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.93289 * frame.width, frame.minY + 0.22704 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.20786 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95733 * frame.width, frame.minY + 0.22704 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.06990 * frame.width, frame.minY + 0.22704 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.02564 * frame.width, frame.minY + 0.18420 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04546 * frame.width, frame.minY + 0.22704 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02564 * frame.width, frame.minY + 0.20786 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.06990 * frame.width, frame.minY + 0.14135 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02564 * frame.width, frame.minY + 0.16054 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.04546 * frame.width, frame.minY + 0.14135 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.31331 * frame.width, frame.minY + 0.14135 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.31331 * frame.width, frame.minY + 0.04495 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.34895 * frame.width, frame.minY + 0.01282 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31331 * frame.width, frame.minY + 0.02425 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32757 * frame.width, frame.minY + 0.01282 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.65382 * frame.width, frame.minY + 0.01282 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.68948 * frame.width, frame.minY + 0.04495 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.67521 * frame.width, frame.minY + 0.01282 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68948 * frame.width, frame.minY + 0.02425 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.68948 * frame.width, frame.minY + 0.14135 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.93289 * frame.width, frame.minY + 0.14135 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.18420 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95733 * frame.width, frame.minY + 0.14135 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.16054 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.97715 * frame.width, frame.minY + 0.18420 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.85984 * frame.width, frame.minY + 0.32760 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.82606 * frame.width, frame.minY + 0.94695 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.78187 * frame.width, frame.minY + 0.98753 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.82482 * frame.width, frame.minY + 0.96970 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.80540 * frame.width, frame.minY + 0.98753 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.22092 * frame.width, frame.minY + 0.98753 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.17673 * frame.width, frame.minY + 0.94695 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.19739 * frame.width, frame.minY + 0.98753 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.17797 * frame.width, frame.minY + 0.96970 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.14296 * frame.width, frame.minY + 0.32760 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.18482 * frame.width, frame.minY + 0.28256 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.14167 * frame.width, frame.minY + 0.30397 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16041 * frame.width, frame.minY + 0.28380 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.23135 * frame.width, frame.minY + 0.32308 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.20935 * frame.width, frame.minY + 0.28141 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.23007 * frame.width, frame.minY + 0.29946 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.26291 * frame.width, frame.minY + 0.90185 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.73988 * frame.width, frame.minY + 0.90185 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.77143 * frame.width, frame.minY + 0.32308 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.81797 * frame.width, frame.minY + 0.28256 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77273 * frame.width, frame.minY + 0.29945 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.79371 * frame.width, frame.minY + 0.28149 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.85984 * frame.width, frame.minY + 0.32760 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84238 * frame.width, frame.minY + 0.28380 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86112 * frame.width, frame.minY + 0.30397 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.85984 * frame.width, frame.minY + 0.32760 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
}
