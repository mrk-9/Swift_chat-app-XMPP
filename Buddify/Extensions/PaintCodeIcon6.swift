//
//  PaintCodeIcon6.swift
//  Buddify
//
//  Created by Huy Le on 4/1/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {

	//Size 1x1
	public class func searchIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.63482 * frame.width, frame.minY + 0.61888 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.37991 * frame.width, frame.minY + 0.35975 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.49425 * frame.width, frame.minY + 0.61888 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.37991 * frame.width, frame.minY + 0.50264 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.63482 * frame.width, frame.minY + 0.10064 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.37991 * frame.width, frame.minY + 0.21688 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.49425 * frame.width, frame.minY + 0.10064 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88972 * frame.width, frame.minY + 0.35975 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77536 * frame.width, frame.minY + 0.10064 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.88972 * frame.width, frame.minY + 0.21688 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.63482 * frame.width, frame.minY + 0.61888 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.88972 * frame.width, frame.minY + 0.50264 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77536 * frame.width, frame.minY + 0.61888 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.29179 * frame.width, frame.minY + 0.35975 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.36456 * frame.width, frame.minY + 0.57325 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29179 * frame.width, frame.minY + 0.44021 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.31902 * frame.width, frame.minY + 0.51430 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.03927 * frame.width, frame.minY + 0.90312 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.03977 * frame.width, frame.minY + 0.97323 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.02005 * frame.width, frame.minY + 0.92262 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02027 * frame.width, frame.minY + 0.95401 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.07457 * frame.width, frame.minY + 0.98750 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04942 * frame.width, frame.minY + 0.98276 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.06200 * frame.width, frame.minY + 0.98750 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.10987 * frame.width, frame.minY + 0.97274 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.08737 * frame.width, frame.minY + 0.98750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.10017 * frame.width, frame.minY + 0.98258 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.43572 * frame.width, frame.minY + 0.64228 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.63482 * frame.width, frame.minY + 0.70702 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.49191 * frame.width, frame.minY + 0.68297 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56062 * frame.width, frame.minY + 0.70702 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.97784 * frame.width, frame.minY + 0.35975 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.82397 * frame.width, frame.minY + 0.70702 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97784 * frame.width, frame.minY + 0.55124 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.63482 * frame.width, frame.minY + 0.01250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97784 * frame.width, frame.minY + 0.16828 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.82397 * frame.width, frame.minY + 0.01250 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.29179 * frame.width, frame.minY + 0.35975 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.44567 * frame.width, frame.minY + 0.01250 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.29179 * frame.width, frame.minY + 0.16828 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//Size 1x1
	public class func settingIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//// Bezier Drawing
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.98491 * frame.width, frame.minY + 0.55653 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.92593 * frame.width, frame.minY + 0.60941 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98147 * frame.width, frame.minY + 0.58655 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.95614 * frame.width, frame.minY + 0.60926 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.92227 * frame.width, frame.minY + 0.60941 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.91780 * frame.width, frame.minY + 0.60941 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.85680 * frame.width, frame.minY + 0.65169 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89068 * frame.width, frame.minY + 0.60954 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86644 * frame.width, frame.minY + 0.62634 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.87428 * frame.width, frame.minY + 0.72383 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.84716 * frame.width, frame.minY + 0.67704 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.85410 * frame.width, frame.minY + 0.70571 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88079 * frame.width, frame.minY + 0.80563 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89748 * frame.width, frame.minY + 0.74521 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.90031 * frame.width, frame.minY + 0.78084 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.80147 * frame.width, frame.minY + 0.88368 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.85745 * frame.width, frame.minY + 0.83462 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83084 * frame.width, frame.minY + 0.86082 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.76487 * frame.width, frame.minY + 0.89641 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.79102 * frame.width, frame.minY + 0.89187 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77815 * frame.width, frame.minY + 0.89635 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72053 * frame.width, frame.minY + 0.87701 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.74804 * frame.width, frame.minY + 0.89637 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73199 * frame.width, frame.minY + 0.88934 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66969 * frame.width, frame.minY + 0.85582 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.70720 * frame.width, frame.minY + 0.86329 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.68883 * frame.width, frame.minY + 0.85563 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.64692 * frame.width, frame.minY + 0.86009 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66190 * frame.width, frame.minY + 0.85578 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.65417 * frame.width, frame.minY + 0.85723 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60624 * frame.width, frame.minY + 0.92354 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.62152 * frame.width, frame.minY + 0.87077 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.60534 * frame.width, frame.minY + 0.89601 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.55296 * frame.width, frame.minY + 0.98513 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.60725 * frame.width, frame.minY + 0.95482 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58406 * frame.width, frame.minY + 0.98162 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.44314 * frame.width, frame.minY + 0.98484 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.51646 * frame.width, frame.minY + 0.98918 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.47962 * frame.width, frame.minY + 0.98908 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39067 * frame.width, frame.minY + 0.92192 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.41170 * frame.width, frame.minY + 0.98116 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38864 * frame.width, frame.minY + 0.95351 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.35041 * frame.width, frame.minY + 0.85745 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.39205 * frame.width, frame.minY + 0.89412 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.37599 * frame.width, frame.minY + 0.86840 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.32722 * frame.width, frame.minY + 0.85301 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34304 * frame.width, frame.minY + 0.85447 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33517 * frame.width, frame.minY + 0.85297 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.27638 * frame.width, frame.minY + 0.87416 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.30810 * frame.width, frame.minY + 0.85284 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28974 * frame.width, frame.minY + 0.86048 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.19422 * frame.width, frame.minY + 0.88067 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25502 * frame.width, frame.minY + 0.89770 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.21903 * frame.width, frame.minY + 0.90055 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11735 * frame.width, frame.minY + 0.80245 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16571 * frame.width, frame.minY + 0.85761 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.13992 * frame.width, frame.minY + 0.83137 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.12386 * frame.width, frame.minY + 0.72151 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.09783 * frame.width, frame.minY + 0.77798 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.10068 * frame.width, frame.minY + 0.74255 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.14053 * frame.width, frame.minY + 0.64793 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.14410 * frame.width, frame.minY + 0.70279 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.15072 * frame.width, frame.minY + 0.67354 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.08156 * frame.width, frame.minY + 0.60725 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.13078 * frame.width, frame.minY + 0.62380 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.10758 * frame.width, frame.minY + 0.60780 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.07912 * frame.width, frame.minY + 0.60725 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01526 * frame.width, frame.minY + 0.55417 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.04768 * frame.width, frame.minY + 0.60767 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.02060 * frame.width, frame.minY + 0.58516 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01526 * frame.width, frame.minY + 0.44317 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01079 * frame.width, frame.minY + 0.51731 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01079 * frame.width, frame.minY + 0.48004 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.07627 * frame.width, frame.minY + 0.39029 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01849 * frame.width, frame.minY + 0.41222 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.04518 * frame.width, frame.minY + 0.38910 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.14257 * frame.width, frame.minY + 0.35019 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.10440 * frame.width, frame.minY + 0.39138 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.13047 * frame.width, frame.minY + 0.37561 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.12589 * frame.width, frame.minY + 0.27604 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.15321 * frame.width, frame.minY + 0.32443 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.14654 * frame.width, frame.minY + 0.29476 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11938 * frame.width, frame.minY + 0.19428 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.10270 * frame.width, frame.minY + 0.25467 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09986 * frame.width, frame.minY + 0.21905 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.19829 * frame.width, frame.minY + 0.11618 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.14264 * frame.width, frame.minY + 0.16534 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16911 * frame.width, frame.minY + 0.13914 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.23530 * frame.width, frame.minY + 0.10345 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.20890 * frame.width, frame.minY + 0.10800 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22190 * frame.width, frame.minY + 0.10353 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.27964 * frame.width, frame.minY + 0.12297 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25215 * frame.width, frame.minY + 0.10350 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.26822 * frame.width, frame.minY + 0.11058 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.33048 * frame.width, frame.minY + 0.14400 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.29302 * frame.width, frame.minY + 0.13660 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.31138 * frame.width, frame.minY + 0.14419 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.35326 * frame.width, frame.minY + 0.13994 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.33826 * frame.width, frame.minY + 0.14409 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.34598 * frame.width, frame.minY + 0.14271 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.39393 * frame.width, frame.minY + 0.07636 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.37868 * frame.width, frame.minY + 0.12923 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.39486 * frame.width, frame.minY + 0.10394 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.44721 * frame.width, frame.minY + 0.01486 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.39295 * frame.width, frame.minY + 0.04511 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.41614 * frame.width, frame.minY + 0.01834 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.55703 * frame.width, frame.minY + 0.01514 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.48371 * frame.width, frame.minY + 0.01083 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.52055 * frame.width, frame.minY + 0.01092 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60950 * frame.width, frame.minY + 0.07803 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58844 * frame.width, frame.minY + 0.01884 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.61149 * frame.width, frame.minY + 0.04646 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.64976 * frame.width, frame.minY + 0.14258 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.60794 * frame.width, frame.minY + 0.10589 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62405 * frame.width, frame.minY + 0.13173 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.67295 * frame.width, frame.minY + 0.14697 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65714 * frame.width, frame.minY + 0.14552 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66501 * frame.width, frame.minY + 0.14701 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72379 * frame.width, frame.minY + 0.12586 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69206 * frame.width, frame.minY + 0.14714 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.71041 * frame.width, frame.minY + 0.13952 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.80554 * frame.width, frame.minY + 0.11927 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.74502 * frame.width, frame.minY + 0.10241 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.78083 * frame.width, frame.minY + 0.09953 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.88282 * frame.width, frame.minY + 0.19741 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.83422 * frame.width, frame.minY + 0.14226 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.86015 * frame.width, frame.minY + 0.16848 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.87631 * frame.width, frame.minY + 0.27876 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.90247 * frame.width, frame.minY + 0.22199 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89962 * frame.width, frame.minY + 0.25762 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.85934 * frame.width, frame.minY + 0.35149 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.85605 * frame.width, frame.minY + 0.29710 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84929 * frame.width, frame.minY + 0.32608 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.92146 * frame.width, frame.minY + 0.39294 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.86938 * frame.width, frame.minY + 0.37690 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89414 * frame.width, frame.minY + 0.39342 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98491 * frame.width, frame.minY + 0.44581 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.95270 * frame.width, frame.minY + 0.39267 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97954 * frame.width, frame.minY + 0.41504 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98491 * frame.width, frame.minY + 0.55653 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98916 * frame.width, frame.minY + 0.48260 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98916 * frame.width, frame.minY + 0.51975 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.98491 * frame.width, frame.minY + 0.55653 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.90438 * frame.width, frame.minY + 0.46204 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.78647 * frame.width, frame.minY + 0.38102 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.85248 * frame.width, frame.minY + 0.46083 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.80622 * frame.width, frame.minY + 0.42903 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.81327 * frame.width, frame.minY + 0.24049 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.76673 * frame.width, frame.minY + 0.33301 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77724 * frame.width, frame.minY + 0.27786 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.76039 * frame.width, frame.minY + 0.18700 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.79740 * frame.width, frame.minY + 0.22100 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77970 * frame.width, frame.minY + 0.20309 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66725 * frame.width, frame.minY + 0.22361 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73511 * frame.width, frame.minY + 0.21057 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.70182 * frame.width, frame.minY + 0.22365 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.61885 * frame.width, frame.minY + 0.21413 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.65065 * frame.width, frame.minY + 0.22371 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.63419 * frame.width, frame.minY + 0.22048 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.53873 * frame.width, frame.minY + 0.09426 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.57062 * frame.width, frame.minY + 0.19373 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.53913 * frame.width, frame.minY + 0.14662 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.46348 * frame.width, frame.minY + 0.09426 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.51370 * frame.width, frame.minY + 0.09194 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.48851 * frame.width, frame.minY + 0.09194 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.37929 * frame.width, frame.minY + 0.20408 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.46065 * frame.width, frame.minY + 0.14469 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.42725 * frame.width, frame.minY + 0.18826 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.33455 * frame.width, frame.minY + 0.22104 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.36568 * frame.width, frame.minY + 0.21272 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35046 * frame.width, frame.minY + 0.21849 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.24181 * frame.width, frame.minY + 0.18480 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.30017 * frame.width, frame.minY + 0.22109 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.26705 * frame.width, frame.minY + 0.20814 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.18731 * frame.width, frame.minY + 0.23837 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22195 * frame.width, frame.minY + 0.20085 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.20370 * frame.width, frame.minY + 0.21879 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.21415 * frame.width, frame.minY + 0.38008 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22374 * frame.width, frame.minY + 0.27601 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.23429 * frame.width, frame.minY + 0.33172 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.09457 * frame.width, frame.minY + 0.46005 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.19315 * frame.width, frame.minY + 0.42765 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.14656 * frame.width, frame.minY + 0.45881 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.09417 * frame.width, frame.minY + 0.53652 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.09220 * frame.width, frame.minY + 0.48548 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.09206 * frame.width, frame.minY + 0.51107 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.21244 * frame.width, frame.minY + 0.61744 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.14619 * frame.width, frame.minY + 0.53752 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.19265 * frame.width, frame.minY + 0.56932 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.18527 * frame.width, frame.minY + 0.75816 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.23222 * frame.width, frame.minY + 0.66557 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.22155 * frame.width, frame.minY + 0.72085 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.23815 * frame.width, frame.minY + 0.81169 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.20134 * frame.width, frame.minY + 0.77747 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.21903 * frame.width, frame.minY + 0.79538 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.33129 * frame.width, frame.minY + 0.77508 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.26351 * frame.width, frame.minY + 0.78824 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.29675 * frame.width, frame.minY + 0.77517 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.38010 * frame.width, frame.minY + 0.78460 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.34803 * frame.width, frame.minY + 0.77495 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.36463 * frame.width, frame.minY + 0.77819 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.46023 * frame.width, frame.minY + 0.90439 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42835 * frame.width, frame.minY + 0.80492 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.45986 * frame.width, frame.minY + 0.85203 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.53547 * frame.width, frame.minY + 0.90439 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.48525 * frame.width, frame.minY + 0.90673 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.51044 * frame.width, frame.minY + 0.90673 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.61641 * frame.width, frame.minY + 0.78671 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.53709 * frame.width, frame.minY + 0.85270 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56872 * frame.width, frame.minY + 0.80671 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66400 * frame.width, frame.minY + 0.77760 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.63154 * frame.width, frame.minY + 0.78063 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.64770 * frame.width, frame.minY + 0.77753 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.75714 * frame.width, frame.minY + 0.81388 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.69851 * frame.width, frame.minY + 0.77749 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73179 * frame.width, frame.minY + 0.79046 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.81164 * frame.width, frame.minY + 0.76031 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77687 * frame.width, frame.minY + 0.79768 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.79511 * frame.width, frame.minY + 0.77976 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.78480 * frame.width, frame.minY + 0.61860 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77502 * frame.width, frame.minY + 0.72277 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76444 * frame.width, frame.minY + 0.66694 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.90438 * frame.width, frame.minY + 0.53831 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.80533 * frame.width, frame.minY + 0.57059 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.85217 * frame.width, frame.minY + 0.53914 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.90438 * frame.width, frame.minY + 0.46188 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.90683 * frame.width, frame.minY + 0.51289 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.90683 * frame.width, frame.minY + 0.48730 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.90438 * frame.width, frame.minY + 0.46204 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50009 * frame.width, frame.minY + 0.66229 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.34909 * frame.width, frame.minY + 0.56215 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.43413 * frame.width, frame.minY + 0.66255 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.37451 * frame.width, frame.minY + 0.62302 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.38399 * frame.width, frame.minY + 0.38436 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.32366 * frame.width, frame.minY + 0.50128 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.33744 * frame.width, frame.minY + 0.43109 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.56164 * frame.width, frame.minY + 0.34874 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.43054 * frame.width, frame.minY + 0.33762 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.50067 * frame.width, frame.minY + 0.32356 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66237 * frame.width, frame.minY + 0.49934 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.62260 * frame.width, frame.minY + 0.37392 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.66237 * frame.width, frame.minY + 0.43338 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50009 * frame.width, frame.minY + 0.66229 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.66251 * frame.width, frame.minY + 0.58914 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58988 * frame.width, frame.minY + 0.66206 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.50009 * frame.width, frame.minY + 0.66229 * frame.height))
		bezierPath.closePath()
		bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50009 * frame.width, frame.minY + 0.41856 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.41915 * frame.width, frame.minY + 0.50018 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.45521 * frame.width, frame.minY + 0.41879 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.41900 * frame.width, frame.minY + 0.45531 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50063 * frame.width, frame.minY + 0.58126 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.41930 * frame.width, frame.minY + 0.54506 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.45575 * frame.width, frame.minY + 0.58134 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.58184 * frame.width, frame.minY + 0.49991 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54550 * frame.width, frame.minY + 0.58119 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58184 * frame.width, frame.minY + 0.54479 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.55788 * frame.width, frame.minY + 0.44222 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58185 * frame.width, frame.minY + 0.47826 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57323 * frame.width, frame.minY + 0.45749 * frame.height))
		bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50009 * frame.width, frame.minY + 0.41852 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54254 * frame.width, frame.minY + 0.42694 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.52174 * frame.width, frame.minY + 0.41841 * frame.height))
		bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.50009 * frame.width, frame.minY + 0.41856 * frame.height))
		bezierPath.closePath()
		bezierPath.usesEvenOddFillRule = true;
		
		fillColor.setFill()
		bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//1x1
	public class func questionMarkIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Subframes
		let miu: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
		//// miu
		//// Artboard-1
		//// slice
		
		//// circle-help-question-mark-outline-stroke Drawing
		let circlehelpquestionmarkoutlinestrokePath = UIBezierPath()
		circlehelpquestionmarkoutlinestrokePath.moveToPoint(CGPointMake(miu.minX + 0.00000 * miu.width, miu.minY + 0.50000 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.50000 * miu.width, miu.minY + 0.00000 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.00000 * miu.width, miu.minY + 0.22386 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.22386 * miu.width, miu.minY + 0.00000 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 1.00000 * miu.width, miu.minY + 0.50000 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.77614 * miu.width, miu.minY + 0.00000 * miu.height), controlPoint2: CGPointMake(miu.minX + 1.00000 * miu.width, miu.minY + 0.22386 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.50000 * miu.width, miu.minY + 1.00000 * miu.height), controlPoint1: CGPointMake(miu.minX + 1.00000 * miu.width, miu.minY + 0.77614 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.77614 * miu.width, miu.minY + 1.00000 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.00000 * miu.width, miu.minY + 0.50000 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.22386 * miu.width, miu.minY + 1.00000 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.00000 * miu.width, miu.minY + 0.77614 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.closePath()
		circlehelpquestionmarkoutlinestrokePath.moveToPoint(CGPointMake(miu.minX + 0.95652 * miu.width, miu.minY + 0.50000 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.50000 * miu.width, miu.minY + 0.04348 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.95652 * miu.width, miu.minY + 0.24787 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.75213 * miu.width, miu.minY + 0.04348 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.04348 * miu.width, miu.minY + 0.50000 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.24787 * miu.width, miu.minY + 0.04348 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.04348 * miu.width, miu.minY + 0.24787 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.50000 * miu.width, miu.minY + 0.95652 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.04348 * miu.width, miu.minY + 0.75213 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.24787 * miu.width, miu.minY + 0.95652 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.95652 * miu.width, miu.minY + 0.50000 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.75213 * miu.width, miu.minY + 0.95652 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.95652 * miu.width, miu.minY + 0.75213 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.closePath()
		circlehelpquestionmarkoutlinestrokePath.moveToPoint(CGPointMake(miu.minX + 0.46384 * miu.width, miu.minY + 0.66848 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addLineToPoint(CGPointMake(miu.minX + 0.52721 * miu.width, miu.minY + 0.66848 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addLineToPoint(CGPointMake(miu.minX + 0.52721 * miu.width, miu.minY + 0.73471 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addLineToPoint(CGPointMake(miu.minX + 0.46384 * miu.width, miu.minY + 0.73471 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addLineToPoint(CGPointMake(miu.minX + 0.46384 * miu.width, miu.minY + 0.66848 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.closePath()
		circlehelpquestionmarkoutlinestrokePath.moveToPoint(CGPointMake(miu.minX + 0.39537 * miu.width, miu.minY + 0.30274 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.50205 * miu.width, miu.minY + 0.26087 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.42127 * miu.width, miu.minY + 0.27483 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.45683 * miu.width, miu.minY + 0.26087 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.60252 * miu.width, miu.minY + 0.29669 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.54387 * miu.width, miu.minY + 0.26087 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.57736 * miu.width, miu.minY + 0.27281 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.64026 * miu.width, miu.minY + 0.38825 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.62768 * miu.width, miu.minY + 0.32058 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.64026 * miu.width, miu.minY + 0.35110 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.62640 * miu.width, miu.minY + 0.44302 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.64026 * miu.width, miu.minY + 0.41075 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.63564 * miu.width, miu.minY + 0.42901 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.57052 * miu.width, miu.minY + 0.50480 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.61717 * miu.width, miu.minY + 0.45703 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.59854 * miu.width, miu.minY + 0.47762 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.53087 * miu.width, miu.minY + 0.55495 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.55014 * miu.width, miu.minY + 0.52454 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.53692 * miu.width, miu.minY + 0.54126 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.52179 * miu.width, miu.minY + 0.61562 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.52482 * miu.width, miu.minY + 0.56865 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.52179 * miu.width, miu.minY + 0.58887 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addLineToPoint(CGPointMake(miu.minX + 0.46511 * miu.width, miu.minY + 0.61562 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.47594 * miu.width, miu.minY + 0.54222 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.46511 * miu.width, miu.minY + 0.58526 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.46872 * miu.width, miu.minY + 0.56079 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.52339 * miu.width, miu.minY + 0.47837 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.48316 * miu.width, miu.minY + 0.52364 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.49897 * miu.width, miu.minY + 0.50236 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addLineToPoint(CGPointMake(miu.minX + 0.54886 * miu.width, miu.minY + 0.45321 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.56733 * miu.width, miu.minY + 0.43060 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.55651 * miu.width, miu.minY + 0.44599 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.56266 * miu.width, miu.minY + 0.43846 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.58007 * miu.width, miu.minY + 0.38761 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.57582 * miu.width, miu.minY + 0.41680 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.58007 * miu.width, miu.minY + 0.40247 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.56144 * miu.width, miu.minY + 0.33347 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.58007 * miu.width, miu.minY + 0.36681 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.57386 * miu.width, miu.minY + 0.34876 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.49982 * miu.width, miu.minY + 0.31055 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.54902 * miu.width, miu.minY + 0.31819 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.52848 * miu.width, miu.minY + 0.31055 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.42626 * miu.width, miu.minY + 0.35003 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.46437 * miu.width, miu.minY + 0.31055 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.43985 * miu.width, miu.minY + 0.32371 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.41321 * miu.width, miu.minY + 0.41340 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.41862 * miu.width, miu.minY + 0.36468 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.41427 * miu.width, miu.minY + 0.38581 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addLineToPoint(CGPointMake(miu.minX + 0.35652 * miu.width, miu.minY + 0.41340 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.39537 * miu.width, miu.minY + 0.30274 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.35652 * miu.width, miu.minY + 0.36755 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.36947 * miu.width, miu.minY + 0.33066 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.addCurveToPoint(CGPointMake(miu.minX + 0.39537 * miu.width, miu.minY + 0.30274 * miu.height), controlPoint1: CGPointMake(miu.minX + 0.39537 * miu.width, miu.minY + 0.30274 * miu.height), controlPoint2: CGPointMake(miu.minX + 0.36947 * miu.width, miu.minY + 0.33066 * miu.height))
		circlehelpquestionmarkoutlinestrokePath.closePath()
		circlehelpquestionmarkoutlinestrokePath.miterLimit = 4;
		circlehelpquestionmarkoutlinestrokePath.usesEvenOddFillRule = true;
		fillColor.setFill()
		circlehelpquestionmarkoutlinestrokePath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//1x1
	public class func newPostIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier 18 Drawing
		let bezier18Path = UIBezierPath()
		bezier18Path.moveToPoint(CGPointMake(frame.minX + 0.93204 * frame.width, frame.minY + 0.05741 * frame.height))
		bezier18Path.addCurveToPoint(CGPointMake(frame.minX + 0.93204 * frame.width, frame.minY + 0.19889 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97106 * frame.width, frame.minY + 0.09643 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97106 * frame.width, frame.minY + 0.15969 * frame.height))
		bezier18Path.addCurveToPoint(CGPointMake(frame.minX + 0.91499 * frame.width, frame.minY + 0.21577 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.93204 * frame.width, frame.minY + 0.19889 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.91516 * frame.width, frame.minY + 0.21577 * frame.height))
		bezier18Path.addLineToPoint(CGPointMake(frame.minX + 0.77352 * frame.width, frame.minY + 0.07428 * frame.height))
		bezier18Path.addCurveToPoint(CGPointMake(frame.minX + 0.79057 * frame.width, frame.minY + 0.05741 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77368 * frame.width, frame.minY + 0.07428 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.79057 * frame.width, frame.minY + 0.05741 * frame.height))
		bezier18Path.addCurveToPoint(CGPointMake(frame.minX + 0.93204 * frame.width, frame.minY + 0.05741 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.82958 * frame.width, frame.minY + 0.01839 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.89286 * frame.width, frame.minY + 0.01839 * frame.height))
		bezier18Path.closePath()
		bezier18Path.lineCapStyle = .Round;
		bezier18Path.lineJoinStyle = .Round;
		fillColor.setFill()
		bezier18Path.fill()
		
		
		//// Bezier 19 Drawing
		let bezier19Path = UIBezierPath()
		bezier19Path.moveToPoint(CGPointMake(frame.minX + 0.08171 * frame.width, frame.minY + 0.79511 * frame.height))
		bezier19Path.addLineToPoint(CGPointMake(frame.minX + 0.19417 * frame.width, frame.minY + 0.90774 * frame.height))
		bezier19Path.addLineToPoint(CGPointMake(frame.minX + 0.04648 * frame.width, frame.minY + 0.94298 * frame.height))
		bezier19Path.addLineToPoint(CGPointMake(frame.minX + 0.08171 * frame.width, frame.minY + 0.79511 * frame.height))
		bezier19Path.closePath()
		bezier19Path.lineCapStyle = .Round;
		bezier19Path.lineJoinStyle = .Round;
		fillColor.setFill()
		bezier19Path.fill()
		
		
		//// Bezier 20 Drawing
		let bezier20Path = UIBezierPath()
		bezier20Path.moveToPoint(CGPointMake(frame.minX + 0.19418 * frame.width, frame.minY + 0.90774 * frame.height))
		bezier20Path.addLineToPoint(CGPointMake(frame.minX + 0.19055 * frame.width, frame.minY + 0.91135 * frame.height))
		bezier20Path.addLineToPoint(CGPointMake(frame.minX + 0.03663 * frame.width, frame.minY + 0.95264 * frame.height))
		bezier20Path.addLineToPoint(CGPointMake(frame.minX + 0.07795 * frame.width, frame.minY + 0.79887 * frame.height))
		bezier20Path.addLineToPoint(CGPointMake(frame.minX + 0.08172 * frame.width, frame.minY + 0.79512 * frame.height))
		bezier20Path.addLineToPoint(CGPointMake(frame.minX + 0.74483 * frame.width, frame.minY + 0.13184 * frame.height))
		bezier20Path.lineCapStyle = .Round;
		
		bezier20Path.lineJoinStyle = .Round;
		
		fillColor.setStroke()
		bezier20Path.miterLimit = 4
		bezier20Path.stroke()
		
		
		//// Bezier 21 Drawing
		let bezier21Path = UIBezierPath()
		bezier21Path.moveToPoint(CGPointMake(frame.minX + 0.91499 * frame.width, frame.minY + 0.21577 * frame.height))
		bezier21Path.addCurveToPoint(CGPointMake(frame.minX + 0.93204 * frame.width, frame.minY + 0.19889 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.91516 * frame.width, frame.minY + 0.21577 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.93204 * frame.width, frame.minY + 0.19889 * frame.height))
		bezier21Path.addCurveToPoint(CGPointMake(frame.minX + 0.93204 * frame.width, frame.minY + 0.05741 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.97106 * frame.width, frame.minY + 0.15969 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.97106 * frame.width, frame.minY + 0.09643 * frame.height))
		bezier21Path.addCurveToPoint(CGPointMake(frame.minX + 0.79057 * frame.width, frame.minY + 0.05741 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.89286 * frame.width, frame.minY + 0.01839 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.82958 * frame.width, frame.minY + 0.01839 * frame.height))
		bezier21Path.addCurveToPoint(CGPointMake(frame.minX + 0.77352 * frame.width, frame.minY + 0.07428 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.79057 * frame.width, frame.minY + 0.05741 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77368 * frame.width, frame.minY + 0.07428 * frame.height))
		bezier21Path.addLineToPoint(CGPointMake(frame.minX + 0.91499 * frame.width, frame.minY + 0.21577 * frame.height))
		bezier21Path.closePath()
		bezier21Path.lineCapStyle = .Round;
		bezier21Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier21Path.miterLimit = 4
		bezier21Path.stroke()
		
		
		//// Bezier 22 Drawing
		let bezier22Path = UIBezierPath()
		bezier22Path.moveToPoint(CGPointMake(frame.minX + 0.85745 * frame.width, frame.minY + 0.24446 * frame.height))
		bezier22Path.addLineToPoint(CGPointMake(frame.minX + 0.19434 * frame.width, frame.minY + 0.90774 * frame.height))
		bezier22Path.addLineToPoint(CGPointMake(frame.minX + 0.19418 * frame.width, frame.minY + 0.90774 * frame.height))
		bezier22Path.addLineToPoint(CGPointMake(frame.minX + 0.04647 * frame.width, frame.minY + 0.94297 * frame.height))
		bezier22Path.addLineToPoint(CGPointMake(frame.minX + 0.08172 * frame.width, frame.minY + 0.79512 * frame.height))
		bezier22Path.addLineToPoint(CGPointMake(frame.minX + 0.19418 * frame.width, frame.minY + 0.90774 * frame.height))
		bezier22Path.lineCapStyle = .Round;
		bezier22Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier22Path.miterLimit = 4
		bezier22Path.stroke()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//1x1
	public class func newMessageIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
		
		//PaintCode here
        //// bounds
        //// Artboard-1
        //// write
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(bounds.minX + 0.91667 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.08333 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        bezierPath.addCurveToPoint(CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.91672 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.03731 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.96272 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.08396 * bounds.height))
        bezierPath.addCurveToPoint(CGPointMake(bounds.minX + 0.08333 * bounds.width, bounds.minY + 0.00068 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.00000 * bounds.width, bounds.minY + 0.03796 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.03731 * bounds.width, bounds.minY + 0.00068 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.61708 * bounds.width, bounds.minY + 0.00068 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.53375 * bounds.width, bounds.minY + 0.08396 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.08333 * bounds.width, bounds.minY + 0.08396 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.08333 * bounds.width, bounds.minY + 0.91672 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.91667 * bounds.width, bounds.minY + 0.91672 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.91667 * bounds.width, bounds.minY + 0.46674 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.38346 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.91672 * bounds.height))
        bezierPath.addCurveToPoint(CGPointMake(bounds.minX + 0.91667 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 1.00000 * bounds.width, bounds.minY + 0.96272 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.96269 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.91667 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(bounds.minX + 0.41667 * bounds.width, bounds.minY + 0.79181 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.20875 * bounds.width, bounds.minY + 0.79239 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.20833 * bounds.width, bounds.minY + 0.58362 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.77292 * bounds.width, bounds.minY + 0.02404 * bounds.height))
        bezierPath.addCurveToPoint(CGPointMake(bounds.minX + 0.83083 * bounds.width, bounds.minY + 0.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.78826 * bounds.width, bounds.minY + 0.00865 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.80910 * bounds.width, bounds.minY + 0.00000 * bounds.height))
        bezierPath.addCurveToPoint(CGPointMake(bounds.minX + 0.88875 * bounds.width, bounds.minY + 0.02404 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.85257 * bounds.width, bounds.minY + 0.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.87341 * bounds.width, bounds.minY + 0.00865 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.97542 * bounds.width, bounds.minY + 0.11106 * bounds.height))
        bezierPath.addCurveToPoint(CGPointMake(bounds.minX + 0.99948 * bounds.width, bounds.minY + 0.16911 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.99083 * bounds.width, bounds.minY + 0.12645 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.99948 * bounds.width, bounds.minY + 0.14733 * bounds.height))
        bezierPath.addCurveToPoint(CGPointMake(bounds.minX + 0.97542 * bounds.width, bounds.minY + 0.22715 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.99948 * bounds.width, bounds.minY + 0.19088 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.99083 * bounds.width, bounds.minY + 0.21176 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.41667 * bounds.width, bounds.minY + 0.79181 * bounds.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(bounds.minX + 0.29167 * bounds.width, bounds.minY + 0.70853 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.41667 * bounds.width, bounds.minY + 0.70853 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.29167 * bounds.width, bounds.minY + 0.58362 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.29167 * bounds.width, bounds.minY + 0.70853 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.29167 * bounds.width, bounds.minY + 0.70853 * bounds.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(bounds.minX + 0.83083 * bounds.width, bounds.minY + 0.08208 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.37500 * bounds.width, bounds.minY + 0.54198 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.45833 * bounds.width, bounds.minY + 0.62525 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.91750 * bounds.width, bounds.minY + 0.16911 * bounds.height))
        bezierPath.addLineToPoint(CGPointMake(bounds.minX + 0.83083 * bounds.width, bounds.minY + 0.08208 * bounds.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        bezierPath.usesEvenOddFillRule = true;
        
        fillColor.setFill()
        bezierPath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
}