//
//  ChatViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 15/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models
import LoremIpsum

class ChatViewController: AsyncMessagesViewController, ASCollectionDelegate {
    var user: User?
    var conversation: Chat?
    private var currentUser: User? {
        return BDFAuthenticatedUser.currentUser
    }
    
    init() {
        // Assume the default image size is used for message cell nodes
        let dataSource = DefaultAsyncMessagesCollectionViewDataSource(currentUserID: String(BDFAuthenticatedUser.currentUser.userId))
        super.init(dataSource: dataSource)
        
        collectionView.asyncDelegate = self
        hidesBottomBarWhenPushed = true
    }
    
    deinit {
        // Tell ASCollectionView that this object is being deallocated (Issue #4)
        collectionView.asyncDelegate = nil
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        
        generateMessages()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.scrollCollectionViewToBottom()
    }
    
    override func didPressRightButton(sender: AnyObject!) {
//        if let user = currentUser {
//            let newMessage = textView.text
//            let message = Message(sender: user, message: newMessage, timeStamp: NSDate(), messageType: kAMMessageDataContentTypeText)
//            dataSource.collectionView(collectionView, insertMessages: [message]) {completed in
//                if let userTabbarController = self.containerViewController?.currentViewController as? UserTabbarController {
//                    //Update conversation list UI
//                    userTabbarController.conversationsViewController.addNewMessageToConversation(newMessage, user: self.user, conversationId: self.conversation?.conversationId, timeStamp: NSDate())
//                    
//                    self.scrollCollectionViewToBottom()
//                }
//            }
//        }
//        super.didPressRightButton(sender)
    }
    
    private func generateMessages() {
        guard let _ = self.user else {
            return
        }
        
        guard let _ = self.currentUser else {
            return
        }
        
        guard let _conversation = conversation else {
            return
        }
        
        //dataSource.collectionView(collectionView, insertMessages: _conversation.messages, completion: nil)
    }
}
