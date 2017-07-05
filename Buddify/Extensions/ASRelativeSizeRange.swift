//
//  ASRelativeSizeRange.swift
//  Buddify
//
//  Created by Vo Duc Tung on 16/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit

extension ASRelativeSizeRange {
    init(size: CGSize) {
        self.init(width: size.width, height: size.height)
    }
    
    init(width: CGFloat, height: CGFloat) {
        let relativeSize = ASRelativeSize(width: ASRelativeDimension(type: ASRelativeDimensionType.Points, value: width), height: ASRelativeDimension(type: ASRelativeDimensionType.Points, value: height))
        self.init(min: relativeSize, max: relativeSize)
    }
    
    init(minWidth: CGFloat, minHeight: CGFloat, maxWidth: CGFloat, maxHeight: CGFloat) {
        let minRelativeSize = ASRelativeSize(width: ASRelativeDimension(type: ASRelativeDimensionType.Points, value: minWidth), height: ASRelativeDimension(type: ASRelativeDimensionType.Points, value: minHeight))
        let maxRelativeSize = ASRelativeSize(width: ASRelativeDimension(type: ASRelativeDimensionType.Points, value: maxWidth), height: ASRelativeDimension(type: ASRelativeDimensionType.Points, value: maxHeight))
        self.init(min: minRelativeSize, max: maxRelativeSize)
    }
}