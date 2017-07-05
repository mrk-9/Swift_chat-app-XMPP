//
//  CommentNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 15/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import Models

private let kProfilePhotoSize: CGFloat = 30
private let kPhotoLabelSpacing: CGFloat = 10
private let kVerticalInset: CGFloat = 10
private let kHorizontalInset: CGFloat = 10

protocol CommentNodeDelegate: NSObjectProtocol {
    func commentNodeGoToUserProfileWithNode(node: CommentNode)
}

private let kLinkAttributeName = "DTLinkAttributeName"

class CommentNode: ASCellNode, ASTextNodeDelegate {
    weak var delegate: CommentNodeDelegate?
    
    private let _timeLabel = ASTextNode()
    private let _commentLabel = ASTextNode()
    private let _profilePhotoNode = ASNetworkImageNode()

    init(comment: BDFComment) {
        super.init()
    
        _commentLabel.linkAttributeNames = [kLinkAttributeName]
        _commentLabel.delegate = self

        _profilePhotoNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profilePhotoNode.cornerRadius = kProfilePhotoSize/2
        _profilePhotoNode.imageModificationBlock = roundedImageMotificationBlock()
        _profilePhotoNode.addTarget(self, action: #selector(CommentNode.goToUserProfileWithNode), forControlEvents: ASControlNodeEvent.TouchUpInside)
    
        self.addSubnode(_timeLabel)
        self.addSubnode(_commentLabel)
        self.addSubnode(_profilePhotoNode)
        self.setInfo(comment)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func didLoad() {
        self.layer.as_allowsHighlightDrawing = true
        super.didLoad()
    }
    
    func setInfo(comment: BDFComment) {
        let linkURL = NSURL(string: "https://www.google.com")
        let mutableString = NSMutableAttributedString(attributedString: NSAttributedString.attributedStringFromFont(comment.commentor.name + " ", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil))
         mutableString.appendAttributedString(NSAttributedString.attributedStringFromFont(comment.comment, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil))
        mutableString.addAttributes([
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleNone.rawValue,
            kLinkAttributeName: linkURL!
            ], range: NSMakeRange(0, comment.commentor.name.characters.count))
        
        _commentLabel.attributedString = mutableString
        _commentLabel.highlightStyle = ASTextNodeHighlightStyle.Light
        _commentLabel.userInteractionEnabled = true
        
        let url = comment.commentor.profilePhoto
        _profilePhotoNode.URL = NSURL(string: url)
        
        _timeLabel.attributedString = NSAttributedString.attributedStringFromFont(comment.createdAt.toDefaultRelativeString(), font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        _profilePhotoNode.spacingAfter = kPhotoLabelSpacing
        _commentLabel.flexShrink = true
        _profilePhotoNode.preferredFrameSize = CGSize(width: kProfilePhotoSize, height: kProfilePhotoSize)
        
        //First: profile photo + comment + timelabel on a same horizontal stack
        let commentAndTimeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [_commentLabel, _timeLabel])
        commentAndTimeStack.flexShrink = true
        
        //time label is at the end so we need to add a spacer
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_profilePhotoNode, commentAndTimeStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: kVerticalInset, left: kHorizontalInset, bottom: kVerticalInset, right: kHorizontalInset), child: horizontalStack)
    }
    
    //MARK: Action methods
    func goToUserProfileWithNode() {
        delegate?.commentNodeGoToUserProfileWithNode(self)
    }
    
    //MARK: ASTextNodeDelegate
    func textNode(textNode: ASTextNode, tappedLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint, textRange: NSRange) {
        delegate?.commentNodeGoToUserProfileWithNode(self)
    }
    
    func textNode(textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint) -> Bool {
        return true
    }
}
