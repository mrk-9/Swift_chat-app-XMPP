//
//  PaintCodeIcons2.swift
//  Buddify
//
//  Created by Vo Duc Tung on 13/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {
    public class func likeIconSolid(size size: CGSize, color fillColor: UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
        //// Subframes
        let subframe: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.01000 + 0.32) + 0.18, frame.minY + floor(frame.height * 0.04333 - 0.28) + 0.78, floor(frame.width * 0.99000 - 0.32) - floor(frame.width * 0.01000 + 0.32) + 0.64, floor(frame.height * 0.95667 + 0.28) - floor(frame.height * 0.04333 - 0.28) - 0.56)
        
        
        //// subframe
        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(subframe.minX + 1.00000 * subframe.width, subframe.minY + 0.29015 * subframe.height))
        bezierPath.addCurveToPoint(CGPointMake(subframe.minX + 0.51814 * subframe.width, subframe.minY + 0.99148 * subframe.height), controlPoint1: CGPointMake(subframe.minX + 1.00000 * subframe.width, subframe.minY + 0.48540 * subframe.height), controlPoint2: CGPointMake(subframe.minX + 0.75283 * subframe.width, subframe.minY + 0.83698 * subframe.height))
        bezierPath.addLineToPoint(CGPointMake(subframe.minX + 0.50000 * subframe.width, subframe.minY + 1.00000 * subframe.height))
        bezierPath.addLineToPoint(CGPointMake(subframe.minX + 0.48186 * subframe.width, subframe.minY + 0.99148 * subframe.height))
        bezierPath.addCurveToPoint(CGPointMake(subframe.minX + 0.00000 * subframe.width, subframe.minY + 0.29015 * subframe.height), controlPoint1: CGPointMake(subframe.minX + 0.24717 * subframe.width, subframe.minY + 0.83698 * subframe.height), controlPoint2: CGPointMake(subframe.minX + 0.00000 * subframe.width, subframe.minY + 0.48540 * subframe.height))
        bezierPath.addCurveToPoint(CGPointMake(subframe.minX + 0.27268 * subframe.width, subframe.minY + -0.00000 * subframe.height), controlPoint1: CGPointMake(subframe.minX + 0.00057 * subframe.width, subframe.minY + 0.13017 * subframe.height), controlPoint2: CGPointMake(subframe.minX + 0.12302 * subframe.width, subframe.minY + -0.00000 * subframe.height))
        bezierPath.addCurveToPoint(CGPointMake(subframe.minX + 0.50000 * subframe.width, subframe.minY + 0.13078 * subframe.height), controlPoint1: CGPointMake(subframe.minX + 0.36735 * subframe.width, subframe.minY + -0.00000 * subframe.height), controlPoint2: CGPointMake(subframe.minX + 0.45125 * subframe.width, subframe.minY + 0.05231 * subframe.height))
        bezierPath.addCurveToPoint(CGPointMake(subframe.minX + 0.72732 * subframe.width, subframe.minY + -0.00000 * subframe.height), controlPoint1: CGPointMake(subframe.minX + 0.54875 * subframe.width, subframe.minY + 0.05231 * subframe.height), controlPoint2: CGPointMake(subframe.minX + 0.63265 * subframe.width, subframe.minY + -0.00000 * subframe.height))
        bezierPath.addCurveToPoint(CGPointMake(subframe.minX + 1.00000 * subframe.width, subframe.minY + 0.29015 * subframe.height), controlPoint1: CGPointMake(subframe.minX + 0.87698 * subframe.width, subframe.minY + -0.00000 * subframe.height), controlPoint2: CGPointMake(subframe.minX + 0.99943 * subframe.width, subframe.minY + 0.13017 * subframe.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor.setFill()
        bezierPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public class func likeIconLine(size size: CGSize, color fillColor: UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.51789 * frame.width, frame.minY + 0.94856 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49994 * frame.width, frame.minY + 0.95644 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.48206 * frame.width, frame.minY + 0.94856 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01000 * frame.width, frame.minY + 0.30794 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.25189 * frame.width, frame.minY + 0.80750 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01000 * frame.width, frame.minY + 0.48633 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.27728 * frame.width, frame.minY + 0.04333 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01078 * frame.width, frame.minY + 0.16189 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.13039 * frame.width, frame.minY + 0.04333 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.16250 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.37011 * frame.width, frame.minY + 0.04333 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.45206 * frame.width, frame.minY + 0.09072 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72272 * frame.width, frame.minY + 0.04333 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.54789 * frame.width, frame.minY + 0.09072 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.62989 * frame.width, frame.minY + 0.04333 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.99006 * frame.width, frame.minY + 0.30794 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.86967 * frame.width, frame.minY + 0.04333 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98922 * frame.width, frame.minY + 0.16189 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.51789 * frame.width, frame.minY + 0.94856 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98994 * frame.width, frame.minY + 0.48633 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.74800 * frame.width, frame.minY + 0.80750 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.72267 * frame.width, frame.minY + 0.08772 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.53706 * frame.width, frame.minY + 0.18706 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.64794 * frame.width, frame.minY + 0.08772 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.57861 * frame.width, frame.minY + 0.12483 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49994 * frame.width, frame.minY + 0.24256 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.46289 * frame.width, frame.minY + 0.18700 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.27728 * frame.width, frame.minY + 0.08767 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.42133 * frame.width, frame.minY + 0.12478 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35194 * frame.width, frame.minY + 0.08767 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.05456 * frame.width, frame.minY + 0.30794 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.15517 * frame.width, frame.minY + 0.08767 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05522 * frame.width, frame.minY + 0.18661 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.90744 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05456 * frame.width, frame.minY + 0.46528 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.28250 * frame.width, frame.minY + 0.77133 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.94544 * frame.width, frame.minY + 0.30822 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.71750 * frame.width, frame.minY + 0.77139 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.94544 * frame.width, frame.minY + 0.46533 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.72267 * frame.width, frame.minY + 0.08772 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.94472 * frame.width, frame.minY + 0.18661 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.84478 * frame.width, frame.minY + 0.08772 * frame.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor.setFill()
        bezierPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //Size 1 x 1
    public class func commentIcon(size size: CGSize, color fillColor: UIColor!) -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        //PaintCode here
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.85714 * frame.width, frame.minY + 0.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.14286 * frame.width, frame.minY + 0.00000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.14286 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.06429 * frame.width, frame.minY + 0.00000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.06429 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.64286 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.14286 * frame.width, frame.minY + 0.78571 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.72143 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.06429 * frame.width, frame.minY + 0.78571 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.21429 * frame.width, frame.minY + 0.78571 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.21429 * frame.width, frame.minY + 0.92857 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.28571 * frame.width, frame.minY + 1.00000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.21429 * frame.width, frame.minY + 0.97543 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.25500 * frame.width, frame.minY + 1.00000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.35714 * frame.width, frame.minY + 0.96314 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.31086 * frame.width, frame.minY + 1.00000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.32479 * frame.width, frame.minY + 0.99164 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.57143 * frame.width, frame.minY + 0.78571 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.85714 * frame.width, frame.minY + 0.78571 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.64286 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.93571 * frame.width, frame.minY + 0.78571 * frame.height), controlPoint2: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.72143 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.14286 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.85714 * frame.width, frame.minY + 0.00000 * frame.height), controlPoint1: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.06429 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.93571 * frame.width, frame.minY + 0.00000 * frame.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor.setFill()
        bezierPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
	
	//size 13x13
	public class func cancelIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
        let bounds: CGRect = frame
        
        //// cross Drawing
        let crossPath = UIBezierPath()
        crossPath.moveToPoint(CGPointMake(bounds.minX + 0.97466 * bounds.width, bounds.minY + 0.85227 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.97466 * bounds.width, bounds.minY + 0.97465 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 1.00845 * bounds.width, bounds.minY + 0.88606 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 1.00845 * bounds.width, bounds.minY + 0.94087 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.91347 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.95775 * bounds.width, bounds.minY + 0.99156 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.93562 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.85227 * bounds.width, bounds.minY + 0.97465 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.89131 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.86918 * bounds.width, bounds.minY + 0.99156 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.50000 * bounds.width, bounds.minY + 0.62238 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.14773 * bounds.width, bounds.minY + 0.97465 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.08653 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.13082 * bounds.width, bounds.minY + 0.99156 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.10869 * bounds.width, bounds.minY + 1.00000 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.02534 * bounds.width, bounds.minY + 0.97465 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.06438 * bounds.width, bounds.minY + 1.00000 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.04225 * bounds.width, bounds.minY + 0.99156 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.02534 * bounds.width, bounds.minY + 0.85227 * bounds.height), controlPoint1: CGPointMake(bounds.minX + -0.00845 * bounds.width, bounds.minY + 0.94087 * bounds.height), controlPoint2: CGPointMake(bounds.minX + -0.00845 * bounds.width, bounds.minY + 0.88606 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.37761 * bounds.width, bounds.minY + 0.50000 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.02534 * bounds.width, bounds.minY + 0.14773 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.02534 * bounds.width, bounds.minY + 0.02534 * bounds.height), controlPoint1: CGPointMake(bounds.minX + -0.00845 * bounds.width, bounds.minY + 0.11394 * bounds.height), controlPoint2: CGPointMake(bounds.minX + -0.00845 * bounds.width, bounds.minY + 0.05913 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.14773 * bounds.width, bounds.minY + 0.02534 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.05915 * bounds.width, bounds.minY + -0.00845 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.11392 * bounds.width, bounds.minY + -0.00845 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.50000 * bounds.width, bounds.minY + 0.37761 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.85227 * bounds.width, bounds.minY + 0.02534 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.97466 * bounds.width, bounds.minY + 0.02534 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 0.88608 * bounds.width, bounds.minY + -0.00845 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 0.94085 * bounds.width, bounds.minY + -0.00845 * bounds.height))
        crossPath.addCurveToPoint(CGPointMake(bounds.minX + 0.97466 * bounds.width, bounds.minY + 0.14773 * bounds.height), controlPoint1: CGPointMake(bounds.minX + 1.00845 * bounds.width, bounds.minY + 0.05913 * bounds.height), controlPoint2: CGPointMake(bounds.minX + 1.00845 * bounds.width, bounds.minY + 0.11394 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.62239 * bounds.width, bounds.minY + 0.50000 * bounds.height))
        crossPath.addLineToPoint(CGPointMake(bounds.minX + 0.97466 * bounds.width, bounds.minY + 0.85227 * bounds.height))
        crossPath.closePath()
        crossPath.miterLimit = 4;
        
        crossPath.usesEvenOddFillRule = true;
        fillColor.setFill()
        crossPath.fill()

		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
	//35x27
	public class func tickIcon(size size: CGSize, color fillColor : UIColor!) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		
		//PaintCode here
		//// Bezier 59 Drawing
		let bezier59Path = UIBezierPath()
		bezier59Path.moveToPoint(CGPointMake(frame.minX + 0.95481 * frame.width, frame.minY + 0.06316 * frame.height))
		bezier59Path.addLineToPoint(CGPointMake(frame.minX + 0.41961 * frame.width, frame.minY + 0.91150 * frame.height))
		bezier59Path.addLineToPoint(CGPointMake(frame.minX + 0.05376 * frame.width, frame.minY + 0.44184 * frame.height))
		bezier59Path.lineCapStyle = .Round;
		bezier59Path.lineJoinStyle = .Round;
		fillColor.setStroke()
		bezier59Path.miterLimit = 4
		bezier59Path.stroke()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return image
	}
	
}