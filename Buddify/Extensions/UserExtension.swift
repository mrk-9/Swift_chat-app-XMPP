//
//  UserExtension.swift
//  Buddify
//
//  Created by Vo Duc Tung on 26/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import LoremIpsum

//extension User {
//    /*
//     @function dummyUsers:
//     @abstract Create a dummy array of users for testing purpose
//    */
//    class func dummyUsers(numberOfUsers: Int) -> [User] {
//        if numberOfUsers == 0 {
//            fatalError("Invalid number of users")
//        }
//        
//        var newUsers: [User] = [User]()
//        
//        //Construct new array manually instead of getting it from server
//        for _ in 0...(numberOfUsers - 1) {
//            let user = User.dummyUser()
//            newUsers.append(user)
//        }
//        
//        return newUsers
//    }
//    
//    //Create a dummy user for testing purpose
//    class func dummyUser() -> User {
//        let user = User()
//        user.userId = Int64(random()%2) + Me.sharedInstance!.userId
//        user.profilePhotoThumb = LoremIpsum.photoURLWithSize(100)
//        user.profilePhoto = LoremIpsum.photoURLWithSize(400)
//        user.name = LoremIpsum.name()
//        user.age = Int(arc4random_uniform(30)) + 15
//        user.gender = Gender(rawValue: random()%2)
//        
//        return user
//    }
//}
//
//extension Me {
//    class func dummyMe() -> Me {
//        let user = Me()
//        user.userId = Int64(random()%2)
//        user.profilePhotoThumb = LoremIpsum.photoURLWithSize(100)
//        user.profilePhoto = LoremIpsum.photoURLWithSize(400)
//        user.name = LoremIpsum.name()
//        user.age = Int(arc4random_uniform(30)) + 15
//        user.gender = Gender(rawValue: random()%2)
//        user.accessToken = "123"
//        user.refreshToken = "123"
//        
//        return user
//    }
//}