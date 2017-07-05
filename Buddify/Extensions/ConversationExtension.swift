//
//  ConversationExtension.swift
//  Buddify
//
//  Created by Vo Duc Tung on 27/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import LoremIpsum

//extension Conversation {
//    class func dummyConversation() -> Conversation {
//        let conversation =  Conversation()
//        var messages = [Message]()
//        
//        let user = User.dummyUser()
//        let number = random()%4
//        var date: NSDate
//        if number == 0 {
//            date = NSDate().dateBySubtractingMinutes(45)
//        }
//        else if number == 1 {
//            date = NSDate.yesterday().dateByAddingHours(random()%24)
//        }
//        else if number == 2 {
//            date = NSDate.yesterday().dateBySubtractingDays(random()%4)
//        }
//        else {
//            date = LoremIpsum.date()
//        }
//        
//        messages.append(Message(sender: user, message: LoremIpsum.sentencesWithNumber(4), timeStamp: date, messageType: kAMMessageDataContentTypeText))
//        messages.append(Message(sender: Me.sharedInstance!, message: LoremIpsum.sentencesWithNumber(4), timeStamp: date, messageType: kAMMessageDataContentTypeText))
//        messages.append(Message(sender: user, message: LoremIpsum.sentencesWithNumber(2), timeStamp: date, messageType: kAMMessageDataContentTypeText))
//        
//        conversation.user = user
//        conversation.lastMessages = messages
//        conversation.conversationId = Int64(random() % 1000)
//        
//        return conversation
//    }
//    
//    class func dummyConversations(numberOfConversations: Int) -> [Conversation] {
//        var conversations = [Conversation]()
//        
//        for _ in 0..<numberOfConversations {
//            conversations.append(Conversation.dummyConversation())
//        }
//        
//        return conversations
//    }
//}