//
//  ProfilePostViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 08/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private var kRowSpacing: CGFloat = 5
private var kColumnSpacing: CGFloat = 5
private var kNumberOfColumns: UInt = 2

private var kVerticalSpacing: CGFloat = 5
private var kHorizontalSpacing: CGFloat = 5

class ProfilePostsViewController: ASViewController, TabbarItemDelegate {
    var collectionNode: ASCollectionNode!
    internal var _dataSource: ProfilePostDataSource!
    private let _interactiveTransition = WYInteractiveTransitions()
    private var _firstLoad = true
    
    init() {
        let flowLayout = MosaicCollectionViewLayout()
        flowLayout.numberOfColumns = kNumberOfColumns
        flowLayout.headerHeight = 0
        flowLayout.sectionInset = UIEdgeInsets(top: kRowSpacing, left: kColumnSpacing, bottom: kRowSpacing, right: kColumnSpacing)
        flowLayout.interItemSpacing = UIEdgeInsets(top: kRowSpacing, left: kColumnSpacing, bottom: kRowSpacing, right: kColumnSpacing)
        flowLayout.columnSpacing = kColumnSpacing
        
        //asviewcontroller init with collection node
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        collectionNode.view.removeLoadingManager()
    }
    
    static var columnSpacing: CGFloat {
        return kColumnSpacing
    }
    
    static var rowSpacing: CGFloat {
        return kRowSpacing
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.automaticallyAdjustsScrollViewInsets = true
        self.title = "Newsfeed"
        self.view.autoresizesSubviews = true
        
        collectionNode.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        collectionNode.view.alwaysBounceVertical = true
        
        _dataSource = ProfilePostDataSource(collectionNode: collectionNode, viewController: self)
        
        //Right bar button item
        let newPostButton = HighLightButton(image: UIImage.newPostIcon(size: CGSize(width: 20, height: 20), color: UIColor.whiteColor()), highlightedImage: UIImage.newPostIcon(size: CGSize(width: 20, height: 20), color: UIColor.whiteColor().colorWithAlphaComponent(0.5)), alignment: UIControlContentHorizontalAlignment.Right)
        
        newPostButton.addTarget(self, action: #selector(ProfilePostsViewController.rightBarButtonItemTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: newPostButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
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
    
    func rightBarButtonItemTapped() {
        let postCreationViewController = PostCreationViewController()
        let navigationController = UINavigationController(rootViewController: postCreationViewController)
        _interactiveTransition.configureTransition(toView: navigationController, type: WYTransitoinType.Up)
        _interactiveTransition.panEdgeGesture.enabled = false
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    //MARK: Action methods
    internal func refresh(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        collectionNode.view.setContentOffset(CGPointZero, animated: true)
    }
    
    //MARK: TabbarItemDelegate
    func viewControllerScrollViewGoesToTop() {
        collectionNode.view.setContentOffset(CGPointZero, animated: true)
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
