//
//  UIImage.swift
//  Buddify
//
//  Created by Vo Duc Tung on 12/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        let rect = CGRect(origin: CGPointZero, size: size)
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func image(color: UIColor) -> UIImage {
        return UIImage.imageWithColor(color, size: CGSize(width: 1, height: 1))
    }
    
    class func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}