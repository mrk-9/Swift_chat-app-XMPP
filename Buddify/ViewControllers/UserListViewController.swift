//
//  LikersViewController.swift
//  Buddify
//
//  Created by Huy Le on 3/17/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class UserListViewController: ASViewController {
    private var tableNode =  ASTableNode()
    private var _dataSource: UserListDataSource!
    private var _firstLoad = true
    
    init(type: UserListType){
        super.init(node: tableNode)
        _dataSource = UserListDataSource(type: type, tableNode: tableNode, viewController: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        tableNode.view.removeLoadingManager()
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        //self.setUpViewControllerExpands()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "People liked this"
        
        tableNode.view.alwaysBounceVertical = true
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
}