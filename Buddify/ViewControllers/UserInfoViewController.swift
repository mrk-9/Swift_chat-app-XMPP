//
//  UserInfoViewController.swift
//  Buddify
//
//  Created by Huy Le on 3/23/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private var rowSpacing: CGFloat = 5
private var columnSpacing: CGFloat = 0
private var numberOfColumns: UInt = 1

private var kLeftInset: CGFloat = 0
private var kRightInset: CGFloat = 0
private var kBottomInset: CGFloat = 0
private var kTopInset: CGFloat = 0

class UserInfoViewController: ASViewController {
	private var _dataSource: UserInfoDataSource!
	private var collectionNode: ASCollectionNode!
	
	init() {
		// Do any additional setup after loading the view.
		let layout = UICollectionViewFlowLayout()
		collectionNode = ASCollectionNode(collectionViewLayout: layout)

		collectionNode = ASCollectionNode(collectionViewLayout: layout)

		super.init(node: collectionNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.automaticallyAdjustsScrollViewInsets = true
		self.view.autoresizesSubviews = true
		
		//collectionNode.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
		collectionNode.view.leadingScreensForBatching = 2
        collectionNode.view.alwaysBounceVertical = true
		
		_dataSource = UserInfoDataSource(collectionNode: collectionNode)

		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}