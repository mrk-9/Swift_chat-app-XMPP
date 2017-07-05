//
//  DiscoveryDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 08/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import UIKit
import LoremIpsum
import pop
import Models

//This needs to be change for performance

class DiscoveryDataSource: NSObject, MosaicCollectionViewLayoutDelegate, ASCollectionDataSource, LoadingManagerDelegate, NetworkDataSource {
    /// Discovery coordinate
    /// This allows users to discover users with custom location
    var discoveryCoordinates: CLLocationCoordinate2D?
    
    private var _layoutInspector = MosaicCollectionViewLayoutInspector()
    weak private var _viewController: UIViewController?
    weak private var _collectionNode: ASCollectionNode?
    private var _users: [User]!
    private var _nextPageString: String?
    
    //Last loaded item index
    var currentLoadedIndexPath: NSIndexPath!
    
    // Content status
    private var contentStatus = DTContentStatus.NotLoaded {
        didSet {
            if contentStatus == .NoContent || contentStatus == .ErrorLoad {
                (_collectionNode?.view.collectionViewLayout as? MosaicCollectionViewLayout)?.headerHeight = 100
            }
            else {
                (_collectionNode?.view.collectionViewLayout as? MosaicCollectionViewLayout)?.headerHeight = 0
            }
        }
    }
    
    convenience init(collectionNode: ASCollectionNode, viewController: UIViewController) {
        self.init()
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.view.layoutInspector = _layoutInspector
        collectionNode.view.addLoadingManager(nil, loadingManagerDelegate: self, scrollDirection: .Vertical)
        
        // Header when no users is nearby
        (collectionNode.view.collectionViewLayout as? MosaicCollectionViewLayout)?.headerHeight = 0
        collectionNode.view.registerSupplementaryNodeOfKind(UICollectionElementKindSectionHeader)
        
        //Add refresh control
        collectionNode.view.addRefreshControl(self, action: #selector(self.dynamicType.refresh(_:)), tintColor: UIColor.appPurpleColor())
        
        _collectionNode = collectionNode
        _viewController = viewController
    }
    
    //MARK: ASCollectionDelegate + ASCollectionDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if _users == nil {
            if contentStatus == .NotLoaded {
                _collectionNode?.view.userInteractionEnabled = false
                return 6
            }
            
            return 0
        }
        _collectionNode?.view.userInteractionEnabled = true
        return _users.count //User.discoveryUsers?.count ?? 0
    }
    
    func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        if _users == nil {
            return {
                let node = DiscoveryUserPlaceholderNode()
                return node
            }
        }
        
        let user = _users[indexPath.row]
        
        return {
            
            let node = DiscoveryUserNode(user: user)
            
            if self.currentLoadedIndexPath.row >= indexPath.row {
                node.loadNetworkingData(user as? NSObject)
            }
			
            return node
        }
    }
    
    
    //MARK: MosaicCollectionViewLayoutDelegate
    func collectionView(collectionView: UICollectionView!, layout: MosaicCollectionViewLayout!, originalItemSizeAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        let totalWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right) - CGFloat(layout.numberOfColumns - 1) * layout.columnSpacing
        let itemWidth = totalWidth/CGFloat(layout.numberOfColumns)
        return CGSize(width: itemWidth, height: DiscoveryUserNode.itemHeightFromWidth(itemWidth))
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if _users != nil {
            let profileViewController = ProfileViewController()
            profileViewController.user = _users[indexPath.row]
            _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    
    func collectionView(collectionView: ASCollectionView, willDisplayNodeForItemAtIndexPath indexPath: NSIndexPath) {
        //Not animate when it's placeholder cell node
        currentLoadedIndexPath = indexPath
        
        guard let users = self._users else {
            return
        }
        
        if let node = collectionView.nodeForItemAtIndexPath(indexPath) as? DiscoveryUserNode {
            //Load network data for new nodes
            //node.loadNetworkingData(users[indexPath.row])
        }
    }
    
    func collectionView(collectionView: ASCollectionView, nodeForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> ASCellNode {
        // If timeline has no content, display message
        let node = DTTextCellNode(font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Center, textInsets: UIEdgeInsets(top: 20, left: CGFloat.leftMargin, bottom: 20, right: CGFloat.rightMargin))
        
        if contentStatus == .NoContent {
            node.text = "There are no users around you at the moment. You can try changing discovery preference."
        }
        else if contentStatus == .ErrorLoad {
            node.text = "There is problem loading nearby users.\nPlease try again."
        }
        
        node.setUpAsHeader()
        return node
    }
    
    //MARK: DiscoveryUserNodeDelegate
    func likeButtonTapped(node: DiscoveryUserNode) {
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            DTLog(indexPath.row)
        }
    }
    
    func hideButtonTapped(node: DiscoveryUserNode) {
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            DTLog(indexPath.row)
        }
    }
}

extension DiscoveryDataSource {
    //MARK: Methods
    func loadMoreNearByUsers(completionHandler: ((Bool) -> Void)?) {
        self.loadData(refreshing: false, animated: false, completionHandler: completionHandler)
    }
    
    //MARK: LoadingManagerDelegate
    /* This indicates wheather or not loader should starts loading when scrolls to bottom*/
    func loadingManagerLoaderDidStartAnimating(loadingManager: LoadingManager) {
        //Load more content here
        //Add more contents
        if _nextPageString != nil {
            
        }
        
        self.loadMoreNearByUsers({[weak self] (succeeded) in
            self?._collectionNode?.view.stopLoading()
        })
    }
    
    //MARK: Data source methods
    internal func refresh(refreshControl: UIRefreshControl?) {
        // Remove next page
        _nextPageString = nil
        
        if !PLACEHOLDER_TEST {
            if let _ = refreshControl {
                self.loadData(refreshing: true, animated: true, completionHandler: nil)
            }
            else {
                //If refreshing automatically not by scrolling down
                self.loadData(refreshing: true, animated: true, completionHandler: nil)
            }
        }
    }
    
    func loadData(refreshing refresh: Bool, animated: Bool, completionHandler: ((Bool) -> Void)?) {
        // Convert distance from kilometers to meters
        let distanceInMeters = FilterStats.sharedStats.radius * 1000
        BDFAuthenticatedUser.currentUser.getNearByUsers(FilterStats.sharedStats.minAge, maxAge: FilterStats.sharedStats.maxAge, radius: distanceInMeters, coordinate: discoveryCoordinates, gender: FilterStats.sharedStats.gender, nextPageString: _nextPageString, successBlock: {[weak self] (users: [User], nextPageString: String?) in
            guard let _self = self else {
                return
            }
            
            //Initilize user list if is nil
            if _self._users == nil {
                _self._users = []
            }
            
            //If we are refreshing the content
            if refresh {
                //Reset current loaded index path
                _self.currentLoadedIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                
                // Update content status
                if users.count == 0 {
                    _self.contentStatus = DTContentStatus.NoContent
                    _self._collectionNode?.view.shouldAnimating = false
                }
                else {
                    _self.contentStatus = DTContentStatus.Loaded
                    _self._collectionNode?.view.shouldAnimating = true
                }
                
                _self._users.removeAll()
                _self._users = _self._users! + users
                _self._collectionNode?.view.reloadDataWithCompletion({
                    if animated {
                        //Reset content offset + shouldAnimating
                        _self._collectionNode?.view.refreshControl?.endRefreshing()
                    }
                })
            }
            else {
                if users.count == 0 {
                    //Prevent to load more the next time
                    self?._collectionNode?.view.shouldAnimating = false
                    completionHandler?(true)
                    return
                }
                
                var indexPaths = [NSIndexPath]()
                for i in _self._users.count...(_self._users.count + users.count - 1) {
                    let indexPath = NSIndexPath(forItem: i, inSection: 0)
                    indexPaths.append(indexPath)
                }
                _self._users = _self._users! + users
                _self._collectionNode?.view.insertItemsAtIndexPaths(indexPaths)
                completionHandler?(true)
            }
            
            //Get next link
            _self._nextPageString = nextPageString
            
            if _self._nextPageString == nil {
                self?._collectionNode?.view.shouldAnimating = false
            }
            
            
        }) {[weak self] (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Update content status
            let status = self?.contentStatus
            self?.contentStatus = DTContentStatus.ErrorLoad
            if status == DTContentStatus.NotLoaded {
                dispatch_async_main_queue({ 
                    self?._collectionNode?.view.reloadData()
                })
            }
            
            //Enable scrolling
            self?._collectionNode?.view.scrollEnabled = true
            completionHandler?(true)
            self?._collectionNode?.view.refreshControl?.endRefreshing()
            self?._collectionNode?.view.userInteractionEnabled = true
            DTLog(error?.description)
        }
    }
}
