//
//  Message.swift
//  Models
//
//  Created by Tung Vo  on 16/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation

///
/// Protocol Message
///
@objc public protocol Message: NSObjectProtocol {
    init(dictionary: NSDictionary)
    var messageId: Int64 {get set}
    var content: String {get}
    var createdAt: NSDate! {get}
    var conversationId: String! {get}
}

///
/// ENum message type
///
public enum BDFMessageType: Int {
    case text = 0 // "text"
    case image = 1 //"image"
}

public struct BDFMessage {
    ///
    /// Initializer
    ///
    init(dictionary: NSDictionary) {
        
    }
    
    ///
    /// Create array of BDFMessage
    ///
    static func messagesFromDictionaries(dictionaries: [NSDictionary]) -> [BDFMessage] {
        var array = [BDFMessage]()
        
        for dict in dictionaries {
            let user = BDFMessage(dictionary: dict)
            array.append(user)
        }
        
        return array
    }
    
    ///
    /// Message id
    ///
    private var messageId: Int64?
    
    ///
    /// Message content
    ///
    private var _content: String!
    var content: String {
        return _content
    }
    
    ///
    /// Timestamp when the post is posted
    ///
    private var _createdAt: NSDate!
    var createdAt: NSDate! {
        return _createdAt
    }
    
    ///
    /// Conversation id
    ///
    var conversationId: String!
    
}
