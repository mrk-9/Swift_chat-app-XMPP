//
//  DiscoveryUserNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 08/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

/*

Size description of node:
Total height: 172
total width: 125
profile photo height & width: 60
top profile -> top white background: 22
bottom profile -> top name label: 15
bottom name label -> gender image: 8

pink bottom: 30
*/

//MARK: DiscoveryUserNodeDelegate
//protocol DiscoveryUserNodeDelegate {
//     func likeButtonTapped(node: DiscoveryUserNode)
//     func hideButtonTapped(node: DiscoveryUserNode)
//}



//MARK: DiscoveryUserNode

private let profileImageNodeSize: CGFloat = 203/2
private let kVerticalMargin: CGFloat = 10
private let kVerticalSpacing: CGFloat = 5

class DiscoveryUserNode: ASCellNode, NetworkNodeDelegate {
    //Public variables
    //var nodeDelete: DiscoveryUserNodeDelegate?
     private var user : User!
     
    //Private variables
    private let _profileImageNode = ASNetworkImageNode()
    private let _nameLabelNode = ASTextNode()
    private let _otherInfoLabelNode = ASTextNode()

    
    convenience init(user: User!) {
        self.init()
        self.user = user
        self.commonInit(user)
    }
	
	

    private func commonInit(user: User!) {
        //Profile image node
		_profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.layerBacked = true
        _profileImageNode.defaultImage = UIImage()
		self.addSubnode(_profileImageNode)
		
		//Name label node
		_nameLabelNode.layerBacked = true
		_nameLabelNode.maximumNumberOfLines = 1
		self.addSubnode(_nameLabelNode)
		
		//Other indo label node
		_otherInfoLabelNode.layerBacked = true
		_otherInfoLabelNode.maximumNumberOfLines = 1
		self.addSubnode(_otherInfoLabelNode)

        //Background node
        self.backgroundColor = UIColor.whiteColor()
		self.cornerRadius = 5
        
		self.loadStaticData(user)
        self.loadNetworkingData(user)
		
    }
	
	override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
        self.preferredFrameSize = constrainedSize.max
		self.alignSelf = .Stretch
		let width = constrainedSize.max.width

		_profileImageNode.preferredFrameSize = CGSize(width: width , height: width)
     
        let nameStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kVerticalSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [ _nameLabelNode, _otherInfoLabelNode])
		nameStack.spacingAfter = kVerticalMargin
          nameStack.alignSelf = .Stretch
     
        let stackLayoutSpec1 = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kVerticalMargin, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [ _profileImageNode, nameStack])
		
		stackLayoutSpec1.alignSelf = .Stretch
        stackLayoutSpec1.sizeRange = ASRelativeSizeRange(size: constrainedSize.max)
        
        let staticSpec = ASStaticLayoutSpec(children: [stackLayoutSpec1])
		return  staticSpec

    }
    
    override func layout() {
        super.layout()
		let shadowPath = UIBezierPath(rect: self.bounds)
		self.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.3).CGColor
		self.shadowOffset = CGSizeMake(0, 2.5)
		self.shadowOpacity = 1
		self.shadowRadius = 5
		self.layer.shadowPath = shadowPath.CGPath

    }
     
     class func itemHeightFromWidth(width: CGFloat) -> CGFloat {
          /*
           15 is font size of name
           12 is font size of age
           5 is about space between then
           kVerticalSpacing is more space
           */
          return width + kVerticalMargin + 15 + 15 + 5 + kVerticalMargin + kVerticalSpacing
     }
}

extension DiscoveryUserNode {
     func loadStaticData(data: AnyObject?) {
          guard let user = data as? User else {
               return
          }
          
          _nameLabelNode.attributedString = NSAttributedString.attributedStringFromFont(user.name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        
        // Distance string
        var distanceString = ""
        if user.distance < 1000 {
            distanceString = String(user.distance) + " m"
        }
        else {
            distanceString = String(user.distance/1000) + " km"
        }
        
          _otherInfoLabelNode.attributedString = NSAttributedString.attributedStringFromFont(String(user.age) + "  •  " + "\(distanceString)", font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
     }
     
     func loadNetworkingData(data: AnyObject?) {
          guard let user = data as? User else {
               return
          }
          
          _profileImageNode.URL = NSURL(string: user.profilePhoto)
     }
}


class DiscoveryUserPlaceholderNode: ASCellNode {
     private let _profileImageNode = ASDisplayNode()
     private let _nameLabelNode = ASDisplayNode()
     private let _ageLabelNode = ASDisplayNode()
     
     override init() {
          super.init()
          self.addSubnode(_profileImageNode)
          self.addSubnode(_nameLabelNode)
          self.addSubnode(_ageLabelNode)
          _profileImageNode.backgroundColor = UIColor.placeholerShimmingColor()
          _ageLabelNode.backgroundColor = UIColor.placeholerShimmingColor()
          _nameLabelNode.backgroundColor = UIColor.placeholerShimmingColor()
          
          self.backgroundColor = UIColor.whiteColor()
          self.cornerRadius = 5
          self.borderWidth = 0.5
          self.borderColor = UIColor(white: 0.8, alpha: 1.0).CGColor
     }
     
     override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
          self.alignSelf = .Stretch
          self.preferredFrameSize = constrainedSize.max
          
          let width = constrainedSize.max.width
		  let height = constrainedSize.max.height

          _profileImageNode.preferredFrameSize = CGSize(width: width, height: height*0.75)
          _nameLabelNode.preferredFrameSize = CGSize(width: 100, height: 10)
          _ageLabelNode.preferredFrameSize = CGSize(width: 60, height: 10)
		
		  let nameStack =  ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kVerticalMargin, justifyContent: ASStackLayoutJustifyContent.SpaceAround, alignItems: ASStackLayoutAlignItems.Center, children: [_nameLabelNode, _ageLabelNode])

          let finalSpec =  ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: kVerticalMargin, justifyContent: ASStackLayoutJustifyContent.SpaceAround, alignItems: ASStackLayoutAlignItems.Center, children: [_profileImageNode, nameStack])
          
          let centerSpec = ASCenterLayoutSpec(centeringOptions: ASCenterLayoutSpecCenteringOptions.X, sizingOptions: ASCenterLayoutSpecSizingOptions.Default, child: finalSpec)
		  return centerSpec
     }
     
     override func layout() {
          super.layout()
          self.addShimmerToSubview(_profileImageNode.view)
          self.addShimmerToSubview(_nameLabelNode.view)
          self.addShimmerToSubview(_ageLabelNode.view)
     }
}
