//
//  UserListNode.swift
//  Buddify
//
//  Created by Huy Le on 3/17/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import Models

private let kContentHorizontalInset: CGFloat = CGFloat.leftMargin
private let kContentVerticalInset: CGFloat = 10

private let kHorizontalContentSpacing: CGFloat = 10

private let profileImageNodeSize: CGFloat = 40

class UserListNode: ASCellNode {
    private let _profileImageNode = ASNetworkImageNode()
    private let _usernameLabelNode = ASTextNode()

    init(user: User) {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        
        //add username label
        self.addSubnode(_usernameLabelNode)
        _usernameLabelNode.attributedString = NSAttributedString.attributedStringFromFont(user.name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        
        //add profile image
        self.addSubnode(_profileImageNode)
        _profileImageNode.URL = NSURL(string: user.profilePhoto)
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
		_profileImageNode.preferredFrameSize = CGSize(width: profileImageNodeSize, height: profileImageNodeSize)
		_profileImageNode.cornerRadius = profileImageNodeSize/2
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
		

    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var children : [ASLayoutable] = [_profileImageNode, _usernameLabelNode]
		let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        children.append(spacer)
		
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kHorizontalContentSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: children)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: kContentVerticalInset, left: kContentHorizontalInset, bottom: kContentVerticalInset, right: kContentHorizontalInset), child: horizontalStack)
    }
    
    //MARK: Tap selectors
    func likeButtonTapped() {
        
    }
}

class UserListPlaceholderNode: ASCellNode {
    private let _profilePhotoNode = ASDisplayNode()
    private let _nameNode = ASDisplayNode()
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        
        _profilePhotoNode.backgroundColor = UIColor.placeholerShimmingColor()
        _nameNode.backgroundColor = UIColor.placeholerShimmingColor()
        _profilePhotoNode.cornerRadius = profileImageNodeSize/2
        
        self.addSubnode(_profilePhotoNode)
        self.addSubnode(_nameNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let children : [ASLayoutable] = [_profilePhotoNode, _nameNode]
        _profilePhotoNode.preferredFrameSize = CGSize(width: profileImageNodeSize, height: profileImageNodeSize)
        _nameNode.preferredFrameSize = CGSize(width: 200, height: 15)
        _nameNode.flexGrow = true
        
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kHorizontalContentSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: children)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: kContentVerticalInset, left: kContentHorizontalInset, bottom: kContentVerticalInset, right: kContentHorizontalInset), child: horizontalStack)
    }
    
    class func defaultHeight() -> CGFloat {
        return 60
    }
    
    override func layout() {
        super.layout()
        self.addShimmerToSubview(_profilePhotoNode.view)
        self.addShimmerToSubview(_nameNode.view)
    }
}