//
//  ProfileDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 10/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

class ProfileDataSource: NSObject, ASCollectionDataSource, ASCollectionDelegate, UICollectionViewDelegateFlowLayout, UserProfileNodeDelegate {
    //Private
    private var _userId: Int64!
    private var _user: User?
    
    
    init(userId: Int64) {
        super.init()
        _userId = userId
    }
    
    init(user: User!) {
        super.init()
        _user = user
        _userId = user.userId
    }
    
    init(collectionNode: ASCollectionNode) {
        super.init()
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }
    
    //MARK: ASCollectionDataSource, ASCollectionDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {

		let node = UserProfileNode(user: BDFAuthenticatedUser.currentUser)
		node.nodeDelegate = self
		return {
			return node
		}

    }
    
    func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
		
		return ASSizeRange(min: CGSizeZero, max: CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
		
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
	
	//User profile node delegate method
	func userProfileNodeAddFriendButtonTapped(node: UserProfileNode) {
		
	}
	
}
