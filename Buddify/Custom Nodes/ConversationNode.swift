//
//  ConversationNode.swift
//  Buddify
//
//  Created by Vo Duc Tung on 10/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

private let profileImageNodeWidth : CGFloat = 44
private let profileImageNodeHeight : CGFloat = 44

private let lastMessageLabelNodeWidth : CGFloat = 200
private let lastMessageLabelNodeHeight : CGFloat = 20

private let nameLabelNodeWidth : CGFloat = 200
private let nameLabelNodeHeight : CGFloat = 15

@objc protocol ConversationNodeDelegate: NSObjectProtocol {
    func conversationNodeProfilePhotoTapped(node: ConversationNode)
}

class ConversationNode: ASCellNode {
    weak var delegate: ConversationNodeDelegate?
    weak var chat: Chat?
    
    private let _profileImageNode = ASNetworkImageNode()
    private let _nameLabelNode = ASTextNode()
    private let _lastMessageLabelNode = ASTextNode()
    private let _timeLabelNode = ASTextNode()
    private let _onlineStatusNode = ASDisplayNode()
    private let _newMessageCounterNode = InsetTextNode()
    
    convenience init(chat: Chat) {
        self.init()
        
        _profileImageNode.backgroundColor = UIColor.photoPlaceHolderColor()
        _profileImageNode.userInteractionEnabled = true
        _profileImageNode.cornerRadius = profileImageNodeWidth/2
        _profileImageNode.preferredFrameSize = CGSize(width: profileImageNodeWidth, height: profileImageNodeHeight)
        _profileImageNode.addTarget(self, action: #selector(ConversationNode.profileImageNodeTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
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
        
        _nameLabelNode.layerBacked = true
        dispatch_async(dispatch_get_main_queue()) {
            //DTLog(chat.jidString)
            //let string = ChatClient.defaultClient.nameFromJIDString(chat.jidString!)
            //DTLog(string)
            //self._nameLabelNode.attributedString = NSAttributedString.attributedStringFromFont(ChatClient.defaultClient.nameFromJIDString(chat.jidString!), font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
            self._nameLabelNode.attributedString = NSAttributedString.attributedStringFromFont(chat.jidString!, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: nil)
        }
        
        _lastMessageLabelNode.layerBacked = true
        _lastMessageLabelNode.maximumNumberOfLines = 2
        self.setLastMessage(chat.messageBody ?? "")
        
        _timeLabelNode.layerBacked = true
        _timeLabelNode.attributedString = NSAttributedString.attributedStringFromFont((chat.messageDate ?? NSDate()).toShortDefaultString(), font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
        
        _onlineStatusNode.layerBacked = true
        
        setNumberOfNewMessages(random() % 15)
        
        self.addSubnode(_profileImageNode)
        self.addSubnode(_nameLabelNode)
        self.addSubnode(_lastMessageLabelNode)
        self.addSubnode(_timeLabelNode)
        self.addSubnode(_onlineStatusNode)
        self.addSubnode(_newMessageCounterNode)
        
        //Observere value of conversation
        self.chat = chat
    }
    
    override init() {
        super.init()
    }
    
    func setNumberOfNewMessages(number: Int) {
        var string: String
        if number == 0 {
            string = ""
            _newMessageCounterNode.backgroundColor = UIColor.clearColor()
        }
        else if number < 100 {
            string = String(number)
            _newMessageCounterNode.backgroundColor = UIColor.appPurpleColor()
        }
        else {
            string = "99+"
            _newMessageCounterNode.backgroundColor = UIColor.appPurpleColor()
        }
        
        _newMessageCounterNode.attributedString = NSAttributedString.attributedStringFromFont(string, font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.whiteColor(), textAlignment: NSTextAlignment.Center)
    }
    
    func updateChat(chat: Chat) {
        self.chat = chat
        self.setLastMessage(chat.messageBody!)
    }
    
    func setLastMessage(message: String) {
        _lastMessageLabelNode.attributedString = NSAttributedString.attributedStringFromFont(message, font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.appLightTextColor(), textAlignment: nil)
        _lastMessageLabelNode.invalidateCalculatedLayout()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        _lastMessageLabelNode.preferredFrameSize = CGSize(width: constrainedSize.max.width - 70, height: 100)
        
        //Name and time are on same level on same horizontal stack
        let middleSpacer = ASLayoutSpec()
        middleSpacer.flexGrow = true
        let nameAndTimeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_nameLabelNode, middleSpacer, _timeLabelNode])
        nameAndTimeStack.alignSelf = ASStackLayoutAlignSelf.Stretch
        nameAndTimeStack.flexShrink = true
        nameAndTimeStack.spacingBefore = 4
        
        //spacer + name + last message on same vertical stack
        //Last message label + newMessageLabel horizontal stack
        _lastMessageLabelNode.flexGrow = true
        _lastMessageLabelNode.flexShrink = true
        let messageStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_lastMessageLabelNode, _newMessageCounterNode])
        
        let verticalStackSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [nameAndTimeStack, messageStack])
        
        verticalStackSpec.flexShrink = true
        verticalStackSpec.flexGrow = true
        
        //Put profile image and new vertical stack on same horizontal stack
        let contentStackSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 10, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [_profileImageNode, verticalStackSpec])
        
        //Put all of them inside a inset spec and here we go!!
        let contentInsetsSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: contentStackSpec)
        contentInsetsSpec.flexShrink = true
        
        return contentInsetsSpec
    }
    
    override func layout() {
        super.layout()
        DTLog(_newMessageCounterNode.frame)
        _newMessageCounterNode.cornerRadius = _newMessageCounterNode.frame.size.height/2
    }
    
    //MARK: Action methods
    internal func profileImageNodeTapped() {
        delegate?.conversationNodeProfilePhotoTapped(self)
    }
}
