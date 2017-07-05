//
//  PaintCodeIcon5.swift
//  Buddify
//
//  Created by Huy Le on 3/30/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {
	
	//1x1
	public class func downloadIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.99810 * frame.width, frame.minY + 0.40771 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74503 * frame.width, frame.minY + 0.14673 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.99810 * frame.width, frame.minY + 0.26358 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.88480 * frame.width, frame.minY + 0.14673 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72438 * frame.width, frame.minY + 0.14759 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73808 * frame.width, frame.minY + 0.14673 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73119 * frame.width, frame.minY + 0.14702 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.46707 * frame.width, frame.minY + 0.01250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66653 * frame.width, frame.minY + 0.06571 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57283 * frame.width, frame.minY + 0.01250 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.16112 * frame.width, frame.minY + 0.25029 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.32173 * frame.width, frame.minY + 0.01250 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.19915 * frame.width, frame.minY + 0.11300 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.00250 * frame.width, frame.minY + 0.45671 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.07021 * frame.width, frame.minY + 0.27218 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00250 * frame.width, frame.minY + 0.35629 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.19964 * frame.width, frame.minY + 0.66852 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00250 * frame.width, frame.minY + 0.57088 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09002 * frame.width, frame.minY + 0.66396 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.22877 * frame.width, frame.minY + 0.66822 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.22877 * frame.width, frame.minY + 0.57818 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19964 * frame.width, frame.minY + 0.57818 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.09301 * frame.width, frame.minY + 0.45671 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.13873 * frame.width, frame.minY + 0.57565 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09301 * frame.width, frame.minY + 0.52256 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.18231 * frame.width, frame.minY + 0.33828 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.09301 * frame.width, frame.minY + 0.39932 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.13092 * frame.width, frame.minY + 0.35066 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.23412 * frame.width, frame.minY + 0.32580 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.24834 * frame.width, frame.minY + 0.27445 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.46707 * frame.width, frame.minY + 0.10301 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.27635 * frame.width, frame.minY + 0.17335 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36546 * frame.width, frame.minY + 0.10301 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.65046 * frame.width, frame.minY + 0.19982 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54018 * frame.width, frame.minY + 0.10301 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.60762 * frame.width, frame.minY + 0.13919 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.68032 * frame.width, frame.minY + 0.24208 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.73189 * frame.width, frame.minY + 0.23778 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74503 * frame.width, frame.minY + 0.23724 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73624 * frame.width, frame.minY + 0.23742 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.74062 * frame.width, frame.minY + 0.23724 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.90759 * frame.width, frame.minY + 0.40771 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.83418 * frame.width, frame.minY + 0.23724 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.90759 * frame.width, frame.minY + 0.31295 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.77183 * frame.width, frame.minY + 0.57589 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.90759 * frame.width, frame.minY + 0.49231 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84875 * frame.width, frame.minY + 0.56253 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.74920 * frame.width, frame.minY + 0.57818 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.74920 * frame.width, frame.minY + 0.66822 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.77183 * frame.width, frame.minY + 0.66822 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.99810 * frame.width, frame.minY + 0.40771 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89900 * frame.width, frame.minY + 0.65344 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.99810 * frame.width, frame.minY + 0.54251 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.48744 * frame.width, frame.minY + 0.98547 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.52562 * frame.width, frame.minY + 0.96913 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.50744 * frame.width, frame.minY + 0.98547 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.52562 * frame.width, frame.minY + 0.96913 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.71319 * frame.width, frame.minY + 0.78349 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.71310 * frame.width, frame.minY + 0.71892 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73101 * frame.width, frame.minY + 0.76568 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73109 * frame.width, frame.minY + 0.73690 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.64848 * frame.width, frame.minY + 0.71883 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69523 * frame.width, frame.minY + 0.70107 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66627 * frame.width, frame.minY + 0.70105 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53319 * frame.width, frame.minY + 0.83402 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53319 * frame.width, frame.minY + 0.44269 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.48744 * frame.width, frame.minY + 0.39716 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.53319 * frame.width, frame.minY + 0.41755 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.51288 * frame.width, frame.minY + 0.39716 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.44168 * frame.width, frame.minY + 0.44269 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.46217 * frame.width, frame.minY + 0.39716 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44168 * frame.width, frame.minY + 0.41769 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.44168 * frame.width, frame.minY + 0.83093 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32949 * frame.width, frame.minY + 0.71883 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.26488 * frame.width, frame.minY + 0.71892 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31170 * frame.width, frame.minY + 0.70105 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28275 * frame.width, frame.minY + 0.70107 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.26478 * frame.width, frame.minY + 0.78349 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.24688 * frame.width, frame.minY + 0.73690 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.24696 * frame.width, frame.minY + 0.76568 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.44620 * frame.width, frame.minY + 0.96676 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.48744 * frame.width, frame.minY + 0.98547 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.44620 * frame.width, frame.minY + 0.96676 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.46743 * frame.width, frame.minY + 0.98547 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()

		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//51x29
	public class func tickIconDouble(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier 60 Drawing
		let bezier60Path = UIBezierPath()
		bezier60Path.moveToPoint(CGPointMake(frame.minX + 0.75241 * frame.width, frame.minY + 0.06316 * frame.height))
		bezier60Path.addLineToPoint(CGPointMake(frame.minX + 0.33263 * frame.width, frame.minY + 0.91150 * frame.height))
		bezier60Path.addLineToPoint(CGPointMake(frame.minX + 0.04571 * frame.width, frame.minY + 0.44184 * frame.height))
		bezier60Path.lineCapStyle = .Round;
		bezier60Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier60Path.miterLimit = 4
		bezier60Path.stroke()
		
		//// Bezier 61 Drawing
		let bezier61Path = UIBezierPath()
		bezier61Path.moveToPoint(CGPointMake(frame.minX + 0.95295 * frame.width, frame.minY + 0.06316 * frame.height))
		bezier61Path.addLineToPoint(CGPointMake(frame.minX + 0.53317 * frame.width, frame.minY + 0.91150 * frame.height))
		bezier61Path.lineCapStyle = .Round;
		bezier61Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier61Path.miterLimit = 4
		bezier61Path.stroke()
		
		//// Bezier 62 Drawing
		let bezier62Path = UIBezierPath()
		bezier62Path.moveToPoint(CGPointMake(frame.minX + 0.34189 * frame.width, frame.minY + 0.59840 * frame.height))
		bezier62Path.addLineToPoint(CGPointMake(frame.minX + 0.24626 * frame.width, frame.minY + 0.44184 * frame.height))
		bezier62Path.lineCapStyle = .Round;
		bezier62Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier62Path.miterLimit = 4
		bezier62Path.stroke()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//1x1
	public class func cancelButtonRoundedFilledColorIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.67964 * frame.width, frame.minY + 0.35870 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.67964 * frame.width, frame.minY + 0.32433 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68916 * frame.width, frame.minY + 0.34919 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68916 * frame.width, frame.minY + 0.33386 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.64502 * frame.width, frame.minY + 0.32433 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66991 * frame.width, frame.minY + 0.31481 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65453 * frame.width, frame.minY + 0.31481 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.50145 * frame.width, frame.minY + 0.46792 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.35786 * frame.width, frame.minY + 0.32433 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.32324 * frame.width, frame.minY + 0.32433 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34811 * frame.width, frame.minY + 0.31481 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33277 * frame.width, frame.minY + 0.31481 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.32324 * frame.width, frame.minY + 0.35870 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31375 * frame.width, frame.minY + 0.33386 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.31375 * frame.width, frame.minY + 0.34919 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.46708 * frame.width, frame.minY + 0.50255 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32324 * frame.width, frame.minY + 0.64611 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.32324 * frame.width, frame.minY + 0.68047 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31375 * frame.width, frame.minY + 0.65561 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.31375 * frame.width, frame.minY + 0.67098 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.34055 * frame.width, frame.minY + 0.68756 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.32813 * frame.width, frame.minY + 0.68538 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33422 * frame.width, frame.minY + 0.68756 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.35786 * frame.width, frame.minY + 0.68047 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34691 * frame.width, frame.minY + 0.68756 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35300 * frame.width, frame.minY + 0.68538 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.50145 * frame.width, frame.minY + 0.53692 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.64502 * frame.width, frame.minY + 0.68047 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66235 * frame.width, frame.minY + 0.68756 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64991 * frame.width, frame.minY + 0.68538 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65600 * frame.width, frame.minY + 0.68756 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.67964 * frame.width, frame.minY + 0.68047 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66867 * frame.width, frame.minY + 0.68756 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.67477 * frame.width, frame.minY + 0.68538 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.67964 * frame.width, frame.minY + 0.64611 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68916 * frame.width, frame.minY + 0.67098 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68916 * frame.width, frame.minY + 0.65561 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53608 * frame.width, frame.minY + 0.50255 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.67964 * frame.width, frame.minY + 0.35870 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50145 * frame.width, frame.minY + 0.00817 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.99556 * frame.width, frame.minY + 0.50230 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77399 * frame.width, frame.minY + 0.00817 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.99556 * frame.width, frame.minY + 0.22975 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50145 * frame.width, frame.minY + 0.99641 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.99556 * frame.width, frame.minY + 0.77483 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77399 * frame.width, frame.minY + 0.99641 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.00733 * frame.width, frame.minY + 0.50230 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22889 * frame.width, frame.minY + 0.99641 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00733 * frame.width, frame.minY + 0.77483 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50145 * frame.width, frame.minY + 0.00817 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00733 * frame.width, frame.minY + 0.22975 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22889 * frame.width, frame.minY + 0.00817 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()

		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//Size 1x1
	public class func paperClipIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.31466 * frame.width, frame.minY + 0.46301 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.10840 * frame.width, frame.minY + 0.66927 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.10838 * frame.width, frame.minY + 0.93876 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.03397 * frame.width, frame.minY + 0.74369 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.03412 * frame.width, frame.minY + 0.86450 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.37787 * frame.width, frame.minY + 0.93874 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.18279 * frame.width, frame.minY + 1.01317 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.30349 * frame.width, frame.minY + 1.01312 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.58417 * frame.width, frame.minY + 0.73245 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.88305 * frame.width, frame.minY + 0.43356 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88311 * frame.width, frame.minY + 0.07982 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98071 * frame.width, frame.minY + 0.33590 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98078 * frame.width, frame.minY + 0.17749 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.52937 * frame.width, frame.minY + 0.07988 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.78542 * frame.width, frame.minY + -0.01787 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62707 * frame.width, frame.minY + -0.01782 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.08312 * frame.width, frame.minY + 0.52613 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.10838 * frame.width, frame.minY + 0.55140 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.13364 * frame.width, frame.minY + 0.57666 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.57989 * frame.width, frame.minY + 0.13041 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.83259 * frame.width, frame.minY + 0.13034 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64970 * frame.width, frame.minY + 0.06060 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76281 * frame.width, frame.minY + 0.06057 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.83252 * frame.width, frame.minY + 0.38304 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.90233 * frame.width, frame.minY + 0.20009 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.90230 * frame.width, frame.minY + 0.31326 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.60732 * frame.width, frame.minY + 0.60824 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.60732 * frame.width, frame.minY + 0.60824 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32734 * frame.width, frame.minY + 0.88822 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.15890 * frame.width, frame.minY + 0.88824 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.28085 * frame.width, frame.minY + 0.93471 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.20539 * frame.width, frame.minY + 0.93472 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.15892 * frame.width, frame.minY + 0.71980 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.11249 * frame.width, frame.minY + 0.84182 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.11246 * frame.width, frame.minY + 0.76626 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.36519 * frame.width, frame.minY + 0.51353 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.65869 * frame.width, frame.minY + 0.22003 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74290 * frame.width, frame.minY + 0.22003 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68190 * frame.width, frame.minY + 0.19682 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.71971 * frame.width, frame.minY + 0.19683 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74290 * frame.width, frame.minY + 0.30424 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.76618 * frame.width, frame.minY + 0.24330 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76618 * frame.width, frame.minY + 0.28096 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.30200 * frame.width, frame.minY + 0.74514 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32726 * frame.width, frame.minY + 0.77041 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32726 * frame.width, frame.minY + 0.77041 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.35252 * frame.width, frame.minY + 0.79567 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.79343 * frame.width, frame.minY + 0.35476 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.79343 * frame.width, frame.minY + 0.16950 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84464 * frame.width, frame.minY + 0.30356 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84459 * frame.width, frame.minY + 0.22066 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60817 * frame.width, frame.minY + 0.16950 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.74237 * frame.width, frame.minY + 0.11845 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65932 * frame.width, frame.minY + 0.11834 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.31466 * frame.width, frame.minY + 0.46301 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.31466 * frame.width, frame.minY + 0.46301 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()

		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	public class func profileIconAdd(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier 37 Drawing
		let bezier37Path = UIBezierPath()
		bezier37Path.moveToPoint(CGPointMake(frame.minX + 0.80893 * frame.width, frame.minY + 0.37866 * frame.height))
		bezier37Path.addLineToPoint(CGPointMake(frame.minX + 0.80893 * frame.width, frame.minY + 0.79493 * frame.height))
		bezier37Path.addCurveToPoint(CGPointMake(frame.minX + 0.72107 * frame.width, frame.minY + 0.87024 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.80893 * frame.width, frame.minY + 0.83655 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76962 * frame.width, frame.minY + 0.87024 * frame.height))
		bezier37Path.addLineToPoint(CGPointMake(frame.minX + 0.55740 * frame.width, frame.minY + 0.87024 * frame.height))
		bezier37Path.addLineToPoint(CGPointMake(frame.minX + 0.44121 * frame.width, frame.minY + 0.97024 * frame.height))
		bezier37Path.addCurveToPoint(CGPointMake(frame.minX + 0.39508 * frame.width, frame.minY + 0.97024 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42980 * frame.width, frame.minY + 0.98116 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.40627 * frame.width, frame.minY + 0.98211 * frame.height))
		bezier37Path.addLineToPoint(CGPointMake(frame.minX + 0.27863 * frame.width, frame.minY + 0.87024 * frame.height))
		bezier37Path.addLineToPoint(CGPointMake(frame.minX + 0.11501 * frame.width, frame.minY + 0.87024 * frame.height))
		bezier37Path.addCurveToPoint(CGPointMake(frame.minX + 0.02710 * frame.width, frame.minY + 0.79493 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.06645 * frame.width, frame.minY + 0.87024 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02710 * frame.width, frame.minY + 0.83655 * frame.height))
		bezier37Path.addLineToPoint(CGPointMake(frame.minX + 0.02710 * frame.width, frame.minY + 0.27545 * frame.height))
		bezier37Path.addCurveToPoint(CGPointMake(frame.minX + 0.11501 * frame.width, frame.minY + 0.20010 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02710 * frame.width, frame.minY + 0.23383 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.06645 * frame.width, frame.minY + 0.20010 * frame.height))
		bezier37Path.addLineToPoint(CGPointMake(frame.minX + 0.21413 * frame.width, frame.minY + 0.20010 * frame.height))
		bezier37Path.lineCapStyle = .Round;
		
		bezier37Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier37Path.miterLimit = 4
		bezier37Path.stroke()
		
		
		//// Bezier 38 Drawing
		let bezier38Path = UIBezierPath()
		bezier38Path.moveToPoint(CGPointMake(frame.minX + 0.17047 * frame.width, frame.minY + 0.74234 * frame.height))
		bezier38Path.addLineToPoint(CGPointMake(frame.minX + 0.66614 * frame.width, frame.minY + 0.74234 * frame.height))
		bezier38Path.lineCapStyle = .Round;
		
		bezier38Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier38Path.miterLimit = 4
		bezier38Path.stroke()
		
		
		//// Bezier 39 Drawing
		let bezier39Path = UIBezierPath()
		bezier39Path.moveToPoint(CGPointMake(frame.minX + 0.50846 * frame.width, frame.minY + 0.59691 * frame.height))
		bezier39Path.addCurveToPoint(CGPointMake(frame.minX + 0.56484 * frame.width, frame.minY + 0.61452 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.52578 * frame.width, frame.minY + 0.60834 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.54440 * frame.width, frame.minY + 0.61060 * frame.height))
		bezier39Path.addCurveToPoint(CGPointMake(frame.minX + 0.64636 * frame.width, frame.minY + 0.63901 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.59302 * frame.width, frame.minY + 0.61993 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62301 * frame.width, frame.minY + 0.62306 * frame.height))
		bezier39Path.addCurveToPoint(CGPointMake(frame.minX + 0.66613 * frame.width, frame.minY + 0.74234 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.67486 * frame.width, frame.minY + 0.65852 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66660 * frame.width, frame.minY + 0.71405 * frame.height))
		bezier39Path.lineCapStyle = .Round;
		
		bezier39Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier39Path.miterLimit = 4
		bezier39Path.stroke()
		
		
		//// Bezier 40 Drawing
		let bezier40Path = UIBezierPath()
		bezier40Path.moveToPoint(CGPointMake(frame.minX + 0.32775 * frame.width, frame.minY + 0.59691 * frame.height))
		bezier40Path.addCurveToPoint(CGPointMake(frame.minX + 0.27139 * frame.width, frame.minY + 0.61452 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31044 * frame.width, frame.minY + 0.60834 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.29185 * frame.width, frame.minY + 0.61060 * frame.height))
		bezier40Path.addCurveToPoint(CGPointMake(frame.minX + 0.18989 * frame.width, frame.minY + 0.63901 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.24321 * frame.width, frame.minY + 0.61993 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.21321 * frame.width, frame.minY + 0.62306 * frame.height))
		bezier40Path.addCurveToPoint(CGPointMake(frame.minX + 0.17010 * frame.width, frame.minY + 0.74234 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16138 * frame.width, frame.minY + 0.65852 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16959 * frame.width, frame.minY + 0.71405 * frame.height))
		bezier40Path.lineCapStyle = .Round;
		
		bezier40Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier40Path.miterLimit = 4
		bezier40Path.stroke()
		
		
		//// Bezier 41 Drawing
		let bezier41Path = UIBezierPath()
		bezier41Path.moveToPoint(CGPointMake(frame.minX + 0.50846 * frame.width, frame.minY + 0.59691 * frame.height))
		bezier41Path.addCurveToPoint(CGPointMake(frame.minX + 0.41830 * frame.width, frame.minY + 0.68045 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.50846 * frame.width, frame.minY + 0.65278 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.48352 * frame.width, frame.minY + 0.68045 * frame.height))
		bezier41Path.addCurveToPoint(CGPointMake(frame.minX + 0.32775 * frame.width, frame.minY + 0.59691 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.35310 * frame.width, frame.minY + 0.68045 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32775 * frame.width, frame.minY + 0.65278 * frame.height))
		bezier41Path.lineCapStyle = .Round;
		
		bezier41Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier41Path.miterLimit = 4
		bezier41Path.stroke()
		
		
		//// Oval 3 Drawing
		let oval3Path = UIBezierPath(ovalInRect: CGRectMake(frame.minX + floor(frame.width * 0.30682 + 0.25) + 0.25, frame.minY + floor(frame.height * 0.33182 - 0.15) + 0.65, floor(frame.width * 0.52955 - 0.45) - floor(frame.width * 0.30682 + 0.25) + 0.7, floor(frame.height * 0.56299 + 0.05) - floor(frame.height * 0.33182 - 0.15) - 0.2))
		fillColor.setStroke()
		oval3Path.miterLimit = 4
		oval3Path.stroke()
		
		
		//// Bezier 42 Drawing
		let bezier42Path = UIBezierPath()
		bezier42Path.moveToPoint(CGPointMake(frame.minX + 0.33472 * frame.width, frame.minY + 0.20011 * frame.height))
		bezier42Path.addLineToPoint(CGPointMake(frame.minX + 0.41433 * frame.width, frame.minY + 0.20011 * frame.height))
		bezier42Path.lineCapStyle = .Round;
		
		bezier42Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier42Path.miterLimit = 4
		bezier42Path.stroke()
		
		
		//// Bezier 43 Drawing
		let bezier43Path = UIBezierPath()
		bezier43Path.moveToPoint(CGPointMake(frame.minX + 0.76492 * frame.width, frame.minY + 0.27335 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.75148 * frame.width, frame.minY + 0.26856 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75981 * frame.width, frame.minY + 0.27335 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.75505 * frame.width, frame.minY + 0.27165 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.74598 * frame.width, frame.minY + 0.25709 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.74790 * frame.width, frame.minY + 0.26548 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.74596 * frame.width, frame.minY + 0.26141 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.74602 * frame.width, frame.minY + 0.21637 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.69840 * frame.width, frame.minY + 0.21637 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.67948 * frame.width, frame.minY + 0.20015 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.68798 * frame.width, frame.minY + 0.21637 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.67948 * frame.width, frame.minY + 0.20909 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.69829 * frame.width, frame.minY + 0.18387 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.67948 * frame.width, frame.minY + 0.19128 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68790 * frame.width, frame.minY + 0.18400 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.74596 * frame.width, frame.minY + 0.18387 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.74598 * frame.width, frame.minY + 0.14312 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.76479 * frame.width, frame.minY + 0.12686 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.74598 * frame.width, frame.minY + 0.13429 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.75442 * frame.width, frame.minY + 0.12700 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.78385 * frame.width, frame.minY + 0.14308 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77538 * frame.width, frame.minY + 0.12686 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.78385 * frame.width, frame.minY + 0.13415 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.78392 * frame.width, frame.minY + 0.18387 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.83145 * frame.width, frame.minY + 0.18387 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.85037 * frame.width, frame.minY + 0.20011 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84187 * frame.width, frame.minY + 0.18387 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.85037 * frame.width, frame.minY + 0.19116 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.84484 * frame.width, frame.minY + 0.21155 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.85037 * frame.width, frame.minY + 0.20438 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84842 * frame.width, frame.minY + 0.20846 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.83140 * frame.width, frame.minY + 0.21637 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84111 * frame.width, frame.minY + 0.21467 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83638 * frame.width, frame.minY + 0.21637 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.78385 * frame.width, frame.minY + 0.21637 * frame.height))
		bezier43Path.addLineToPoint(CGPointMake(frame.minX + 0.78385 * frame.width, frame.minY + 0.25709 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.77837 * frame.width, frame.minY + 0.26852 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.78385 * frame.width, frame.minY + 0.26137 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.78192 * frame.width, frame.minY + 0.26545 * frame.height))
		bezier43Path.addCurveToPoint(CGPointMake(frame.minX + 0.76492 * frame.width, frame.minY + 0.27335 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77466 * frame.width, frame.minY + 0.27165 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76992 * frame.width, frame.minY + 0.27335 * frame.height))
		bezier43Path.closePath()
		bezier43Path.lineCapStyle = .Round;
		
		bezier43Path.lineJoinStyle = .Round;
		
		fillColor.setFill()
		bezier43Path.fill()
		
		
		//// Bezier 44 Drawing
		let bezier44Path = UIBezierPath()
		bezier44Path.moveToPoint(CGPointMake(frame.minX + 0.97766 * frame.width, frame.minY + 0.20018 * frame.height))
		bezier44Path.addCurveToPoint(CGPointMake(frame.minX + 0.80888 * frame.width, frame.minY + 0.37866 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97766 * frame.width, frame.minY + 0.28792 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.90534 * frame.width, frame.minY + 0.36125 * frame.height))
		bezier44Path.addCurveToPoint(CGPointMake(frame.minX + 0.76492 * frame.width, frame.minY + 0.38255 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.79469 * frame.width, frame.minY + 0.38112 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.78005 * frame.width, frame.minY + 0.38255 * frame.height))
		bezier44Path.addCurveToPoint(CGPointMake(frame.minX + 0.55216 * frame.width, frame.minY + 0.20018 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64743 * frame.width, frame.minY + 0.38255 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.55216 * frame.width, frame.minY + 0.30086 * frame.height))
		bezier44Path.addCurveToPoint(CGPointMake(frame.minX + 0.76492 * frame.width, frame.minY + 0.01782 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55216 * frame.width, frame.minY + 0.09947 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.64743 * frame.width, frame.minY + 0.01782 * frame.height))
		bezier44Path.addCurveToPoint(CGPointMake(frame.minX + 0.97766 * frame.width, frame.minY + 0.20018 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.88238 * frame.width, frame.minY + 0.01782 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97766 * frame.width, frame.minY + 0.09947 * frame.height))
		bezier44Path.closePath()
		bezier44Path.lineCapStyle = .Round;
		
		bezier44Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier44Path.miterLimit = 4
		bezier44Path.stroke()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	
	
	
	
	
}