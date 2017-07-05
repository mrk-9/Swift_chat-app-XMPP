//
//  Conversation.swift
//  Models
//
//  Created by Tung Vo  on 16/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation

///
/// Protocol Conversation
///
public protocol Conversation: NSObjectProtocol {
    init(dictionary: NSDictionary)
    var conversationId: String! {get}
    var participants: [User]! {get}
    var messages: [Message] {get}
    func appendMessages(messages: [Message])
    func removeMessages(messages: [Message])
    func insertMessages(messages: [Message])
}

///
/// Class BDFConversation
///
class BDFConversation: NSObject, Conversation {
    ///
    /// Initializer
    ///
    required init(dictionary: NSDictionary) {
        super.init()
    }
    
    ///
    /// Create array of BDFConversation
    ///
    class func conversationsFromDictionaries(dictionaries: [NSDictionary]) -> [BDFConversation] {
        var array = [BDFConversation]()
        
        for dict in dictionaries {
            let user = BDFConversation(dictionary: dict)
            array.append(user)
        }
        
        return array
    }
    
    ///
    /// Conversation id
    ///
    private var _conversationId: String!
    var conversationId: String! {
        return _conversationId
    }
    
    ///
    /// Participants
    ///
    var _participants: [User]!
    var participants: [User]! {
        return _participants
    }
    
    ///
    ///
    ///
    
    ///
    /// Messages
    ///
    var _messages: [Message] = []
    
    var messages: [Message] {
        return _messages
    }
    
    ///
    /// Method to add more messages to conversation.
    ///
    func appendMessages(messages: [Message]) {
        _messages += messages
    }
    
    ///
    /// Method to remove messages from conversation.
    ///
    func removeMessages(messages: [Message]) {
        for message in messages {
            if let index = self.messages.indexOf({$0.messageId == message.messageId}) {
                _messages.removeAtIndex(index)
            }
        }
    }
    
    ///
    /// Method to insert messages to conversation.
    ///
    func insertMessages(messages: [Message]) {
        for (index, message) in messages.enumerate() {
            _messages.insert(message, atIndex: index)
        }
    }
    
    ///
    /// Method to indicate if it is a group chat
    ///
    var isGroupChat: Bool {
        return _participants.count <= 2
    }
}
