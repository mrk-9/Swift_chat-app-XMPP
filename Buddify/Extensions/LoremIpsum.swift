//
//  LoremIpsum.swift
//  Buddify
//
//  Created by Vo Duc Tung on 20/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import LoremIpsum

extension LoremIpsum {
    class func photoURLWithSize(size: Int) -> String {
        let value = Int(arc4random() % 100) + size
        return LoremIpsum.URLForPlaceholderImageWithSize(CGSize(width: CGFloat(value), height: CGFloat(value))).absoluteString
    }
}
