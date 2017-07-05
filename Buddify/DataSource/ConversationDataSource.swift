//
//  ConversationDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 10/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import LoremIpsum
import Models
import CoreData

///
/// Data source controls the list of conversations
///
class ConversationDataSource: NSObject, ASTableViewDataSource, ASTableViewDelegate, ConversationNodeDelegate { //ConversationListUpdater
    private weak var _viewController: UIViewController?
    private weak var _tableNode: ASTableNode?
    private var _chats: [Chat]!
    
    convenience init(tableNode: ASTableNode, viewController: UIViewController) {
        self.init()
        _viewController = viewController
        _tableNode = tableNode
        tableNode.dataSource = self
        tableNode.delegate = self
        
        self.loadData()
    }
    
    deinit {
        DTLog("deinit ConversationDataSource")
    }
    
    //MARK: ASTableViewDataSource + ASTableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DTLog(_chats.count)
        return _chats.count
    }
    
    func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        let conversation = _chats[indexPath.row]
        
        return {
            let node = ConversationNode(chat: conversation)
            node.delegate = self
            return node
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let node = (tableView as? ASTableView)?.nodeForRowAtIndexPath(indexPath) as? ConversationNode {
            node.setNumberOfNewMessages(0)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let chatViewController = ChatViewController()
        chatViewController.conversation = _chats[indexPath.row]
        //let user = _conversations[indexPath.row].participants![0]
        //chatViewController.user = user
        _viewController?.navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    //MARK: - ConversationNode
    func conversationNodeProfilePhotoTapped(node: ConversationNode) {
        node.setLastMessage(LoremIpsum.sentencesWithNumber(4))
        node.setNumberOfNewMessages(random()%200)
        
        if let indexPath = _tableNode?.view.indexPathForNode(node) {
            let profileViewController = ProfileViewController()
            let user = BDFAuthenticatedUser(dictionary: NSDictionary())
            //let user = _conversations[indexPath.row].participants![0]
            //profileViewController.user = _conversations[indexPath.item].participants![0]
            _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    //MARK: ConversationListUpdater
    func addNewMessageToConversation(message: String, user: User?, conversationId: String?, timeStamp: NSDate) {
//        guard let me = Me.sharedInstance else {
//            return
//        }
//        
//        let newMessage = Message(sender: me, message: message, timeStamp: timeStamp, messageType: kAMMessageDataContentTypeText)
//        
//        //If chatting with user from existing conversation
//        if let _conversationId = conversationId {
//            for (index, conversation) in _conversations.enumerate() {
//                if conversation.conversationId == _conversationId {
//                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
//                    if let node = self._tableNode?.view.nodeForRowAtIndexPath(indexPath) as? ConversationNode {
//                        //Add new message to this conversation
//                        node.addMessage(newMessage)
//                        return
//                    }
//                }
//            }
//        }
//        else {
//            //If chatting with user from user profile, then we are not sure if this conversation exists
//            if let _user = user {
//                //So first we check that if it exists, we add the message to existing conversation
//                for (index, conversation) in _conversations.enumerate() {
//                    if conversation.participants[0].userId == _user.userId {
//                        let indexPath = NSIndexPath(forRow: index, inSection: 0)
//                        if let node = self._tableNode?.view.nodeForRowAtIndexPath(indexPath) as? ConversationNode {
//                            //Add new message to this conversation
//                            node.addMessage(newMessage)
//                            return
//                        }
//                    }
//                }
//                
//                //If no existing conversations exist with that userId, create new conversation
//                let newConversation = Conversation.dummyConversation()
//                newConversation.lastMessages.append(newMessage)
//                _conversations.insert(newConversation, atIndex: 0)
//                let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//                
//                //Update list
//                _tableNode?.view.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//            }
//            else {
//                fatalError("Information missing. Cannot send message without knowing user or conversation.")
//            }
//        }
    }
    
    func updateNewMessageFromUser(user: User, message: Message) {
        
    }
    
    func loadData() {
        _chats = [Chat]()
        let entity = NSEntityDescription.entityForName("Chat", inManagedObjectContext: ChatClient.defaultClient.managedObjectContext)
        let fetchRequest = NSFetchRequest()
        let predicate = NSPredicate(format: "isGroupMessage == %@", NSNumber(bool: false))
        fetchRequest.predicate = predicate
        fetchRequest.entity = entity
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        fetchRequest.propertiesToFetch = ["jidString"]
        fetchRequest.fetchBatchSize = 50
        
        do {
            if let fetchedObjects = try ChatClient.defaultClient.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSDictionary] {
                // Just get all chats at the moment
                //_chats = fetchedObjects
                for object in fetchedObjects {
                    if let jidString = object["jidString"] as? String {
                        if let chat = ChatClient.defaultClient.latestChatRecordFromJID(jidString) {
                            _chats.append(chat)
                        }
                    }
                }
                
                self._tableNode?.view.reloadData()
            }
        }
        catch {
            abort()
        }
    }
    
    func getChatInfoAtIndexPath(indexPath: NSIndexPath) {
        let chat = _chats[indexPath.row]
        let user =  ChatClient.defaultClient.userWithJID(chat.jidString!)
    }
}

