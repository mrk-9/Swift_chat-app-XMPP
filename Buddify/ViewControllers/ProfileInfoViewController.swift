//
//  ProfileInfoViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 24/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

private var kRowSpacing: CGFloat = 5
private var kColumnSpacing: CGFloat = 5
private var kNumberOfColumns: UInt = 1

import AsyncDisplayKit

class ProfileInfoViewController: ASViewController {
    let collectionNode: ASCollectionNode
    private let _dataSource: UserInfoDataSource!
    
    init() {
        let flowLayout = MosaicCollectionViewLayout()
        flowLayout.numberOfColumns = kNumberOfColumns
        flowLayout.headerHeight = 0
        flowLayout.sectionInset = UIEdgeInsets(top: kRowSpacing, left: kColumnSpacing, bottom: kRowSpacing, right: kColumnSpacing)
        flowLayout.interItemSpacing = UIEdgeInsets(top: kRowSpacing, left: kColumnSpacing, bottom: kRowSpacing, right: kColumnSpacing)
        flowLayout.columnSpacing = kColumnSpacing
        
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        _dataSource = UserInfoDataSource(collectionNode: collectionNode)
        super.init(node: collectionNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
