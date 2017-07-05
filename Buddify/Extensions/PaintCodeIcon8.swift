//
//  PaintCodeIcon8.swift
//  Buddify
//
//  Created by Huy Le on 4/19/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {

	//Size 1x1
	public class func addUserIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.78101 * frame.width, frame.minY + 0.73629 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.78101 * frame.width, frame.minY + 0.68392 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.65228 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.78101 * frame.width, frame.minY + 0.66638 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76687 * frame.width, frame.minY + 0.65228 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.71786 * frame.width, frame.minY + 0.68392 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73188 * frame.width, frame.minY + 0.65228 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.71786 * frame.width, frame.minY + 0.66644 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.71786 * frame.width, frame.minY + 0.73629 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.66833 * frame.width, frame.minY + 0.73629 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.63367 * frame.width, frame.minY + 0.76780 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64922 * frame.width, frame.minY + 0.73629 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.63367 * frame.width, frame.minY + 0.75040 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66833 * frame.width, frame.minY + 0.79930 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.63367 * frame.width, frame.minY + 0.78532 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.64919 * frame.width, frame.minY + 0.79930 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.71786 * frame.width, frame.minY + 0.79930 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.71786 * frame.width, frame.minY + 0.85168 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.88332 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.71786 * frame.width, frame.minY + 0.86921 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73200 * frame.width, frame.minY + 0.88332 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.78101 * frame.width, frame.minY + 0.85168 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.76699 * frame.width, frame.minY + 0.88332 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.78101 * frame.width, frame.minY + 0.86915 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.78101 * frame.width, frame.minY + 0.79930 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.83054 * frame.width, frame.minY + 0.79930 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.86520 * frame.width, frame.minY + 0.76780 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84965 * frame.width, frame.minY + 0.79930 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86520 * frame.width, frame.minY + 0.78520 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.83054 * frame.width, frame.minY + 0.73629 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.86520 * frame.width, frame.minY + 0.75028 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84968 * frame.width, frame.minY + 0.73629 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.78101 * frame.width, frame.minY + 0.73629 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.48145 * frame.width, frame.minY + 0.86231 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.43251 * frame.width, frame.minY + 0.86231 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.06670 * frame.width, frame.minY + 0.86231 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.05839 * frame.width, frame.minY + 0.86231 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.02395 * frame.width, frame.minY + 0.82110 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.03510 * frame.width, frame.minY + 0.86231 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01975 * frame.width, frame.minY + 0.84386 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.02545 * frame.width, frame.minY + 0.81295 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.03521 * frame.width, frame.minY + 0.77474 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02696 * frame.width, frame.minY + 0.80475 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.03009 * frame.width, frame.minY + 0.79148 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.06926 * frame.width, frame.minY + 0.69301 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04368 * frame.width, frame.minY + 0.74701 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05487 * frame.width, frame.minY + 0.71924 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.12532 * frame.width, frame.minY + 0.61910 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.08487 * frame.width, frame.minY + 0.66455 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.10339 * frame.width, frame.minY + 0.63956 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.32631 * frame.width, frame.minY + 0.51592 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.18521 * frame.width, frame.minY + 0.56323 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.26065 * frame.width, frame.minY + 0.52979 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32631 * frame.width, frame.minY + 0.50705 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.20744 * frame.width, frame.minY + 0.27136 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25311 * frame.width, frame.minY + 0.46005 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.20744 * frame.width, frame.minY + 0.37131 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.43370 * frame.width, frame.minY + 0.00116 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.20744 * frame.width, frame.minY + 0.12090 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.30148 * frame.width, frame.minY + 0.00116 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.65996 * frame.width, frame.minY + 0.27136 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56570 * frame.width, frame.minY + 0.00116 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65996 * frame.width, frame.minY + 0.12156 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.54110 * frame.width, frame.minY + 0.50705 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65996 * frame.width, frame.minY + 0.37131 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.61430 * frame.width, frame.minY + 0.46005 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.54110 * frame.width, frame.minY + 0.51592 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.57817 * frame.width, frame.minY + 0.52558 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55318 * frame.width, frame.minY + 0.51847 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56559 * frame.width, frame.minY + 0.52168 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.59358 * frame.width, frame.minY + 0.53066 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58328 * frame.width, frame.minY + 0.52716 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58842 * frame.width, frame.minY + 0.52885 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.52233 * frame.width, frame.minY + 0.59735 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56615 * frame.width, frame.minY + 0.54865 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.54203 * frame.width, frame.minY + 0.57125 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.51783 * frame.width, frame.minY + 0.59636 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.52082 * frame.width, frame.minY + 0.59701 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.51932 * frame.width, frame.minY + 0.59668 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49568 * frame.width, frame.minY + 0.43911 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.45261 * frame.width, frame.minY + 0.58258 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44072 * frame.width, frame.minY + 0.47439 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.57608 * frame.width, frame.minY + 0.27136 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54388 * frame.width, frame.minY + 0.40816 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57608 * frame.width, frame.minY + 0.34392 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.43370 * frame.width, frame.minY + 0.08480 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.57608 * frame.width, frame.minY + 0.16385 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.51418 * frame.width, frame.minY + 0.08480 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.29133 * frame.width, frame.minY + 0.27136 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.35292 * frame.width, frame.minY + 0.08480 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.29133 * frame.width, frame.minY + 0.16323 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.37173 * frame.width, frame.minY + 0.43911 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29133 * frame.width, frame.minY + 0.34392 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32352 * frame.width, frame.minY + 0.40816 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.34958 * frame.width, frame.minY + 0.59636 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42668 * frame.width, frame.minY + 0.47439 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.41480 * frame.width, frame.minY + 0.58258 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.18263 * frame.width, frame.minY + 0.68017 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29752 * frame.width, frame.minY + 0.60736 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22944 * frame.width, frame.minY + 0.63651 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.14286 * frame.width, frame.minY + 0.73314 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16775 * frame.width, frame.minY + 0.69405 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.15445 * frame.width, frame.minY + 0.71200 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.12924 * frame.width, frame.minY + 0.77868 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.13146 * frame.width, frame.minY + 0.75390 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.12924 * frame.width, frame.minY + 0.77868 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.43251 * frame.width, frame.minY + 0.77868 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.46548 * frame.width, frame.minY + 0.77868 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.48145 * frame.width, frame.minY + 0.86231 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.46659 * frame.width, frame.minY + 0.80791 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.47213 * frame.width, frame.minY + 0.83600 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.99884 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98097 * frame.width, frame.minY + 0.76780 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.87731 * frame.width, frame.minY + 0.99884 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98097 * frame.width, frame.minY + 0.89540 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.53676 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98097 * frame.width, frame.minY + 0.64020 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.87731 * frame.width, frame.minY + 0.53676 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.51790 * frame.width, frame.minY + 0.76780 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.62156 * frame.width, frame.minY + 0.53676 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.51790 * frame.width, frame.minY + 0.64020 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.99884 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.51790 * frame.width, frame.minY + 0.89540 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62156 * frame.width, frame.minY + 0.99884 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.93583 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.58105 * frame.width, frame.minY + 0.76780 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65644 * frame.width, frame.minY + 0.93583 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58105 * frame.width, frame.minY + 0.86060 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.59977 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58105 * frame.width, frame.minY + 0.67500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65644 * frame.width, frame.minY + 0.59977 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.91782 * frame.width, frame.minY + 0.76780 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84243 * frame.width, frame.minY + 0.59977 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.91782 * frame.width, frame.minY + 0.67500 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74943 * frame.width, frame.minY + 0.93583 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.91782 * frame.width, frame.minY + 0.86060 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84243 * frame.width, frame.minY + 0.93583 * frame.height))
		bezierPath.closePath()
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}

	//Size 1x1
	public class func writePostIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.90701 * frame.width, frame.minY + 0.99178 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.09322 * frame.width, frame.minY + 0.99178 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01184 * frame.width, frame.minY + 0.90984 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04828 * frame.width, frame.minY + 0.99178 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01184 * frame.width, frame.minY + 0.95510 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.01184 * frame.width, frame.minY + 0.09050 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.09322 * frame.width, frame.minY + 0.00856 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01184 * frame.width, frame.minY + 0.04525 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.04828 * frame.width, frame.minY + 0.00856 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.61445 * frame.width, frame.minY + 0.00856 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53307 * frame.width, frame.minY + 0.09050 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.09322 * frame.width, frame.minY + 0.09050 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.09322 * frame.width, frame.minY + 0.90984 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90701 * frame.width, frame.minY + 0.90984 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90701 * frame.width, frame.minY + 0.46711 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.98839 * frame.width, frame.minY + 0.38518 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.98839 * frame.width, frame.minY + 0.90984 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.90701 * frame.width, frame.minY + 0.99178 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98839 * frame.width, frame.minY + 0.95510 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95195 * frame.width, frame.minY + 0.99178 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90701 * frame.width, frame.minY + 0.99178 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.41874 * frame.width, frame.minY + 0.78694 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.21570 * frame.width, frame.minY + 0.78752 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.21529 * frame.width, frame.minY + 0.58211 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.76663 * frame.width, frame.minY + 0.03155 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.82319 * frame.width, frame.minY + 0.00789 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.78161 * frame.width, frame.minY + 0.01641 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.80196 * frame.width, frame.minY + 0.00789 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.87975 * frame.width, frame.minY + 0.03155 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84442 * frame.width, frame.minY + 0.00789 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86477 * frame.width, frame.minY + 0.01641 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.96438 * frame.width, frame.minY + 0.11717 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98788 * frame.width, frame.minY + 0.17428 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97943 * frame.width, frame.minY + 0.13231 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98788 * frame.width, frame.minY + 0.15285 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.96438 * frame.width, frame.minY + 0.23138 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98788 * frame.width, frame.minY + 0.19570 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97943 * frame.width, frame.minY + 0.21624 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.41874 * frame.width, frame.minY + 0.78694 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.29667 * frame.width, frame.minY + 0.70501 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.41874 * frame.width, frame.minY + 0.70501 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.29667 * frame.width, frame.minY + 0.58211 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.29667 * frame.width, frame.minY + 0.70501 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.29667 * frame.width, frame.minY + 0.70501 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.82319 * frame.width, frame.minY + 0.08865 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.37805 * frame.width, frame.minY + 0.54114 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.45943 * frame.width, frame.minY + 0.62307 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90782 * frame.width, frame.minY + 0.17428 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.82319 * frame.width, frame.minY + 0.08865 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//Size 1x1
	public class func imageIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 38.5))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 4.09, frame.minY + 38.5))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 1, frame.minY + 35.33), controlPoint1: CGPointMake(frame.minX + 2.38, frame.minY + 38.5), controlPoint2: CGPointMake(frame.minX + 1, frame.minY + 37.08))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 1, frame.minY + 3.67))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 4.09, frame.minY + 0.5), controlPoint1: CGPointMake(frame.minX + 1, frame.minY + 1.92), controlPoint2: CGPointMake(frame.minX + 2.38, frame.minY + 0.5))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 0.5))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 38.11, frame.minY + 3.67), controlPoint1: CGPointMake(frame.minX + 36.72, frame.minY + 0.5), controlPoint2: CGPointMake(frame.minX + 38.11, frame.minY + 1.92))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 38.11, frame.minY + 35.33))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 38.5), controlPoint1: CGPointMake(frame.minX + 38.11, frame.minY + 37.08), controlPoint2: CGPointMake(frame.minX + 36.72, frame.minY + 38.5))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 38.5))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 3.67))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 4.09, frame.minY + 3.67))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 4.09, frame.minY + 28.34))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 12.26, frame.minY + 20.01))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 14.48, frame.minY + 20.01), controlPoint1: CGPointMake(frame.minX + 12.87, frame.minY + 19.38), controlPoint2: CGPointMake(frame.minX + 13.86, frame.minY + 19.38))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 21.15, frame.minY + 26.81))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 34.37, frame.minY + 18.15))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 17.95), controlPoint1: CGPointMake(frame.minX + 34.57, frame.minY + 18.03), controlPoint2: CGPointMake(frame.minX + 34.79, frame.minY + 17.96))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 3.67))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 3.67))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 21.7))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 22.23, frame.minY + 30.08))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 22.2, frame.minY + 30.12), controlPoint1: CGPointMake(frame.minX + 22.21, frame.minY + 30.09), controlPoint2: CGPointMake(frame.minX + 22.21, frame.minY + 30.11))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 22.2, frame.minY + 30.12))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 21.33, frame.minY + 30.54), controlPoint1: CGPointMake(frame.minX + 21.96, frame.minY + 30.35), controlPoint2: CGPointMake(frame.minX + 21.66, frame.minY + 30.5))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 19.97, frame.minY + 30.09), controlPoint1: CGPointMake(frame.minX + 20.83, frame.minY + 30.67), controlPoint2: CGPointMake(frame.minX + 20.3, frame.minY + 30.5))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 13.37, frame.minY + 23.37))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 5.21, frame.minY + 31.71))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 4.09, frame.minY + 32.17), controlPoint1: CGPointMake(frame.minX + 4.91, frame.minY + 32.01), controlPoint2: CGPointMake(frame.minX + 4.51, frame.minY + 32.18))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 4.09, frame.minY + 35.33))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 35.33))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 21.7))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 35.02, frame.minY + 21.7))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 11.82, frame.minY + 14.75))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 8.73, frame.minY + 11.58), controlPoint1: CGPointMake(frame.minX + 10.12, frame.minY + 14.75), controlPoint2: CGPointMake(frame.minX + 8.73, frame.minY + 13.33))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 11.82, frame.minY + 8.42), controlPoint1: CGPointMake(frame.minX + 8.73, frame.minY + 9.83), controlPoint2: CGPointMake(frame.minX + 10.12, frame.minY + 8.42))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 14.92, frame.minY + 11.58), controlPoint1: CGPointMake(frame.minX + 13.53, frame.minY + 8.42), controlPoint2: CGPointMake(frame.minX + 14.92, frame.minY + 9.83))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 11.82, frame.minY + 14.75), controlPoint1: CGPointMake(frame.minX + 14.92, frame.minY + 13.33), controlPoint2: CGPointMake(frame.minX + 13.53, frame.minY + 14.75))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 11.82, frame.minY + 14.75))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//Size 1x1
	public class func mapLocationIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50001 * frame.width, frame.minY + 0.46488 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.40878 * frame.width, frame.minY + 0.37016 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.44970 * frame.width, frame.minY + 0.46488 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.40878 * frame.width, frame.minY + 0.42239 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50001 * frame.width, frame.minY + 0.27544 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.40878 * frame.width, frame.minY + 0.31793 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44970 * frame.width, frame.minY + 0.27544 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.59126 * frame.width, frame.minY + 0.37016 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.55032 * frame.width, frame.minY + 0.27544 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.59126 * frame.width, frame.minY + 0.31793 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50001 * frame.width, frame.minY + 0.46488 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.59126 * frame.width, frame.minY + 0.42239 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.55032 * frame.width, frame.minY + 0.46488 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50001 * frame.width, frame.minY + 0.20316 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.33719 * frame.width, frame.minY + 0.37016 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.41024 * frame.width, frame.minY + 0.20316 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33719 * frame.width, frame.minY + 0.27807 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50001 * frame.width, frame.minY + 0.53716 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.33719 * frame.width, frame.minY + 0.46225 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.41024 * frame.width, frame.minY + 0.53716 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66285 * frame.width, frame.minY + 0.37016 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58980 * frame.width, frame.minY + 0.53716 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66285 * frame.width, frame.minY + 0.46225 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50001 * frame.width, frame.minY + 0.20316 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66285 * frame.width, frame.minY + 0.27807 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58980 * frame.width, frame.minY + 0.20316 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.49997 * frame.width, frame.minY + 0.87314 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.38514 * frame.width, frame.minY + 0.72824 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.47232 * frame.width, frame.minY + 0.84217 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.42864 * frame.width, frame.minY + 0.79053 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.24432 * frame.width, frame.minY + 0.38623 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29301 * frame.width, frame.minY + 0.59632 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.24432 * frame.width, frame.minY + 0.47806 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.10761 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.24432 * frame.width, frame.minY + 0.12770 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.44002 * frame.width, frame.minY + 0.10761 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.75568 * frame.width, frame.minY + 0.38623 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73724 * frame.width, frame.minY + 0.10761 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.75568 * frame.width, frame.minY + 0.32086 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49997 * frame.width, frame.minY + 0.87314 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75568 * frame.width, frame.minY + 0.56804 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57248 * frame.width, frame.minY + 0.79173 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.72959 * frame.width, frame.minY + 0.10697 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.02500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.67085 * frame.width, frame.minY + 0.05412 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58930 * frame.width, frame.minY + 0.02500 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.27041 * frame.width, frame.minY + 0.10697 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.41070 * frame.width, frame.minY + 0.02500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32915 * frame.width, frame.minY + 0.05412 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.16250 * frame.width, frame.minY + 0.38623 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.19981 * frame.width, frame.minY + 0.17049 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16250 * frame.width, frame.minY + 0.26705 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.47095 * frame.width, frame.minY + 0.96278 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16250 * frame.width, frame.minY + 0.64580 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.45836 * frame.width, frame.minY + 0.94997 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.97500 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.47864 * frame.width, frame.minY + 0.97061 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.48910 * frame.width, frame.minY + 0.97500 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.52905 * frame.width, frame.minY + 0.96278 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.51090 * frame.width, frame.minY + 0.97500 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.52136 * frame.width, frame.minY + 0.97061 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.83750 * frame.width, frame.minY + 0.38623 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54164 * frame.width, frame.minY + 0.94997 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83750 * frame.width, frame.minY + 0.64580 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72959 * frame.width, frame.minY + 0.10697 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.83750 * frame.width, frame.minY + 0.26705 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.80019 * frame.width, frame.minY + 0.17049 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()

		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
    
    ///
    /// Current user's location
    ///
    public class func currentLocationIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        //// Path 221 Drawing
        let path221Path = UIBezierPath()
        path221Path.moveToPoint(CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.49590 * frame.height))
        path221Path.addLineToPoint(CGPoint(x: frame.minX + 1.00000 * frame.width, y: frame.minY + 0.00000 * frame.height))
        path221Path.addLineToPoint(CGPoint(x: frame.minX + 0.49884 * frame.width, y: frame.minY + 1.00000 * frame.height))
        path221Path.addLineToPoint(CGPoint(x: frame.minX + 0.49884 * frame.width, y: frame.minY + 0.49590 * frame.height))
        path221Path.addLineToPoint(CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.49590 * frame.height))
        path221Path.closePath()
        path221Path.miterLimit = 4;
        
        path221Path.usesEvenOddFillRule = true;
        
        fillColor.setFill()
        path221Path.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    ///
    /// Comment icon in Single post view
    /// Size 18 x 15.65
    ///
    public class func newCommentIcon(size size: CGSize, color fillColor: UIColor!) -> UIImage {
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let messagePath = UIBezierPath()
        messagePath.moveToPoint(CGPoint(x: bounds.minX + 0.67978 * bounds.width, y: bounds.minY + 0.31325 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.66707 * bounds.width, y: bounds.minY + 0.27800 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.67174 * bounds.width, y: bounds.minY + 0.30400 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.66707 * bounds.width, y: bounds.minY + 0.29113 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.67978 * bounds.width, y: bounds.minY + 0.24263 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.66707 * bounds.width, y: bounds.minY + 0.26475 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.67174 * bounds.width, y: bounds.minY + 0.25187 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.71054 * bounds.width, y: bounds.minY + 0.22800 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.68793 * bounds.width, y: bounds.minY + 0.23325 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.69913 * bounds.width, y: bounds.minY + 0.22800 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.74130 * bounds.width, y: bounds.minY + 0.24263 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.72207 * bounds.width, y: bounds.minY + 0.22800 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.73326 * bounds.width, y: bounds.minY + 0.23325 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.75402 * bounds.width, y: bounds.minY + 0.27800 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.74935 * bounds.width, y: bounds.minY + 0.25187 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.75402 * bounds.width, y: bounds.minY + 0.26488 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.74130 * bounds.width, y: bounds.minY + 0.31325 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.75402 * bounds.width, y: bounds.minY + 0.29113 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.74935 * bounds.width, y: bounds.minY + 0.30400 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.71054 * bounds.width, y: bounds.minY + 0.32800 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.73315 * bounds.width, y: bounds.minY + 0.32263 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.72196 * bounds.width, y: bounds.minY + 0.32800 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.67978 * bounds.width, y: bounds.minY + 0.31325 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.69913 * bounds.width, y: bounds.minY + 0.32800 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.68793 * bounds.width, y: bounds.minY + 0.32263 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.67978 * bounds.width, y: bounds.minY + 0.31325 * bounds.height))
        messagePath.closePath()
        messagePath.moveToPoint(CGPoint(x: bounds.minX + 0.20259 * bounds.width, y: bounds.minY + 0.27500 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.24607 * bounds.width, y: bounds.minY + 0.22500 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.20259 * bounds.width, y: bounds.minY + 0.24739 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.22205 * bounds.width, y: bounds.minY + 0.22500 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.56083 * bounds.width, y: bounds.minY + 0.22500 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.60430 * bounds.width, y: bounds.minY + 0.27500 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.58484 * bounds.width, y: bounds.minY + 0.22500 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.60430 * bounds.width, y: bounds.minY + 0.24739 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.56083 * bounds.width, y: bounds.minY + 0.32500 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.60430 * bounds.width, y: bounds.minY + 0.30261 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.58484 * bounds.width, y: bounds.minY + 0.32500 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.24607 * bounds.width, y: bounds.minY + 0.32500 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.20259 * bounds.width, y: bounds.minY + 0.27500 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.22205 * bounds.width, y: bounds.minY + 0.32500 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.20259 * bounds.width, y: bounds.minY + 0.30261 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.20259 * bounds.width, y: bounds.minY + 0.27500 * bounds.height))
        messagePath.closePath()
        messagePath.moveToPoint(CGPoint(x: bounds.minX + 0.91304 * bounds.width, y: bounds.minY + 0.63750 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.79542 * bounds.width, y: bounds.minY + 0.63750 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.75987 * bounds.width, y: bounds.minY + 0.65559 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.78265 * bounds.width, y: bounds.minY + 0.63750 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.76813 * bounds.width, y: bounds.minY + 0.64438 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.64130 * bounds.width, y: bounds.minY + 0.81366 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.64130 * bounds.width, y: bounds.minY + 0.68834 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.60259 * bounds.width, y: bounds.minY + 0.63750 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.64130 * bounds.width, y: bounds.minY + 0.66072 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.62660 * bounds.width, y: bounds.minY + 0.63750 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.08696 * bounds.width, y: bounds.minY + 0.63750 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.08696 * bounds.width, y: bounds.minY + 0.10000 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.91304 * bounds.width, y: bounds.minY + 0.10000 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.91304 * bounds.width, y: bounds.minY + 0.63750 * bounds.height))
        messagePath.closePath()
        messagePath.moveToPoint(CGPoint(x: bounds.minX + 0.95652 * bounds.width, y: bounds.minY + -0.00000 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.04348 * bounds.width, y: bounds.minY + -0.00000 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.00000 * bounds.width, y: bounds.minY + 0.05000 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.01947 * bounds.width, y: bounds.minY + -0.00000 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.00000 * bounds.width, y: bounds.minY + 0.02239 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.00000 * bounds.width, y: bounds.minY + 0.68834 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.04348 * bounds.width, y: bounds.minY + 0.73750 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.00000 * bounds.width, y: bounds.minY + 0.71595 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.01947 * bounds.width, y: bounds.minY + 0.73750 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.55435 * bounds.width, y: bounds.minY + 0.73750 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.55435 * bounds.width, y: bounds.minY + 0.95000 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.58524 * bounds.width, y: bounds.minY + 0.99694 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.55435 * bounds.width, y: bounds.minY + 0.97098 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.56812 * bounds.width, y: bounds.minY + 0.98972 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.60139 * bounds.width, y: bounds.minY + 1.00000 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.59013 * bounds.width, y: bounds.minY + 0.99900 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.59638 * bounds.width, y: bounds.minY + 1.00000 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.63516 * bounds.width, y: bounds.minY + 0.98190 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.61392 * bounds.width, y: bounds.minY + 1.00000 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.62674 * bounds.width, y: bounds.minY + 0.99334 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.81558 * bounds.width, y: bounds.minY + 0.73750 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.95652 * bounds.width, y: bounds.minY + 0.73750 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 1.00000 * bounds.width, y: bounds.minY + 0.68834 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 0.98053 * bounds.width, y: bounds.minY + 0.73750 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 1.00000 * bounds.width, y: bounds.minY + 0.71595 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 1.00000 * bounds.width, y: bounds.minY + 0.05000 * bounds.height))
        messagePath.addCurveToPoint(CGPoint(x: bounds.minX + 0.95652 * bounds.width, y: bounds.minY + -0.00000 * bounds.height), controlPoint1: CGPoint(x: bounds.minX + 1.00000 * bounds.width, y: bounds.minY + 0.02239 * bounds.height), controlPoint2: CGPoint(x: bounds.minX + 0.98053 * bounds.width, y: bounds.minY + -0.00000 * bounds.height))
        messagePath.addLineToPoint(CGPoint(x: bounds.minX + 0.95652 * bounds.width, y: bounds.minY + -0.00000 * bounds.height))
        messagePath.closePath()
        messagePath.miterLimit = 4;
        
        messagePath.usesEvenOddFillRule = true;
        
        fillColor.setFill()
        messagePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}