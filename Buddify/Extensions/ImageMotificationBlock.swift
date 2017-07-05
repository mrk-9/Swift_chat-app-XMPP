//
//  ImageMotificationBlock.swift
//  Buddify
//
//  Created by Vo Duc Tung on 21/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import AsyncDisplayKit

func roundedImageMotificationBlock() -> asimagenode_modification_block_t {
    return { (image: UIImage) in
        var newImage: UIImage?
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.mainScreen().scale)
        UIBezierPath(roundedRect: rect, cornerRadius: image.size.width / 2).addClip()
        image.drawInRect(rect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}