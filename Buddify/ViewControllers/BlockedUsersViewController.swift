//
//  BlockedUsersViewController.swift
//  Buddify
//
//  Created by Tung Vo  on 01/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit

class BlockedUsersViewController: ASViewController {
    var tableNode: ASTableNode!
    
    private var _dataSource: BlockedUserDataSource!
    private var _firstLoad = true
    
    init() {
        // Do any additional setup after loading the view.
        tableNode = ASTableNode()
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
        self.title = "Blocked users"
        self.view.autoresizesSubviews = true
        
        tableNode.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        tableNode.view.alwaysBounceVertical = true
        
        _dataSource = BlockedUserDataSource(tableNode: tableNode, viewController: self)
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
}
