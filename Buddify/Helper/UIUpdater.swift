//
//  UIUpdater.swift
//  Buddify
//
//  Created by Tung Vo  on 31/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import Models

///
/// All UI Update Notification keys
///
//let UIUpdatePostInfoChangedKey = "UIUpdatePostInfoChangedKey"
//let UIUpdatePostDeletedKey = "UIUpdatePostDeletedKey"
//let UIUpdateNewPostKey = "UIUpdateNewPostKey"

///
/// UI Post updater protocol
///
@objc protocol BDFPostUIUpdater: class, NSObjectProtocol {
    func updaterUpdateUIWithPost(post: Post)
    optional func updaterDeletePost(post: Post)
    optional func updaterAddNewPost(post: Post)
}

///
/// UI Post updater protocol
///
@objc protocol BDFUserUIUpdater: class, NSObjectProtocol {
    func updaterUpdateUserProfileImage(post: User)
    func updaterUpdateName(post: Post)
    optional func updaterAddNewPost(post: Post)
}

///
/// class UIUpdater
/// Helper class for updating UI elements when model changes. E.g:  Post, User, Comment, etc.
///
@objc class BDFUIUpdaterManager: NSObject {
    override init() {
        super.init()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.newPostPosted(_:)), name: UIUpdateNewPostKey, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.postDeleted(_:)), name: UIUpdatePostDeletedKey, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.postInfoChanged(_:)), name: UIUpdatePostInfoChangedKey, object: nil)
    }
    ///
    /// Array of post updaters
    ///
    var postUpdaters: [BDFPostUIUpdater] = []
    
    
    ///
    /// Default instance of UIUpdater
    ///
    static var sharedManager: BDFUIUpdaterManager {
        struct Singleton {
            static var manager = BDFUIUpdaterManager()
        }
        
        return Singleton.manager
    }
    
    ///
    /// Add an updater
    ///
    func addPostUIUpdater(updater: BDFPostUIUpdater) {
        postUpdaters.append(updater)
    }
    
    ///
    /// Remove updater
    ///
    func removePostUIUpdater(updater: BDFPostUIUpdater) {
        if let index = postUpdaters.indexOf({$0 === updater }) {
            postUpdaters.removeAtIndex(index)
        }
    }
    
    ///
    /// Called when new post posted
    ///
    func newPostPosted(post: Post) {
        for updater in postUpdaters {
            updater.updaterAddNewPost?(post)
        }
    }
    
    ///
    /// Called when a post changed info (likes/ liked/ comments)
    ///
    func postInfoChanged(post: Post) {
        for updater in postUpdaters {
            updater.updaterUpdateUIWithPost(post)
        }
    }
    
    ///
    /// Called when a post deleted
    ///
    func postDeleted(post: Post) {
        for updater in postUpdaters {
            updater.updaterDeletePost?(post)
        }
    }
}
