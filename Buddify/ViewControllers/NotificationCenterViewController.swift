//
//  NotificationCenterViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 11/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class NotificationCenterViewController: PagerViewController, TabbarItemDelegate {
    let activityViewController = ActivityViewController()
    let friendRequestViewController = FriendRequestViewController()
    
    required init?(coder aDecoder: NSCoder) {
        activityViewController.title = "Activity"
        
        friendRequestViewController.title = "Requests"
        
        super.init(viewControllers: [activityViewController, friendRequestViewController])
    }
    
    init() {
        activityViewController.title = "Activity"
        
        friendRequestViewController.title = "Requests"
        
        super.init(viewControllers: [activityViewController, friendRequestViewController])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TabbarItemDelegate
    func viewControllerScrollViewGoesToTop() {
        if self.selectedIndex == 0 {
            activityViewController.tableNode.view.setContentOffset(CGPointZero, animated: true)
        }
        else {
            friendRequestViewController.tableNode.view.setContentOffset(CGPointZero, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
