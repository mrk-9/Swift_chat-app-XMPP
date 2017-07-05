//
//  PushNotification.swift
//  Buddify
//
//  Created by Vo Duc Tung on 19/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

enum PushNotificationType: String {
    case Post = "post"
    case User = "user"
    case Local = "local"
    case None = ""
}

public class PushNotification: NSObject {
    var text: String!
    var type: PushNotificationType!
    var postId: Int64?
    var userId: Int64?
    var notificationId: Int64!
    var date: NSDate!
    
    init(dictionary: NSDictionary) {
        super.init()
        
        if let text = dictionary["text"] as? String {
            self.text = text
        }
        else {
            self.text = ""
        }
        
        if let text = dictionary["type"] as? String {
            self.type = PushNotificationType(rawValue: text) ?? .None
        }
        else {
            self.type = PushNotificationType.None
        }
        
        if let id = dictionary["post_id"] as? NSNumber {
            self.postId = id.longLongValue
        }
        
        if let id = dictionary["user_id"] as? NSNumber {
            self.userId = id.longLongValue
        }
        
        if let id = dictionary["notification_id"] as? NSNumber {
            self.notificationId = id.longLongValue
        }
        
        if let text = dictionary["created_at"] as? String {
            self.text = text
        }
    }
}
