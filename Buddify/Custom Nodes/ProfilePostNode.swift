//
//  ProfilePostNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 13/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import AFDateHelper
import Models

protocol ProfilePostNodeDelegate: NSObjectProtocol {
    func timelineNodeLikeButtonTapped(button: ASButtonNode , node: ProfilePostNode)
    func timelineNodeLikeNumberButtonTapped(node: ProfilePostNode)
    func timelineNodeCommentNumberButtonTapped(node: ProfilePostNode)
    func timelineNodeProfileImageViewTapped(node: ProfilePostNode)
    func timelineNodeImageViewTapped(node: ProfilePostNode)
}

private let kLikeCommentNumberSpacing: CGFloat = 20
private let kVerticalSpacing: CGFloat = 5
private let kLeftSpacing: CGFloat = 10
private let kRightSpacing: CGFloat = 10

private let kProfileImageSize: CGFloat = 30
private let kLikeButtonSize: CGFloat = 40

private let kProfileImageNodeSize: CGFloat = 30
private let kVerticalSpacingAroundLikeButton: CGFloat = 20


///
/// Post node displayed in user profile
///
class ProfilePostNode: ASCellNode {
    var nodeDelegate: ProfilePostNodeDelegate?
    
    private let _profileImageNode = ASNetworkImageNode()
    private let _nameLabel = ASTextNode()
    private let _postPhotoNode = ASNetworkImageNode()
    
    var postPhotoNode: ASNetworkImageNode {
        return _postPhotoNode
    }
    private let _statusLabel = ASTextNode()
    private let _timeButton = ASHighLightButton()
    private let _likeButton = ASHighLightButton()
    private let _likeNumberButton = ASHighLightButton()
    private let _commentNumberButton = ASHighLightButton()
    
    private var _post : Post! {
        didSet {
            // Remove KVO from old object
            (oldValue as? NSObject)?.removeObserver(self, forKeyPath: "numberOfLikes")
            (oldValue as? NSObject)?.removeObserver(self, forKeyPath: "numberOfComments")
            (oldValue as? NSObject)?.removeObserver(self, forKeyPath: "liked")
            
            // Add KVO to new object
            (_post as? NSObject)?.addObserver(self, forKeyPath: "numberOfLikes", options: NSKeyValueObservingOptions.New, context: nil)
            (_post as? NSObject)?.addObserver(self, forKeyPath: "numberOfComments", options: NSKeyValueObservingOptions.New, context: nil)
            (_post as? NSObject)?.addObserver(self, forKeyPath: "liked", options: NSKeyValueObservingOptions.New, context: nil)
        }
    }
    
    init(post: Post) {
        super.init()
        
        // Retain reference
        _post = post
        
        _profileImageNode.userInteractionEnabled = true
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.cornerRadius = kProfileImageSize/2
        _profileImageNode.borderColor = UIColor.whiteColor().CGColor
        _profileImageNode.borderWidth = 2
        _profileImageNode.addTarget(self, action: #selector(ProfilePostNode.profileImageViewTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
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
        
        _nameLabel.userInteractionEnabled = true
        _nameLabel.addTarget(self, action: #selector(ProfilePostNode.profileImageViewTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        _postPhotoNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _postPhotoNode.userInteractionEnabled = true
        _postPhotoNode.addTarget(self, action: #selector(ProfilePostNode.postPhotoTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        
        //toString(dateStyle: .ShortStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
        _timeButton.userInteractionEnabled = true
        _timeButton.setTitle(post.createdAt!.toDefaultString(), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appLightTextColor(), forState: ASControlState.Normal)
        
        _likeButton.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        _likeButton.selected = post.liked
        _likeButton.userInteractionEnabled = true
        _likeButton.cornerRadius = kLikeButtonSize/2
        _likeButton.borderColor = UIColor.whiteColor().CGColor
        _likeButton.borderWidth = 2
        _likeButton.setImage(UIImage.likeIconLine(size: CGSize(width: 20, height: 20), color: UIColor.appPinkColor()), forState: ASControlState.Normal)
        _likeButton.setImage(UIImage.likeIconSolid(size: CGSize(width: 20, height: 20), color: UIColor.appPinkColor()), forState: ASControlState.Selected)
        _likeButton.addTarget(self, action: #selector(ProfilePostNode.likeButtonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        let color = UIColor.appLightTextColor()
        
        _likeNumberButton.userInteractionEnabled = true
        _likeNumberButton.setImage(UIImage.likeIconSolid(size: CGSize(width: 12, height: 12), color: color), forState: ASControlState.Normal)
        _likeNumberButton.setTitle(String(post.numberOfLikes), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: color, forState: ASControlState.Normal)
        _likeNumberButton.addTarget(self, action: #selector(ProfilePostNode.likeNumberButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        _commentNumberButton.setImage(UIImage.commentIcon(size: CGSize(width: 12, height: 12), color: color), forState: ASControlState.Normal)
        _commentNumberButton.userInteractionEnabled = true
        _commentNumberButton.addTarget(self, action: #selector(ProfilePostNode.commentNumberButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubnode(_postPhotoNode)
        self.addSubnode(_profileImageNode)
        self.addSubnode(_nameLabel)
        self.addSubnode(_statusLabel)
        self.addSubnode(_timeButton)
        self.addSubnode(_likeButton)
        self.addSubnode(_likeNumberButton)
        self.addSubnode(_commentNumberButton)
        
        self.setInfo(post)
        
        // Add KVO to post
        (post as? NSObject)?.addObserver(self, forKeyPath: "numberOfLikes", options: NSKeyValueObservingOptions.New, context: nil)
        (post as? NSObject)?.addObserver(self, forKeyPath: "numberOfComments", options: NSKeyValueObservingOptions.New, context: nil)
        (post as? NSObject)?.addObserver(self, forKeyPath: "liked", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    deinit {
        // Remove KVO
        (_post as? NSObject)?.removeObserver(self, forKeyPath: "numberOfLikes")
        (_post as? NSObject)?.removeObserver(self, forKeyPath: "numberOfComments")
        (_post as? NSObject)?.removeObserver(self, forKeyPath: "liked")
    }
    
    private func setInfo(post: Post?) {
        guard let info = post else {
            return
        }
        
        self.setLikesCount(info.numberOfLikes)
        self.setCommentsCount(info.numberOfComments)
        
        if let photo = info.owner?.profilePhoto {
            _profileImageNode.URL = NSURL(string: photo)
        }
        else {
            _profileImageNode.URL = nil
        }
        
        
        if let caption = info.status {
            _statusLabel.attributedString = NSAttributedString.attributedStringFromFont(caption, font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        }
        else {
            _statusLabel.attributedString = nil
        }
        
        if let photo = info.photo {
            _postPhotoNode.URL = NSURL(string: photo)
        }
        else {
            _postPhotoNode.URL = nil
        }
        
        if let name = info.owner?.name {
            _nameLabel.attributedString = NSAttributedString.attributedStringFromFont(name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        }
    }
    
    private func setLikesCount(count: Int) {
        guard let info = _post else {
            return
        }
        let color = UIColor.appLightTextColor()
        _likeNumberButton.setTitle(String(info.numberOfLikes), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: color, forState: ASControlState.Normal)
    }
    
    private func setCommentsCount(count: Int) {
        guard let info = _post else {
            return
        }
        
        let color = UIColor.appLightTextColor()
        _commentNumberButton.setTitle(String(info.numberOfComments), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: color, forState: ASControlState.Normal)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.alignSelf = .Stretch
        
        _profileImageNode.sizeRange = ASRelativeSizeRange.init(width: kProfileImageSize, height: kProfileImageSize)
        
        _likeButton.sizeRange = ASRelativeSizeRange.init(width: kLikeButtonSize, height: kLikeButtonSize)
        
        let horizontalSpacer1 = ASLayoutSpec()
        horizontalSpacer1.flexGrow = true
        
        //Stack of profile image & like button
        let firstHorizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [ASStaticLayoutSpec(children: [_profileImageNode]), horizontalSpacer1, ASStaticLayoutSpec(children: [_likeButton])])
        firstHorizontalStack.flexGrow = true
        firstHorizontalStack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width - kLeftSpacing - kRightSpacing, height: max(kLikeButtonSize, kProfileImageSize))
        
        //Vertical stack of profile image & button, name, caption, timelabel
        let firstVerticalSpacer = ASLayoutSpec()
        firstVerticalSpacer.flexGrow = true
        
        //Like & Comment stack
        let secondHorizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_likeNumberButton, _commentNumberButton])
        
        var children : [ASLayoutable]
        
        if _post?.type == .Image {
            let verticalSpacer = ASLayoutSpec()
            verticalSpacer.spacingBefore = 0
            // Spacing after is height of the photo
            if _post.photoSize != CGSizeZero {
                verticalSpacer.spacingAfter = constrainedSize.max.width * (_post.photoSize.height / _post.photoSize.width) - max(kLikeButtonSize, kProfileImageSize)/2 - kVerticalSpacing*2
            }
            else {
                verticalSpacer.spacingAfter = constrainedSize.max.width - max(kLikeButtonSize, kProfileImageSize)/2 - kVerticalSpacing*2
            }
            
            children = [verticalSpacer, ASStaticLayoutSpec(children: [firstHorizontalStack]), _nameLabel, _statusLabel, firstVerticalSpacer, secondHorizontalStack, _timeButton]
        }
        else {
            children = [ASStaticLayoutSpec(children: [firstHorizontalStack]), _nameLabel, _statusLabel, firstVerticalSpacer, secondHorizontalStack, _timeButton]
        }
        
        let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kVerticalSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: children)
        
        let layoutInsets = UIEdgeInsets(top: kVerticalSpacing, left: kLeftSpacing, bottom: kVerticalSpacing, right: kRightSpacing)
        
        verticalStack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width - kRightSpacing - kLeftSpacing, height: constrainedSize.max.height - verticalStack.spacingBefore - 2*kVerticalSpacing)
        
        return ASInsetLayoutSpec(insets: layoutInsets, child: ASStaticLayoutSpec(children: [verticalStack]))
    }
    
    override func layout() {
        super.layout()
        
        // Rounded corner
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 5
        
        // Set frame of post image view based on the size detail from the post
        if _post?.type == .Image {
            if _post.photoSize != CGSizeZero {
                _postPhotoNode.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.frame.size.width, height: self.frame.size.width * (_post.photoSize.height / _post.photoSize.width)))
            }
            else {
                _postPhotoNode.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.frame.size.width, height: self.frame.size.width))
            }
        }
    }
    
    //MARK: Tap selectors
    func profileImageViewTapped() {
        nodeDelegate?.timelineNodeProfileImageViewTapped(self)
    }
    
    func postPhotoTapped() {
        nodeDelegate?.timelineNodeImageViewTapped(self)
    }
    
    func likeButtonTapped(button: ASButtonNode) {
        button.selected = !button.selected
        
        nodeDelegate?.timelineNodeLikeButtonTapped(button, node: self)
    }
    
    func likeNumberButtonTapped() {
        nodeDelegate?.timelineNodeLikeNumberButtonTapped(self)
    }
    
    func commentNumberButtonTapped() {
        nodeDelegate?.timelineNodeCommentNumberButtonTapped(self)
    }
    
    class func nodeHeightWithWidth(width: CGFloat, post: Post) -> CGFloat {
        var captionHeight: CGFloat = 0
        
        let realWidth = width - kLeftSpacing - kRightSpacing
        
        let nameHeight: CGFloat = post.owner.name.heightInWidth(realWidth, font: UIFont.boldAppFont(CGFloat.normalFontSize))
        
        if let caption = post.status {
            let attributedString = NSAttributedString.attributedStringFromFont(caption, font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.redColor(), textAlignment: nil)
            captionHeight = attributedString.heightInWidth(realWidth)
            
            // One more thing, don't know why need to have these lines
            if captionHeight < CGFloat.smallFontSize {
               captionHeight = CGFloat.smallFontSize
            }
            
        }
        var height: CGFloat = max(kLikeButtonSize, kProfileImageNodeSize) + kVerticalSpacing + nameHeight + kVerticalSpacing + captionHeight + kVerticalSpacing + 12 + kVerticalSpacing + 12 + kVerticalSpacing + 20 //I have no idea where this value comes from, just calculated by hand
        if post.type == .Image {
            if post.photoSize != CGSizeZero {
                height += width * (post.photoSize.height / post.photoSize.width)
            }
            else {
                height += width
            }
            
            height -= max(kLikeButtonSize, kProfileImageNodeSize)/2
        }
        
        return height
    }
    
    //MARK: KVO for post
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object === _post {
            guard let post = _post else {
                return
            }
            
            if keyPath == "liked" {
                _likeButton.selected = post.liked
            }
            else if keyPath == "numberOfLikes" {
                _likeNumberButton.setTitle(String(post.numberOfLikes), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appLightTextColor(), forState: ASControlState.Normal)
            }
            else if keyPath == "numberOfComments" {
                _commentNumberButton.setTitle(String(post.numberOfComments), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appLightTextColor(), forState: ASControlState.Normal)
            }
        }
    }
}

private let numberOfLines = 4
private let lineSpacing: CGFloat = 10

class TimelinePlaceHolderNode: ASCellNode {
    private let _profilePhotoNode = ASDisplayNode()
    private let _nameNode = ASDisplayNode()
    
    private var _lineNodes = [ASDisplayNode]()
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.whiteColor()
        
        _profilePhotoNode.backgroundColor = UIColor.placeholerShimmingColor()
        _nameNode.backgroundColor = UIColor.placeholerShimmingColor()
        self.addSubnode(_profilePhotoNode)
        self.addSubnode(_nameNode)
        
        for _ in 0..<numberOfLines {
            let line = ASDisplayNode()
            line.backgroundColor = UIColor.placeholerShimmingColor()
            _lineNodes.append(line)
            self.addSubnode(line)
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.alignSelf = .Stretch
        
        _profilePhotoNode.preferredFrameSize = CGSize(width: kProfileImageSize, height: kProfileImageSize)
        _nameNode.preferredFrameSize = CGSize(width: constrainedSize.max.width - kLeftSpacing - kRightSpacing - 70, height: 10)
        
        for line in _lineNodes {
            line.preferredFrameSize = CGSize(width: constrainedSize.max.width - kLeftSpacing - kRightSpacing, height: 10)
        }
        
        _profilePhotoNode.spacingAfter = 10
        _nameNode.spacingAfter = 5
        var children = [_profilePhotoNode, _nameNode]
        children = children + _lineNodes
        
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: lineSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: children)
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: kLeftSpacing, bottom: 10, right: kRightSpacing), child: stack)
        return ASCenterLayoutSpec(centeringOptions: ASCenterLayoutSpecCenteringOptions.X, sizingOptions: ASCenterLayoutSpecSizingOptions.Default, child: insetSpec)
    }
    
    class func defaultHeight() -> CGFloat {
        //Top space + profile photo + spacingAfter + name + spacingAfter + numberOfLines*line height + spacing*(numberOfLines -1) + bottom space + 50 pixel space
        return 10 + kProfileImageSize + 15 + 10 + 10 + CGFloat(numberOfLines)*10 + lineSpacing*CGFloat(numberOfLines - 1) + 10 + 50
    }
    
    override func layout() {
        super.layout()
        self.addShimmerToSubview(_profilePhotoNode.view)
        self.addShimmerToSubview(_nameNode.view)
        
        for line in _lineNodes {
            self.addShimmerToSubview(line.view)
        }
    }
}