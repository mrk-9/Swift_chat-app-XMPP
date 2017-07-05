//
//  ProfilePostViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 10/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Models

class ProfilePostViewController: ProfilePostsViewController {
    var userId: Int64!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _dataSource.userId = self.userId
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handlePostCreatedNotification(_:)), name: PostCreatedNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handlePostDeletedNotification(_:)), name: PostDeletedNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handlePostUpdatedNotification(_:)), name: PostUpdatedNotificationKey, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: PostCreatedNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: PostDeletedNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: PostUpdatedNotificationKey, object: nil)
    }
    
    internal func handlePostCreatedNotification(notification: NSNotification) {
//        if Me.isMe(userId) {
//            if let post = notification.object as? Post {
//                _dataSource.addNewPost(post)
//            }
//        }
    }
    
    internal func handlePostDeletedNotification(notification: NSNotification) {
//        if Me.isMe(userId) {
//            if let post = notification.object as? Post {
//                _dataSource.removePost(post)
//            }
//        }
    }
    
    internal func handlePostUpdatedNotification(notification: NSNotification) {
        
    }
    
    func refreshData(completionHandler: ((Bool) -> Void)?) {
        _dataSource.loadData(refreshing: true, animated: false, completionHandler: completionHandler)
    }
}
