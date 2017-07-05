//
//  CommentExtension.swift
//  Buddify
//
//  Created by Vo Duc Tung on 26/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import LoremIpsum

//extension Comment {
//    //Return a dummy comment for testing purpose
//    class func dummyComment() -> Comment {
//        let user = User.dummyUser()
//        
//        let number = random()%4
//        var date: NSDate
//        if number == 0 {
//            date = NSDate().dateBySubtractingMinutes(random()%20)
//        }
//        else if number == 1 {
//            date = NSDate.yesterday().dateByAddingHours(random()%24)
//        }
//        else if number == 2 {
//            date = NSDate.yesterday().dateBySubtractingDays(random()%7)
//        }
//        else {
//            date = LoremIpsum.date()
//        }
//        
//        return Comment(content: LoremIpsum.wordsWithNumber(3), date: date, user: user)
//    }
//    
//    //Return a dummy array of comments for testing purpose
//    class func dummyComments(numberOfComments: Int) -> [Comment] {
//        var comments = [Comment]()
//        for _ in 0...(numberOfComments - 1) {
//            comments.append(Comment.dummyComment())
//        }
//        
//        return comments
//    }
//}
