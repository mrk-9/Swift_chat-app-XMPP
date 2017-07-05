//
//  LocationNode.swift
//  Buddify
//
//  Created by Tung Vo  on 02/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit

private let kButtonHeight: CGFloat = 40
private let kHorizontalMargin: CGFloat = CGFloat.rightMargin
private let kVerticalMargin: CGFloat = 10

///
/// Protocol LocationNodeDelegate
///
protocol LocationNodeDelegate: NSObjectProtocol {
    func locationNodeButtonTapped(node: LocationNode)
}

///
/// Class LocationNode
///
class LocationNode: ASCellNode {
    ///
    /// Delegate
    ///
    weak var delegate: LocationNodeDelegate?
    
    private var _locationButton = ASHighLightButton()
    
    init(locationName: String) {
        super.init()
        
        self.selectionStyle = .None
        
        // Unblock button
        _locationButton.setTitle(locationName, withFont: UIFont.boldAppFont(CGFloat.normalFontSize), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
        _locationButton.setBackgroundImage(UIImage.image(UIColor.appPinkColor()), forState: ASControlState.Selected)
        _locationButton.setBackgroundImage(UIImage.image(UIColor.grayColor()), forState: ASControlState.Normal)
        _locationButton.addTarget(self, action: #selector(self.dynamicType.buttonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        self.addSubnode(_locationButton)
    }
    
    func buttonTapped(button: ASButtonNode) {
        delegate?.locationNodeButtonTapped(self)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width - kHorizontalMargin*2
        _locationButton.sizeRange = ASRelativeSizeRange(size: CGSize(width: width, height: kButtonHeight))
        
        let insetSpec1 = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: kHorizontalMargin, bottom: kVerticalMargin, right: kHorizontalMargin) , child: ASStaticLayoutSpec(children: [_locationButton]))
        
        return insetSpec1
    }
    
    override func layout() {
        super.layout()
        _locationButton.layer.cornerRadius = 5
        _locationButton.layer.masksToBounds = true
    }
    
    override var selected: Bool {
        didSet {
            print("\(selected)\n")
            _locationButton.selected = selected
        }
    }
}
