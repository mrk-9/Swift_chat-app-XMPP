//
//  FriendRequestViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 17/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private var kRowSpacing: CGFloat = CGFloat.topMargin
private var columnSpacing: CGFloat = CGFloat.rightMargin
private var numberOfColumns: UInt = 1

private var kLeftInset: CGFloat = 5
private var kRightInset: CGFloat = 5

class FriendRequestViewController: ASViewController {
    var tableNode: ASTableNode!
    
    private var _dataSource: FriendRequestDataSource!
    private var _firstLoad = true
    
    init() {
        // Do any additional setup after loading the view.
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
        //self.automaticallyAdjustsScrollViewInsets = true
        self.title = "Discovery"
        self.view.autoresizesSubviews = true
        
        tableNode.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        //tableNode.view.leadingScreensForBatching = 2
        tableNode.view.alwaysBounceVertical = true
        
        _dataSource = FriendRequestDataSource(tableNode: tableNode, viewController: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if _firstLoad {
            _firstLoad = false
            _dataSource.refresh(nil)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tableNode.view.stopLoading()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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