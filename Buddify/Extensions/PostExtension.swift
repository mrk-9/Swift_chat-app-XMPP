//
//  PostExtension.swift
//  Buddify
//
//  Created by Vo Duc Tung on 26/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import LoremIpsum

//extension Post {
//    //Return a dummy array of posts for testing purpose
//    class func dummyPosts(numberOfPosts: Int) -> [Post] {
//        var newPosts: [Post] = [Post]()
//        
//        //Construct new array manually instead of getting it from server
//        for _ in 0...(numberOfPosts - 1) {
//            let post = Post.dummyPost()
//            newPosts.append(post)
//        }
//        
//        return newPosts
//    }
//    
//    //Return a dummy post for testing purpose
//    class func dummyPost() -> Post {
//        let post = Post()
//        let user = User.dummyUser()
//        
//        post.photo = LoremIpsum.photoURLWithSize(300)
//        post.id = Int64(random() % 10000)
//        post.likesCount = Int(arc4random_uniform(1000))
//        post.commentsCount = Int(arc4random_uniform(1000))
//        post.caption = LoremIpsum.sentencesWithNumber(2)
//        post.owner = user
//        
//        let number = random()%4
//        if number == 0 {
//            post.createdAt = NSDate().dateBySubtractingMinutes(45)
//        }
//        else if number == 1 {
//            post.createdAt = NSDate.yesterday().dateByAddingHours(random()%24)
//        }
//        else if number == 2 {
//            post.createdAt = NSDate.yesterday().dateBySubtractingDays(random()%4)
//        }
//        else {
//            post.createdAt = LoremIpsum.date()
//        }
//        
//        if arc4random_uniform(3) == 0 {
//            post.type = .Status
//        }
//        
//        return post
//    }
//}