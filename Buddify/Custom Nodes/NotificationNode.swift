//
//  NotificationNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 11/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

private let kContentHorizontalInset: CGFloat = 7.5
private let kContentVerticalInset: CGFloat = 7.5

private let profileImageNodeWidth: CGFloat = 30
private let profileImageNodeHeight: CGFloat = 30

private let thumbnailImageNodeWidth: CGFloat = 40
private let thumbnailImageNodeHeight: CGFloat = 40

private let kHorizontalContentSpacing: CGFloat = 10
private let kLinkAttributeName = "LinkAttributeName"

@objc protocol NotificationNodeDelegate: NSObjectProtocol {
    func notificationNodeProfilePhotoTapped(node: NotificationNode)
    func notificationNodeThumbnailImageViewTapped(node: NotificationNode)
}

class NotificationNode: ASCellNode, ASTextNodeDelegate {
    weak var delegate: NotificationNodeDelegate?
    
    private let _labelNode = ASTextNode()
    private let _profileImageNode = ASNetworkImageNode()
    private var _thumbnailImageNode: ASNetworkImageNode?
    private weak var _notification: Notification?
    
    init(notification: Notification) {
        super.init()
        _notification = notification
        
        _labelNode.delegate = self
        _labelNode.userInteractionEnabled = true
        _labelNode.highlightStyle = ASTextNodeHighlightStyle.Light
        _labelNode.linkAttributeNames = [kLinkAttributeName]
        self.addSubnode(_labelNode)
        
        _profileImageNode.addTarget(self, action: #selector(NotificationNode.profileImageNodeTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.cornerRadius = profileImageNodeWidth/2
        self.addSubnode(_profileImageNode)
        _profileImageNode.preferredFrameSize = CGSize(width: profileImageNodeWidth, height: profileImageNodeHeight)
        _profileImageNode.imageModificationBlock = { (image: UIImage) in
            var newImage: UIImage?
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.mainScreen().scale)
            UIBezierPath(roundedRect: rect, cornerRadius: image.size.width / 2).addClip()
            image.drawInRect(rect)
            newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = .None
        self.setInfo(notification)
    }
    
    override func didLoad() {
        super.didLoad()
        self.layer.as_allowsHighlightDrawing = true
    }
    
    private func setInfo(notification: Notification?) {
        if let _notification = notification {
            let timeString = NSAttributedString.attributedStringFromFont(" " + _notification.createdAt.toDefaultRelativeString(), font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
            let mutableString = NSMutableAttributedString(string: _notification.user.name + " " + _notification.message, attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.appFont(CGFloat.normalFontSize)])
            mutableString.appendAttributedString(timeString)
            let url = NSURL(string: "https://www.google.com")
            mutableString.addAttributes([
                NSFontAttributeName: UIFont.boldAppFont(CGFloat.normalFontSize),
                NSForegroundColorAttributeName: UIColor.appPurpleColor(),
                NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleNone.rawValue,
                kLinkAttributeName: url!
                ], range: NSMakeRange(0, _notification.user.name.characters.count))
            
            _labelNode.attributedString = mutableString
            
            _profileImageNode.URL = NSURL(string: _notification.user.profilePhoto)
            
            if let _thumbnail = _notification.post?.thumbnailPhotos?[0] {
                _thumbnailImageNode = ASNetworkImageNode()
                _thumbnailImageNode?.preferredFrameSize = CGSize(width: thumbnailImageNodeWidth, height: thumbnailImageNodeHeight)
                _thumbnailImageNode?.URL = NSURL(string: _thumbnail)
                _thumbnailImageNode?.backgroundColor = UIColor.photoPlaceHolderColor()
                _thumbnailImageNode?.addTarget(self, action: #selector(NotificationNode.thumbnailImageViewTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
                self.addSubnode(_thumbnailImageNode!)
            }
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        _labelNode.flexShrink = true
        _labelNode.flexGrow = true
        
        //All nodes have at least profile image node and label node
        var children : [ASLayoutable] = [_profileImageNode, _labelNode]
        
        
        if let thumb = _thumbnailImageNode {
            children.append(thumb)
        }
        
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kHorizontalContentSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: children)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: kContentVerticalInset, left: kContentHorizontalInset, bottom: kContentVerticalInset, right: kContentHorizontalInset), child: horizontalStack)
    }
    
    //MARK: Action methods
    internal func profileImageNodeTapped() {
        delegate?.notificationNodeProfilePhotoTapped(self)
    }
    
    internal func thumbnailImageViewTapped() {
        delegate?.notificationNodeThumbnailImageViewTapped(self)
    }
    
    //MARK: ASTextNodeDelegate
    func textNode(textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(textNode: ASTextNode, tappedLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint, textRange: NSRange) {
        delegate?.notificationNodeProfilePhotoTapped(self)
    }
}

class NotificationPlaceHolderNode: ASCellNode {
    private let _line1 = ASDisplayNode()
    private let _line2 = ASDisplayNode()
    private let _profileImageNode = ASDisplayNode()
    private let _thumbnailPhotoNode = ASDisplayNode()
    
    override init() {
        super.init()
        self.addSubnode(_line1)
        self.addSubnode(_line2)
        self.addSubnode(_profileImageNode)
        self.addSubnode(_thumbnailPhotoNode)
        self.selectionStyle = .None
        
        _line1.backgroundColor = UIColor.placeholerShimmingColor()
        _line2.backgroundColor = UIColor.placeholerShimmingColor()
        _profileImageNode.backgroundColor = UIColor.placeholerShimmingColor()
        _profileImageNode.cornerRadius = profileImageNodeWidth/2
        _thumbnailPhotoNode.backgroundColor = UIColor.placeholerShimmingColor()
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.alignSelf = .Stretch
        self.preferredFrameSize = constrainedSize.max
        
        let width = constrainedSize.max.width
        let lineWidth = width - kHorizontalContentSpacing*2 - kContentHorizontalInset*2 - profileImageNodeWidth - thumbnailImageNodeWidth
        let lineHeight: CGFloat = 10
        
        _line1.preferredFrameSize = CGSize(width: lineWidth, height: lineHeight)
        _line2.preferredFrameSize = CGSize(width: lineWidth - 80, height: lineHeight)
        //line3.preferredFrameSize = CGSize(width: lineWidth, height: lineHeight)
        _profileImageNode.preferredFrameSize = CGSize(width: profileImageNodeWidth, height: profileImageNodeHeight)
        _thumbnailPhotoNode.preferredFrameSize = CGSize(width: thumbnailImageNodeWidth, height: thumbnailImageNodeHeight)
        
        let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 10, justifyContent: ASStackLayoutJustifyContent.SpaceAround, alignItems: ASStackLayoutAlignItems.Start, children: [_line1, _line2])
        verticalStack.flexGrow = true
        
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kHorizontalContentSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_profileImageNode, verticalStack, _thumbnailPhotoNode])
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: kContentHorizontalInset, bottom: 10, right: kContentHorizontalInset), child: horizontalStack)
        
        return insetSpec
    }
    
    override func layout() {
        super.layout()
        self.addShimmerToSubview(_line1.view)
        self.addShimmerToSubview(_line2.view)
        self.addShimmerToSubview(_profileImageNode.view)
        self.addShimmerToSubview(_thumbnailPhotoNode.view)
    }
}
