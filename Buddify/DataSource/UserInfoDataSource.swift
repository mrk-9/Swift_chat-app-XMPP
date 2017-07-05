//
//  UserInfoDataSource.swift
//  Buddify
//
//  Created by Huy Le on 3/23/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import LoremIpsum

class UserInfoDataSource: NSObject, ASCollectionDataSource, ASCollectionDelegate  {
    private var _layoutInspector: MosaicCollectionViewLayoutInspector!
    private var _sections: [(String, String)] = []
    
	init(collectionNode: ASCollectionNode) {
		super.init()
		collectionNode.delegate = self
		collectionNode.dataSource = self
        collectionNode.backgroundColor = UIColor.whiteColor()
        _layoutInspector = MosaicCollectionViewLayoutInspector()
        collectionNode.view.layoutInspector = _layoutInspector
        
        for i in 0...7 {
            if i == 0 {
                let string = "I am a very nice guy who loves to play football. I also enjoy listening to music and other things like swimming, coding."
                _sections.append(("About me", string))
            }
            else if i == 1 {
                let string = "• 🇬🇧 English\n• 🇰🇷 Korean\n• 🇯🇵 Japansese\n• 🇫🇮 Finnish\n"
                _sections.append(("Languages", string))
            }
            else if i == 2 {
                let string = "• Football\n• Movies\n• Music\n• And other stuff\n"
                _sections.append(("Interests", string))
            }
            else {
                _sections.append((LoremIpsum.wordsWithNumber(2), LoremIpsum.sentencesWithNumber(3)))
            }
        }
	}
	
	//MARK: ASCollectionDataSource, ASCollectionDelegate
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return _sections.count
	}
	
	func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
            let (section, text) = _sections[indexPath.row]
			return {
				let node = UserInfoSectionNode(title: section, description: text)
				return node
			}
	}
    
    func collectionView(collectionView: UICollectionView!, layout: MosaicCollectionViewLayout!, originalItemSizeAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        let (section, text) = _sections[indexPath.row]
        let totalWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right) - CGFloat(layout.numberOfColumns - 1) * layout.columnSpacing
        let itemWidth = totalWidth/CGFloat(layout.numberOfColumns)
        let itemHeight = UserInfoSectionNode.nodeHeightWithWidth(itemWidth, title: section, text: text)
        return CGSize(width: itemWidth, height: itemHeight)
    }
	

	
//	func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
//		
//			return ASSizeRange(min: CGSize(width: CGFloat.screenWidth, height: 0), max: CGSize(width: CGFloat.screenWidth, height: CGFloat.screenWidth))
//		
//	}
//	
//	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//		return 0
//	}
	
	
}