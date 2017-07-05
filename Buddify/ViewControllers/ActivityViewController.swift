//
//  ActivityViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 12/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ActivityViewController: ASViewController {
    var tableNode: ASTableNode!
    private var _dataSource: NotificationDataSource!
    private var _firstLoad = true
    
    init() {
        tableNode = ASTableNode(style: UITableViewStyle.Grouped)
        super.init(node: tableNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        tableNode.view.removeLoadingManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNode.view.backgroundColor = UIColor.whiteColor()
        tableNode.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        tableNode.view.alwaysBounceVertical = true
        
        _dataSource = NotificationDataSource(tableNode: tableNode, viewController: self)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if _firstLoad {
            _firstLoad = false
            _dataSource.refresh(nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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