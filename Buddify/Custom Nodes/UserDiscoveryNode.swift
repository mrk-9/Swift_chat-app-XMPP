//
//  UserDiscoveryNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 15/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

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
protocol UserDiscoveryNodeDelegate {
    func likeButtonTapped(node: UserDiscoveryNode)
    func hideButtonTapped(node: UserDiscoveryNode)
}



//MARK: DiscoveryUserNode
private let nodeWidth: CGFloat = 320/2
private let nodeHeight: CGFloat = 342/2

private let ageLabelNodeWidth: CGFloat = 86/2
private let ageLabelNodeHeight: CGFloat = ageLabelNodeWidth*30/86

class UserDiscoveryNode: ASCellNode, NetworkNodeDelegate {
    //Public variables
    var nodeDelete: UserDiscoveryNodeDelegate?
    
    //Private variables
    private let _profileImageNode = ASNetworkImageNode()
    private let _nameLabelNode = ASTextNode()
    private let _ageLabelNode = ASButtonNode()
    private let _distanceLabelNode = ASTextNode()
    
    private var user : User!
    
    convenience init(user: User) {
        self.init()
        self.user = user
        self.commonInit()
    }
    
    
    
    private func commonInit() {
        //Profile image node
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.layerBacked = true
        _profileImageNode.defaultImage = UIImage()
        self.addSubnode(_profileImageNode)
        
        //Age label node
        _ageLabelNode.preferredFrameSize = CGSize(width: ageLabelNodeWidth, height: ageLabelNodeHeight)
        _ageLabelNode.cornerRadius = ageLabelNodeHeight/1.5
        _ageLabelNode.clipsToBounds = true
        _ageLabelNode.backgroundColor = UIColor.blackColor()
        _ageLabelNode.contentEdgeInsets = UIEdgeInsets(top: 3, left: 12, bottom: 3, right: 12)
        
        if user.gender == .Male {
            _ageLabelNode.backgroundColor = UIColor.appPurpleColor()
        }
        else {
            _ageLabelNode.backgroundColor = UIColor.appPinkColor()
        }
        
        //border
        _ageLabelNode.borderWidth = 0.1*ageLabelNodeHeight
        _ageLabelNode.borderColor = UIColor.whiteColor().CGColor
        self.addSubnode(_ageLabelNode)
        
        //Name label node
        _nameLabelNode.layerBacked = true
        _nameLabelNode.maximumNumberOfLines = 1
        self.addSubnode(_nameLabelNode)
        
        //Distance label node
        _distanceLabelNode.layerBacked = true
        self.addSubnode(_distanceLabelNode)
        
        //Background node
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.preferredFrameSize = constrainedSize.max
        self.alignSelf = .Stretch
        
        _profileImageNode.preferredFrameSize = constrainedSize.max
        //ageLabelNode.preferredFrameSize = CGSize(width: width * ageLabelNodeWidth/nodeWidth, height:  width * ageLabelNodeHeight/nodeWidth)
        
        let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 5, justifyContent: ASStackLayoutJustifyContent.End, alignItems: ASStackLayoutAlignItems.Start, children: [_nameLabelNode, _distanceLabelNode])
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 0) , child: verticalStack)
        
        let overlaySpec = ASOverlayLayoutSpec(child: insetSpec, overlay: verticalStack)
        return overlaySpec
    }
    
    override func layout() {
        super.layout()
    }
    
    
    
    //MARK: Event methods
    func likeButtonTapped() {
        nodeDelete?.likeButtonTapped(self)
    }
    
    func hideButtonTapped() {
        nodeDelete?.hideButtonTapped(self)
    }
}

extension UserDiscoveryNode {
    //MARK: NetworkNodeDelegate
    func loadStaticData(data: AnyObject?) {
        guard let user = data as? User else {
            return
        }
        
        _ageLabelNode.setTitle(String(user.age) + "Y", withFont: UIFont.boldAppFont(13), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
        _nameLabelNode.attributedString = NSAttributedString.attributedStringFromFont(user.name, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: .Center)
        _distanceLabelNode.attributedString = NSAttributedString.attributedStringFromFont(String(100) + "km away", font: UIFont.appFont(13), textColor: UIColor.lightGrayColor(), textAlignment: nil)
    }
    
    func loadNetworkingData(data: AnyObject?) {
        guard let user = data as? User else {
            return
        }
        
        _profileImageNode.URL = NSURL(string: user.profilePhoto)
    }
}
