//
//  ConversationExtension.swift
//  Buddify
//
//  Created by Vo Duc Tung on 26/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import LoremIpsum
import Models

//extension Notification {
//    //MARK: Return an array of notifications for testing purpose
//    class func dummyNotifications(numberOfNotifications: Int) -> [Notification] {
//        //New array
//        var newNotifications: [Notification] = [Notification]()
//        
//        //Construct new array manually instead of getting it from server
//        for _ in 0...(numberOfNotifications - 1) {
//            let notification = Notification.dummyNotification()
//            newNotifications.append(notification)
//        }
//        
//        return newNotifications
//    }
//    
//    //Return a dummy notification for tetsing purpose
//    class func dummyNotification() -> Notification {
//        let notification = Notification()
//        let user = User.dummyUser()
//        
//        let number = random()%4
//        if number == 0 {
//            notification.timeStamp = NSDate().dateBySubtractingMinutes(random()%20)
//        }
//        else if number == 1 {
//            notification.timeStamp = NSDate.yesterday().dateByAddingHours(random()%24)
//        }
//        else if number == 2 {
//            notification.timeStamp = NSDate.yesterday().dateBySubtractingDays(random()%7)
//        }
//        else {
//            notification.timeStamp = LoremIpsum.date()
//        }
//        
//        notification.user = user
//        notification.text = LoremIpsum.sentence()
//        
//        if arc4random_uniform(3) == 0 {
//            let post = Post()
//            post.photo = LoremIpsum.photoURLWithSize(300)
//            post.id = Int64(random() % 10000)
//            post.likesCount = Int(arc4random_uniform(1000))
//            post.commentsCount = Int(arc4random_uniform(1000))
//            post.caption = LoremIpsum.sentencesWithNumber(2)
//            post.owner = user
//            
//            notification.type = .Post
//            notification.post = post
//            notification.thumbPhoto = LoremIpsum.photoURLWithSize(50)
//        }
//        
//        return notification
//    }
//}
