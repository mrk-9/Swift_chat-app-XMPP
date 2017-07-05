//
//  OfferWallSupplementaryView.swift
//  Buddify
//
//  Created by Vo Duc Tung on 07/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit

class OfferWallSupplementaryView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commontInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commontInit()
    }
    
    private func commontInit() {
        let offerWallHeader = OfferWallHeader(frame: self.frame)
        self.addSubview(offerWallHeader)
    }
}

protocol AdBannderNodeDelegate: NSObjectProtocol {
    func adBannderNodeDidTapped()
}

class AdBannderNode4: ASCellNode {
	let imageNode1 = ASImageNode()
    let textNode1: ASTextNode = ASTextNode()
	let textNode2: ASTextNode = ASTextNode()
	let backgroundNode = ASDisplayNode()
	
    weak var delegate: AdBannderNodeDelegate?
    
    override init() {
        super.init()
		self.backgroundColor = UIColor(red: 236, green: 240, blue: 241)

		//text node
        textNode1.attributedString = NSAttributedString.attributedStringFromFont("DOWNLOAD APPS TO GET ", font: UIFont.appFont(10), textColor: UIColor.appPurpleColor(), textAlignment: NSTextAlignment.Center)
        textNode1.addTarget(self, action: #selector(AdBannderNode4.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
        self.addSubnode(textNode1)
		
		textNode2.attributedString = NSAttributedString.attributedStringFromFont("FREE DIAMONDS", font: UIFont.appFont(10), textColor: UIColor.appPinkColor(), textAlignment: NSTextAlignment.Center)
		textNode2.addTarget(self, action: #selector(AdBannderNode4.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(textNode2)
		
		//image node
		self.imageNode1.image = UIImage(named: "Iphone2")!
		self.imageNode1.addTarget(self, action: #selector(AdBannderNode4.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(imageNode1)
		
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		imageNode1.preferredFrameSize = CGSize(width: constrainedSize.max.width*0.35, height: constrainedSize.max.height)
		
		let textStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [ textNode1, textNode2])
		
		
		let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: -12, justifyContent: ASStackLayoutJustifyContent.End, alignItems: ASStackLayoutAlignItems.Center, children: [textStack, imageNode1])
		
        stack.alignSelf = .Stretch
        stack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height - 5)
        return ASStaticLayoutSpec(children: [stack])
    }
	
    internal func bannerTapped() {
        delegate?.adBannderNodeDidTapped()
    }
}

class AdBannderNode3: ASCellNode {
	let imageNode1 = ASImageNode()
	let imageNode2 = ASImageNode()
	var textNode1: ASTextNode = ASTextNode()
	var textNode2: ASTextNode = ASTextNode()
	
	weak var delegate: AdBannderNodeDelegate?
	
	override init() {
		super.init()
		self.backgroundColor = UIColor(red: 236, green: 240, blue: 241)
		
		//text node
		textNode1.attributedString = NSAttributedString.attributedStringFromFont("DOWNLOAD APPS TO GET ", font: UIFont.appFont(10), textColor: UIColor.appPurpleColor(), textAlignment: NSTextAlignment.Center)
		textNode1.addTarget(self, action: #selector(AdBannderNode3.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(textNode1)
		
		//textNode1.backgroundColor = UIColor.whiteColor()
		textNode2.attributedString = NSAttributedString.attributedStringFromFont("FREE DIAMONDS", font: UIFont.appFont(10), textColor: UIColor.appPinkColor(), textAlignment: NSTextAlignment.Center)
		textNode2.addTarget(self, action: #selector(AdBannderNode3.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(textNode2)
		
		//image node
		self.imageNode1.image = UIImage(named: "Iphone1")!
		self.imageNode1.addTarget(self, action: #selector(AdBannderNode3.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(imageNode1)
		
		self.imageNode2.image = UIImage(named: "DownloadIcon")!
		self.imageNode2.addTarget(self, action: #selector(AdBannderNode3.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(imageNode2)
		
	}
	
	override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		imageNode1.preferredFrameSize = CGSize(width: constrainedSize.max.width*0.25, height: constrainedSize.max.height)
		imageNode2.preferredFrameSize = CGSize(width: constrainedSize.max.width*0.1, height: constrainedSize.max.height)
		
		let textStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [ textNode1, textNode2])
		
		let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [ imageNode1, textStack, imageNode2])
		
		stack.alignSelf = .Stretch
		stack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height - 5)
		return ASStaticLayoutSpec(children: [stack])
	}
	
	internal func bannerTapped() {
		delegate?.adBannderNodeDidTapped()
	}
}

class AdBannderNode2: ASCellNode {
	let imageNode1 = ASImageNode()
	let imageNode2 = ASImageNode()
	let textNode1: ASTextNode = ASTextNode()
	let textNode2: ASTextNode = ASTextNode()
	
	weak var delegate: AdBannderNodeDelegate?
	
	override init() {
		super.init()
		self.backgroundColor = UIColor(red: 236, green: 240, blue: 241)
		
		//text node
		textNode1.attributedString = NSAttributedString.attributedStringFromFont("DOWNLOAD APPS TO GET ", font: UIFont.appFont(10), textColor: UIColor.appPurpleColor(), textAlignment: NSTextAlignment.Center)
		textNode1.addTarget(self, action: #selector(AdBannderNode2.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(textNode1)
		
		textNode2.attributedString = NSAttributedString.attributedStringFromFont("FREE DIAMONDS", font: UIFont.appFont(10), textColor: UIColor.appPinkColor(), textAlignment: NSTextAlignment.Center)
		textNode2.addTarget(self, action: #selector(AdBannderNode2.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(textNode2)
		
		//image node
		self.imageNode1.image = UIImage(named: "DownloadIcon")!
		self.imageNode1.addTarget(self, action: #selector(AdBannderNode2.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(imageNode1)
		
		self.imageNode2.image = UIImage(named: "BuddifyDiamonds")!
		self.imageNode2.addTarget(self, action: #selector(AdBannderNode2.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(imageNode2)
		
		
	}
	
	override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		imageNode1.preferredFrameSize = CGSize(width: constrainedSize.max.width*0.1, height: constrainedSize.max.height)
		imageNode2.preferredFrameSize = CGSize(width: constrainedSize.max.width*0.15, height: constrainedSize.max.height)
		
		let textStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [ textNode1, textNode2])
		
		
		let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [imageNode1, textStack, imageNode2])
		
		stack.alignSelf = .Stretch
		stack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height - 5)
		return ASStaticLayoutSpec(children: [stack])
	}
	
	internal func bannerTapped() {
		delegate?.adBannderNodeDidTapped()
	}
}

class AdBannderNode1: ASCellNode {
	let imageNode1 = ASImageNode()
	let imageNode2 = ASImageNode()
	let textNode1: ASTextNode = ASTextNode()
	let textNode2: ASTextNode = ASTextNode()
	
	weak var delegate: AdBannderNodeDelegate?
	
	override init() {
		super.init()
		self.backgroundColor = UIColor(red: 236, green: 240, blue: 241)
		
		//text node
		textNode1.attributedString = NSAttributedString.attributedStringFromFont("DOWNLOAD APPS TO GET ", font: UIFont.appFont(10), textColor: UIColor.appPurpleColor(), textAlignment: NSTextAlignment.Center)
		textNode1.addTarget(self, action: #selector(AdBannderNode1.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(textNode1)
		
		textNode2.attributedString = NSAttributedString.attributedStringFromFont("FREE DIAMONDS", font: UIFont.appFont(10), textColor: UIColor.appPinkColor(), textAlignment: NSTextAlignment.Center)
		textNode2.addTarget(self, action: #selector(AdBannderNode1.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(textNode2)
		
		//image node
		self.imageNode1.image = UIImage(named: "DownloadIcon")!
		self.imageNode1.addTarget(self, action: #selector(AdBannderNode1.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(imageNode1)
		
		self.imageNode2.image = UIImage(named: "Diamonds")!
		self.imageNode2.addTarget(self, action: #selector(AdBannderNode1.bannerTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		self.addSubnode(imageNode2)
		
		
	}
	
	override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		imageNode1.preferredFrameSize = CGSize(width: constrainedSize.max.width*0.15, height: constrainedSize.max.height)
		imageNode2.preferredFrameSize = CGSize(width: constrainedSize.max.width*0.15, height: constrainedSize.max.height)
		
		let textStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [ textNode1, textNode2])
		
		
		let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [imageNode1, textStack, imageNode2])
		
		stack.alignSelf = .Stretch
		stack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: constrainedSize.max.height - 5)
		return ASStaticLayoutSpec(children: [stack])
	}
	
	internal func bannerTapped() {
		delegate?.adBannderNodeDidTapped()
	}
}
