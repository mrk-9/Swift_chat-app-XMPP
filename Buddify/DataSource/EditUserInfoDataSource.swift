//
//  EditInfoDataSource.swift
//  Buddify
//
//  Created by Huy Le on 3/29/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import LoremIpsum

protocol EditUserInfoDataSourceDelegate: NSObjectProtocol {
	func editUserInfoDataSourceTextUpdating()
}
class EditUserInfoDataSource: NSObject, ASCollectionDataSource, ASCollectionDelegate, EditableUserInfoSectionNodeDelegate  {
	private var _layoutInspector: MosaicCollectionViewLayoutInspector!
	private var _sections: [(String, String)] = []
	var delegate: EditUserInfoDataSourceDelegate?
	
	init(collectionNode: ASCollectionNode) {
		super.init()
		collectionNode.delegate = self
		collectionNode.dataSource = self
		collectionNode.backgroundColor = UIColor.appScrollViewBackgrouncColor()
		_layoutInspector = MosaicCollectionViewLayoutInspector()
		collectionNode.view.layoutInspector = _layoutInspector
		
		for _ in 0...7 {
			_sections.append((LoremIpsum.wordsWithNumber(2).uppercaseString, LoremIpsum.wordsWithNumber(5)))
		}
	}
	
	//MARK: ASCollectionDataSource, ASCollectionDelegate
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return _sections.count
	}
	
	func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
		let (section, text) = _sections[indexPath.row]
		return {
			let node = EditableUserInfoSectionNode(title: section, description: text)
			node.nodeDelegate = self
			node.descriptionLabel.scrollEnabled = false

			return node
		}
	}
	
	func collectionView(collectionView: UICollectionView!, layout: MosaicCollectionViewLayout!, originalItemSizeAtIndexPath indexPath: NSIndexPath!) -> CGSize {
		let (section, text) = _sections[indexPath.row]
		let totalWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right) - CGFloat(layout.numberOfColumns - 1) * layout.columnSpacing
		let itemWidth = totalWidth/CGFloat(layout.numberOfColumns)
		let itemHeight = EditableUserInfoSectionNode.nodeHeightWithWidth(itemWidth, title: section, text: text)
		return CGSize(width: itemWidth, height: itemHeight)
	}
	
	//node delegate functions
	
	func editableUserInfoSectionNodeDelegateDidUpdateText(node: EditableUserInfoSectionNode) {
		delegate?.editUserInfoDataSourceTextUpdating()
		
	}
}