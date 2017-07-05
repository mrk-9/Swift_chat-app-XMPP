//
//  SinglePostNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 11/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

//MARK: SinglePostNode

//Size of like button and profile image
private let kProfileImageNodeSize: CGFloat = 40
private let kLikeButtonSize: CGFloat = 40

private let kLeftSpacing: CGFloat = 10
private let kRightSpacing: CGFloat = 10
private let kVerticalSpacing: CGFloat = 10

//Definition of SinglePostNodeDelegate
protocol SinglePostNodeDelegate: NSObjectProtocol {
    func singlePostNodeLikeButtonTapped(button: ASButtonNode, node: SinglePostNode)
    func singlePostNodeLikeNumberButtonTapped(node: SinglePostNode)
    func singlePostNodeCommentNumberButtonTapped(node: SinglePostNode)
	func singlePostNodeCommentButtonTapped(node: SinglePostNode)
    func singlePostNodeProfileImageViewTapped(node: SinglePostNode)
    func singlePostNodeImageViewTapped(node: SinglePostNode)
}

///
/// Post node displayed in Feed and Single post view
///
class SinglePostNode: ASCellNode, ASNetworkImageNodeDelegate {
	//public vars
    var nodeDelegate: SinglePostNodeDelegate?

	//private vars
    private var _post: Post? {
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
    private let _postPhotoNode = ASNetworkImageNode()
    
    var postPhotoNode: ASNetworkImageNode {
        return _postPhotoNode
    }
    
    private let _profileImageNode = ASNetworkImageNode()
    private let _nameLabel = ASTextNode()
    private let _statusLabel = ASTextNode()
    private let _timeButton = ASButtonNode()
    private let _likeButton = ASHighLightButton()
    private let _likeNumberButton = ASHighLightButton()
	private let _commentNumberButton = ASHighLightButton()
	private let _commentButton = ASHighLightButton()
	
	//Designated init cell node with post
    init(post: Post) {
        super.init()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        _post = post
		
		// Profile image node init
        _profileImageNode.userInteractionEnabled = true
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.preferredFrameSize = CGSize(width: kProfileImageNodeSize, height: kProfileImageNodeSize)
        _profileImageNode.cornerRadius = kProfileImageNodeSize/2
        _profileImageNode.addTarget(self, action: #selector(SinglePostNode.profileImageViewTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        _profileImageNode.imageModificationBlock = roundedImageMotificationBlock()
		
		// Username text node init
        _nameLabel.userInteractionEnabled = true
        _nameLabel.addTarget(self, action: #selector(SinglePostNode.profileImageViewTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		
		// Post photo image node init
        _postPhotoNode.backgroundColor = UIColor.photoPlaceHolderColor()
        
        //_postPhotoNode.userInteractionEnabled = true
        _postPhotoNode.addTarget(self, action: #selector(SinglePostNode.postPhotoTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        _postPhotoNode.delegate = self
		
        //_postPhotoNode.borderColor = UIColor.appGrayColor().CGColor
		//_postPhotoNode.borderWidth = 5
		_postPhotoNode.clipsToBounds = true
        if let photo = post.photo {
            _postPhotoNode.URL = NSURL(string: photo)
        }
        else {
            _postPhotoNode.URL = nil
        }
        
        if let photo = post.owner?.photoThumbnails?[0] {
            _profileImageNode.URL = NSURL(string: photo)
        }
        else {
            _profileImageNode.URL = nil
        }
		
		// Status label node init
		_statusLabel.layerBacked = true
		
		// Time of post button node init
        _timeButton.userInteractionEnabled = true
        _timeButton.setTitle(post.createdAt?.toDefaultString() ?? "Just now", withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appLightTextColor(), forState: ASControlState.Normal)
        //timeButton.addTarget(self, action: Selector("timeButtonTapped"), forControlEvents: ASControlNodeEvent.TouchUpInside)
		
		// Like button node init
        _likeButton.userInteractionEnabled = true
		_likeButton.cornerRadius = kLikeButtonSize/2
		_likeButton.backgroundImageNode.cornerRadius = kLikeButtonSize/2
        _likeButton.selected = post.liked
        
		// Set button background image and image for states
		_likeButton.setBackgroundImage(UIImage.image(UIColor.whiteColor()), forState: ASControlState.Normal)
		_likeButton.setBackgroundImage(UIImage.image(UIColor.appPinkColor()), forState: ASControlState.Selected)
        _likeButton.setImage(UIImage.likeIconSolid(size: CGSize(width: 20, height: 20), color: UIColor.grayColor()), forState: ASControlState.Normal)
        _likeButton.setImage(UIImage.likeIconSolid(size: CGSize(width: 20, height: 20), color: UIColor.whiteColor()), forState: ASControlState.Selected)
        _likeButton.addTarget(self, action: #selector(SinglePostNode.likeButtonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
		
		// Like number button node with heart icon
        _likeNumberButton.userInteractionEnabled = true
        _likeNumberButton.setImage(UIImage.likeIconSolid(size: CGSize(width: 15, height: 15), color: UIColor.appPinkColor()), forState: ASControlState.Normal)
        _likeNumberButton.setTitle(String(post.numberOfLikes), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appLightTextColor(), forState: ASControlState.Normal)
        _likeNumberButton.contentHorizontalAlignment = ASHorizontalAlignment.AlignmentLeft
        _likeNumberButton.addTarget(self, action: #selector(SinglePostNode.likeNumberButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		
		// Comment number button node with comment icon
		_commentNumberButton.userInteractionEnabled = true
		_commentNumberButton.setImage(UIImage.commentIcon(size: CGSize(width: 15, height: 15), color: UIColor.appPurpleColor()), forState: ASControlState.Normal)
		_commentNumberButton.setTitle(String(post.numberOfComments), withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appLightTextColor(), forState: ASControlState.Normal)
		_commentNumberButton.contentHorizontalAlignment = ASHorizontalAlignment.AlignmentLeft
		_commentNumberButton.addTarget(self, action: #selector(SinglePostNode.commentNumberButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)

		// Comment button node
		_commentButton.userInteractionEnabled = true
        let iconSize: CGFloat = 15
        let spacingBetweenTitleAndImage: CGFloat = 10
        let title = "Comment"
        let titleWidth = title.widthInHeight(20, font: UIFont.appFont(15))
		_commentButton.setTitle(title, withFont: UIFont.appFont(15), withColor: UIColor.appLightTextColor(), forState: ASControlState.Normal)
        _commentButton.setImage(UIImage.newCommentIcon(size: CGSize(width: 15, height: 13), color: UIColor.appLightTextColor()), forState: ASControlState.Normal)
		_commentButton.contentHorizontalAlignment = ASHorizontalAlignment.AlignmentRight
		_commentButton.addTarget(self, action: #selector(SinglePostNode.commentButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        _commentButton.contentVerticalAlignment = ASVerticalAlignment.AlignmentBottom
		_commentButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth, bottom: 0, right: spacingBetweenTitleAndImage + iconSize) // 25 =
		_commentButton.contentSpacing = -titleWidth - spacingBetweenTitleAndImage - iconSize // 15 is the icon size, 10 is space between image and title
        
        if let caption = post.status {
            _statusLabel.attributedString = NSAttributedString.attributedStringFromFont(caption, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        }
        else {
            _statusLabel.attributedString = nil
        }
        
        if let name = post.owner?.name {
            _nameLabel.attributedString = NSAttributedString.attributedStringFromFont(name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        }
        
		self.backgroundColor = UIColor.whiteColor()
        self.addSubnode(_postPhotoNode)
        self.addSubnode(_profileImageNode)
        self.addSubnode(_nameLabel)
        self.addSubnode(_statusLabel)
        self.addSubnode(_timeButton)
        self.addSubnode(_likeButton)
        self.addSubnode(_likeNumberButton)
		self.addSubnode(_commentNumberButton)
		self.addSubnode(_commentButton)
        
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
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		self.alignSelf = .Stretch
        
        //Static size for profileImageNode & likeButton
		_profileImageNode.preferredFrameSize = CGSize(width: kProfileImageNodeSize, height: kProfileImageNodeSize) //ASRelativeSizeRange.init(width: kProfileImageNodeSize, height: kProfileImageNodeSize)
		_likeButton.sizeRange = ASRelativeSizeRange.init(width: kLikeButtonSize, height: kLikeButtonSize)
		
        //Vertical stack of name and time
        let nameAndTimeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [_nameLabel, _timeButton])
        nameAndTimeStack.flexGrow = true
		
        //Horiontal stack of nameAndTimeStack & Profile photo node & likeButton
        //profileImage--name+time stack--spacer--likeButton
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        let topStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kLeftSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_profileImageNode, nameAndTimeStack, spacer, ASStaticLayoutSpec(children: [_likeButton])])
        topStack.alignSelf = .Stretch

        //Like number button + comment number button + comment button
		_likeNumberButton.spacingAfter = kLeftSpacing
		let spacer1 = ASLayoutSpec()
		spacer1.flexGrow = true
		let likeAndCommentStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_likeNumberButton, _commentNumberButton, spacer1, _commentButton])
        likeAndCommentStack.alignSelf = .Stretch

        var children = [ASLayoutable]()
        
        let spacer2 = ASLayoutSpec()
        spacer2.flexGrow = true
        
        //Children of parent stack node
        if _post?.type == .Image {
            if let size = _post?.photoSize where size != CGSizeZero {
                DTLog("size = \(size)\n")
                _postPhotoNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width*(size.height/size.width))
            }
            else {
                _postPhotoNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width*0.7)
            }
            children.append(topStack)
			children.append(_statusLabel)
            children.append(_postPhotoNode)
            children.append(likeAndCommentStack)
        }
        else {
			children.append(topStack)
			children.append(_statusLabel)
			children.append(likeAndCommentStack)
        }
		
        //The parent stack node
        let postStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kVerticalSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: children)

        //Inset spec for everything
		let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: kVerticalSpacing, left: kLeftSpacing, bottom: kVerticalSpacing, right: kRightSpacing), child: postStack)
        insetSpec.sizeRange = ASRelativeSizeRange(size: constrainedSize.max)
        
        //If not creating node for table node, then return ASCenterLayoutSpec, otherwise return inset spec.
        if constrainedSize.max.height < 9999 {
            return ASStaticLayoutSpec(children: [insetSpec])
        }
        
        return insetSpec
    }
	
    override func layout() {
        super.layout()
        
        // Rounded corner
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 5
        
		let shadowPath = UIBezierPath(roundedRect: self._likeButton.bounds, cornerRadius: 20)
		self._likeButton.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.3).CGColor
		self._likeButton.shadowOffset = CGSizeMake(0,0)
		self._likeButton.shadowOpacity = 0.3
		self._likeButton.shadowRadius = 3
		self._likeButton.layer.shadowPath = shadowPath.CGPath
		self._likeButton.layer.masksToBounds = true
		self._likeButton.clipsToBounds = false
    }
    
    //MARK: Tap selectors
    func profileImageViewTapped() {
        nodeDelegate?.singlePostNodeProfileImageViewTapped(self)
    }
    
    func postPhotoTapped() {
        nodeDelegate?.singlePostNodeImageViewTapped(self)
    }
    
    func likeButtonTapped(button: ASButtonNode) {
        button.selected = !button.selected
        
        nodeDelegate?.singlePostNodeLikeButtonTapped(button, node: self)
    }
    
    func likeNumberButtonTapped() {
        nodeDelegate?.singlePostNodeLikeNumberButtonTapped(self)
    }
    
    func commentNumberButtonTapped() {
        nodeDelegate?.singlePostNodeCommentNumberButtonTapped(self)
    }
	func commentButtonTapped() {
		nodeDelegate?.singlePostNodeCommentButtonTapped(self)
	}
	
	// Class func to calculate node height
	class func nodeHeightWithWidth(width: CGFloat, post: Post) -> CGFloat {
		var captionHeight: CGFloat = 0
		
		let realWidth = width - kLeftSpacing - kRightSpacing
		
		// Calculate username text height
		let nameHeight: CGFloat = post.owner.name.heightInWidth(realWidth, font: UIFont.boldAppFont(15))
		
		// Calculate status text height
		if let caption = post.status {
			let attributedString = NSAttributedString.attributedStringFromFont(caption, font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.redColor(), textAlignment: nil)
			captionHeight = attributedString.heightInWidth(realWidth)
			
            //Prevent weird UI when caption is empty string
            if captionHeight < 15 {
                captionHeight = 15
            }
		}
		
		// Node height with status
		var height: CGFloat = kVerticalSpacing + max(kLikeButtonSize, kProfileImageNodeSize, nameHeight) + kVerticalSpacing + captionHeight + kVerticalSpacing + 15 + kVerticalSpacing
		
		// Add post photo height and spacing if post type of image
		if post.type == .Image {
            if post.photoSize != CGSizeZero {
                height += width * (post.photoSize.height / post.photoSize.width) + kVerticalSpacing
            }
            else {
                height += (width * 0.7 + kVerticalSpacing)
            }
		}
		
		return height
	}
    
    //MARK: ASNetworkImageNodeDelegate
    func imageNode(imageNode: ASNetworkImageNode, didLoadImage image: UIImage) {
//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.fromValue = NSNumber(float: 0)
//        animation.toValue = NSNumber(float: 1)
//        animation.duration = 0.5
//        _postPhotoNode.layer.addAnimation(animation, forKey: "")
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

