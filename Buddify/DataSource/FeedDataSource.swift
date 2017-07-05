//
//  FeedDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 22/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import LoremIpsum
import AFDateHelper
import pop
import DTPhotoViewerController
import Models

class FeedDataSource: NSObject, ASCollectionDataSource, ASCollectionDelegate, ASCollectionViewDelegateFlowLayout, LoadingManagerDelegate, AdBannderNodeDelegate {
	weak var _collectionNode: ASCollectionNode?
	weak var _viewController: UIViewController?
	
	weak var bigImageButton: UIImageView?
	//This is for testing purpose
	private var _posts: [Post]?
	private var _layoutInspector: MosaicCollectionViewLayoutInspector!
	private var _nextPageString: String?
    
    ///
    /// The array of posts whose infos have been changed
    ///
    private var _changedPosts: [Post] = []
	
	/// Last biggest item index displayed
    /// Or this can also be a hack for willDisplayNodeAtIndexPath for top indexPaths that won't be called with this one.
	private var _biggestAnimatedItem = 0
	
	/* This array of sizes is some hack for smoothness, this value should be updated whenever there are changes in collectionNode like inserting, removing nodes */
	private var cachedSizes = [CGSize]()
    
    // Content status
    private var contentStatus = DTContentStatus.NotLoaded {
        didSet {
            if contentStatus == .NoContent || contentStatus == .ErrorLoad {
                (_collectionNode?.view.collectionViewLayout as? MosaicCollectionViewLayout)?.headerHeight = 100
            }
            else {
                (_collectionNode?.view.collectionViewLayout as? MosaicCollectionViewLayout)?.headerHeight = 60
            }
        }
    }
	
	init(collectionNode: ASCollectionNode, viewController: UIViewController) {
		super.init()
		
		_layoutInspector = MosaicCollectionViewLayoutInspector()
		collectionNode.view.layoutInspector = _layoutInspector
		collectionNode.delegate = self
		collectionNode.dataSource = self
		collectionNode.view.leadingScreensForBatching = 10
		collectionNode.view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
		collectionNode.view.dataController
		collectionNode.view.addLoadingManager(nil, loadingManagerDelegate: self, scrollDirection: .Vertical)
		(collectionNode.view.collectionViewLayout as? MosaicCollectionViewLayout)?.headerHeight = 60
        
		collectionNode.view.registerSupplementaryNodeOfKind(UICollectionElementKindSectionHeader)
        collectionNode.view.registerSupplementaryNodeOfKind(UICollectionElementKindSectionFooter)
		
		//Add refresh control
		collectionNode.view.addRefreshControl(self, action: #selector(FeedDataSource.refresh(_:)), tintColor: UIColor.appPurpleColor())
		
		_collectionNode = collectionNode
		_viewController = viewController
        
        // Add listener to post UI Updater
        BDFUIUpdaterManager.sharedManager.addPostUIUpdater(self)
	}
	
	deinit {
        // Remove listener to post UI Updater
        BDFUIUpdaterManager.sharedManager.removePostUIUpdater(self)
        
		self._collectionNode?.delegate = nil
		self._collectionNode?.dataSource = nil
		_layoutInspector = nil
	}
	
	//MARK: Private methods
	private func goToPostAtIndex(index: Int) {
		guard var _posts = _posts else {
			return
		}
		
		let singlePostViewController = SinglePostViewController()
		singlePostViewController.post = _posts[index]
		self._viewController?.navigationController?.pushViewController(singlePostViewController, animated: true)
	}
	
	func removePost(post: Post) {
		guard var posts = _posts else {
			return
		}
		
		for (index, _post) in posts.enumerate() {
			if post.postId == _post.postId {
				posts.removeAtIndex(index)
				cachedSizes.removeAtIndex(index)
				let indexPath = NSIndexPath(forItem: index, inSection: 0)
				_collectionNode?.view.deleteItemsAtIndexPaths([indexPath])
			}
		}
	}
    
    ///
    /// Notify post info changes
    ///
    func notifyPostInfoChanges() {
        for post in _changedPosts {
            BDFUIUpdaterManager.sharedManager.postInfoChanged(post)
        }
        
        // Remove all posts from array
        _changedPosts.removeAll()
    }
	
	//MARK: AdBannderNodeDelegate
	func adBannderNodeDidTapped() {
		if NativeXSDK.isAdFetchedWithName(String.NativeXOfferWallPlacementName()) {
			NativeXSDK .showAdWithName(String.NativeXOfferWallPlacementName())
		}
	}
	
	//MARK: ASCollectionDataSource + ASCollectionDelegate
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let _posts = _posts else {
            if contentStatus == .NotLoaded {
                collectionView.userInteractionEnabled = false
                return Int(collectionView.bounds.size.height/TimelinePlaceHolderNode.defaultHeight())*2
            }
            
			collectionView.userInteractionEnabled = true
            return 0
		}
		
		collectionView.userInteractionEnabled = true
		return _posts.count
	}
	
	func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
		guard var _posts = _posts else {
			return {
				return TimelinePlaceHolderNode()
			}
		}
		
		return {
            let post = _posts[indexPath.row]
			let node = SinglePostNode(post: post)
			node.nodeDelegate = self
            
            // _biggestAnimatedItem is always smaller than the next loaded items' indexPath when reload collection view and have not been scrolled down
            // so we can base on it to know the first nodes that are created on top of collection view
            if self._biggestAnimatedItem >= indexPath.row {
                //node.loadNetworkingData(post)
            }
            
			return node
		}
	}
	
	func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
		return ASSizeRange(min: CGSizeZero, max: CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 20
	}
	
	func collectionView(collectionView: ASCollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 10
	}
	
	func collectionView(collectionView: UICollectionView!, layout: MosaicCollectionViewLayout!, originalItemSizeAtIndexPath indexPath: NSIndexPath!) -> CGSize {
		//Get item width
		let totalWidth = (collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right) - CGFloat(layout.numberOfColumns - 1) * layout.columnSpacing
		let itemWidth = totalWidth/CGFloat(layout.numberOfColumns)
		
		
		//Placeholder cell node
		guard var posts = _posts else {
			return CGSize(width: itemWidth, height: TimelinePlaceHolderNode.defaultHeight())
		}
		
		//Get cache height
		if cachedSizes.count > indexPath.row && cachedSizes[indexPath.row] != CGSizeZero  {
			return cachedSizes[indexPath.row]
		}
		
		//Calculate height
		if indexPath.row >= posts.count {
			return CGSizeZero
		}
        
		let itemHeight = SinglePostNode.nodeHeightWithWidth(itemWidth, post: posts[indexPath.row])
		cachedSizes[indexPath.row] = CGSize(width: itemWidth, height: itemHeight)
		return cachedSizes[indexPath.row]
	}
	
	func collectionView(collectionView: ASCollectionView, nodeForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> ASCellNode {
        // If timeline has no content, display message
        if contentStatus == DTContentStatus.NoContent || contentStatus == DTContentStatus.ErrorLoad {
            let node = DTTextCellNode(font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Center, textInsets: UIEdgeInsets(top: 20, left: CGFloat.leftMargin, bottom: 20, right: CGFloat.rightMargin))
            
            if contentStatus == .NoContent {
                node.text = "No posts yet. Add new friends and starts checking their activities."
            }
            else if contentStatus == .ErrorLoad {
                node.text = "There is no problem loading newsfeed. Please try again."
            }
        
            node.setUpAsHeader()
            return node
        }
        
        // Otherwise display ad banner
        let node = AdBannderNode1()
        node.delegate = self
        return node
	}
	
	//MARK: ASCollectionViewLayoutInspecting
	//    func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
	//        let totalWidth = (collectionView.frame.size.width - kHorizontalSpacing*2) - CGFloat(kNumberOfColumns - 1) * kColumnSpacing
	//        let itemWidth = totalWidth/CGFloat(kNumberOfColumns)
	//        var maxSize: CGSize
	//        if indexPath.row >= self.posts.count {
	//            maxSize = CGSizeZero
	//        }
	//        else {
	//            let itemHeight = ProfilePostNode.nodeHeightWithWidth(itemWidth, post: posts[indexPath.row])
	//            maxSize = CGSize(width: itemWidth, height: itemHeight)
	//        }
	//
	//        return ASSizeRange(min: CGSizeZero, max: maxSize)
	//    }
	//
	//    func collectionView(collectionView: ASCollectionView!, constrainedSizeForSupplementaryNodeOfKind kind: String!, atIndexPath indexPath: NSIndexPath!) -> ASSizeRange {
	//        return ASSizeRange(min: CGSizeZero, max: CGSizeZero)
	//    }
	//
	//    func collectionView(collectionView: ASCollectionView!, numberOfSectionsForSupplementaryNodeOfKind kind: String!) -> UInt {
	//        return 0
	//    }
	//
	//    func collectionView(collectionView: ASCollectionView!, supplementaryNodesOfKind kind: String!, inSection section: UInt) -> UInt {
	//        return 0
	//    }
}

extension FeedDataSource {
	//MARK: LoadingManagerDelegate
	func loadingManagerLoaderDidStartAnimating(loadingManager: LoadingManager) {
		loadMorePosts { (succeeded) in
			loadingManager.scrollView?.stopLoading()
		}
	}
	
	func loadMorePosts(completionHandler: ((Bool) -> Void)?) {
		self.loadData(refreshing: false, animated: false, completionHandler: completionHandler)
	}
	
	internal func refresh(refreshControl: UIRefreshControl?) {
        // Remove next link
        _nextPageString = nil
        
		//Invalidate size of all cells
		if let posts = _posts {
			for (index, _) in posts.enumerate() {
				let indexPath = NSIndexPath(forItem: index, inSection: 0)
				if let node = _collectionNode?.view.nodeForItemAtIndexPath(indexPath) {
					node.invalidateCalculatedLayout()
				}
			}
		}
		
		if !PLACEHOLDER_TEST {
			if let _ = refreshControl {
				self.loadData(refreshing: true, animated: true, completionHandler: nil)
			}
			else {
				self.loadData(refreshing: true, animated: true, completionHandler: nil)
			}
		}
	}
	
	func loadData(refreshing refresh: Bool, animated: Bool, completionHandler: ((Bool) -> Void)?) {
        BDFAuthenticatedUser.currentUser.getTimelinePosts(_nextPageString, successBlock: {[weak self] (posts: [Post]?, nextPageString: String?) in
            guard let _self = self else {
                return
            }
            
            if let newPosts = posts {
                //If we are refreshing the content
                if refresh {
                    //Reset animated index to zero
                    _self._biggestAnimatedItem = 0
                    
                    //Create new array <-- easy way
                    _self._posts = []
                    _self.cachedSizes.removeAll()
                    
                    // Update content status
                    if newPosts.count == 0 {
                        _self.contentStatus = DTContentStatus.NoContent
                        _self._collectionNode?.view.shouldAnimating = false
                    }
                    else {
                        _self.contentStatus = DTContentStatus.Loaded
                        _self._collectionNode?.view.shouldAnimating = true
                    }
                    
                    // Update data before reload list
                    _self._posts = _self._posts! + newPosts
                    let newSizes = Array(count:newPosts.count, repeatedValue:CGSizeZero)
                    _self.cachedSizes = _self.cachedSizes + newSizes
                    
                    // Reload
                    _self._collectionNode?.view.reloadDataWithCompletion({
                        if animated {
                            //Reset content offset + shouldAnimating
                            _self._collectionNode?.view.refreshControl?.endRefreshing()
                        }
                    })
                }
                else {
                    guard let _posts = _self._posts else {
                        fatalError("_posts is nil")
                    }
                    
                    if newPosts.count == 0 {
                        //Prevent to load more the next time
                        self?._collectionNode?.view.shouldAnimating = false
                        completionHandler?(true)
                        return
                    }
                    
                    var indexPaths = [NSIndexPath]()
                    for i in _posts.count...(_posts.count + newPosts.count - 1) {
                        let indexPath = NSIndexPath(forItem: i, inSection: 0)
                        indexPaths.append(indexPath)
                    }
                    
                    _self._posts = _posts + newPosts
                    let newSizes = Array(count:newPosts.count, repeatedValue:CGSizeZero)
                    _self.cachedSizes = _self.cachedSizes + newSizes
                    
                    _self._collectionNode?.view.insertItemsAtIndexPaths(indexPaths)
                    completionHandler?(true)
                }
                
                //Get next link
                _self._nextPageString = nextPageString
                
                // Disable load more
                if _self._nextPageString == nil {
                    self?._collectionNode?.view.shouldAnimating = false
                }
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
            
            completionHandler?(true)
            self?._collectionNode?.view.refreshControl?.endRefreshing()
            self?._collectionNode?.view.userInteractionEnabled = true
            DTLog(error?.description)
        }
	}
}

extension FeedDataSource: SinglePostNodeDelegate {
    //MARK: ProfilePostNodeDelegate
    func singlePostNodeCommentNumberButtonTapped(node: SinglePostNode) {
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            self.goToPostAtIndex(indexPath.row)
        }
    }
    
    func singlePostNodeCommentButtonTapped(node: SinglePostNode) {
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            self.goToPostAtIndex(indexPath.row)
        }
    }
    func singlePostNodeImageViewTapped(node: SinglePostNode) {
        //Present Image viewwer
        if let photoViewerController = DTPhotoViewerController(referenceView: node.postPhotoNode.view, image: node.postPhotoNode.image) {
            _viewController?.presentViewController(photoViewerController, animated: true, completion: nil)
        }
    }
    
    func singlePostNodeLikeButtonTapped(button: ASButtonNode, node: SinglePostNode) {
        // We just need to update post data model, KVO will handle UI Change, so no setting selected to button
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            if let post = _posts?[indexPath.row] {
                if button.selected {
                    // Update likes
                    post.numberOfLikes += 1
                    
                    // Like the post
                    BDFAuthenticatedUser.currentUser.likePost(post.postId, successBlock: { 
                        // Update post like
                        post.liked = true
                        
                        if let _ = self._changedPosts.indexOf({$0 === post}) {
                            // Do nothing
                        }
                        else {
                            // Add to array of post info changed
                            self._changedPosts.append(post)
                        }
                        
                        }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                            // Update like button
                            post.numberOfLikes -= 1
                            post.liked = false
                    })
                }
                else {
                    // Update likes
                    post.numberOfLikes -= 1
                    
                    // Unlike the post
                    BDFAuthenticatedUser.currentUser.unlikePost(post.postId, successBlock: {
                        // Update post like
                        post.liked = false
                        if let _ = self._changedPosts.indexOf({$0 === post}) {
                            // Do nothing
                        }
                        else {
                            // Add to array of post info changed
                            self._changedPosts.append(post)
                        }
                        
                        }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                            // Update like button
                            post.numberOfLikes += 1
                            post.liked = true
                    })
                }
            }
        }
    }
    
    
    func singlePostNodeLikeNumberButtonTapped(node: SinglePostNode) {
        
        if let indexPath = _collectionNode?.view.indexPathForNode(node){
            guard let post = _posts?[indexPath.row] else {
                fatalError("Something is wrong, _posts is nil")
            }
            
            let type = UserListType.Likers(post.postId)
            let likerViewController = UserListViewController(type: type)
            self._viewController?.navigationController?.pushViewController(likerViewController, animated: true)
            
        }
    }
    
    func singlePostNodeProfileImageViewTapped(node: SinglePostNode) {
        guard var posts = _posts else {
            return
        }
        
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            let profileViewController = ProfileViewController()
            profileViewController.user = posts[indexPath.row].owner!
            _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}

//MARK: BDFPostUIUpdater
extension FeedDataSource: BDFPostUIUpdater {
    func updaterAddNewPost(post: Post) {
        // Add new post to timeline
        if let _ = _posts {
            cachedSizes.insert(CGSizeZero, atIndex: 0)
            _posts?.insert(post, atIndex: 0)
            let indexPath = NSIndexPath(forItem: 0, inSection: 0)
            _collectionNode?.view.insertItemsAtIndexPaths([indexPath])
        }
    }
    
    func updaterUpdateUIWithPost(post: Post) {
        // Update post info
        if let posts = _posts {
            for _post in posts {
                if _post.isIdentical(post) {
                    _post.numberOfLikes = post.numberOfLikes
                    _post.liked = post.liked
                    _post.numberOfComments = post.numberOfComments
                }
            }
        }
        
    }
    
    func updaterDeletePost(post: Post) {
        // Delete post in timeline
        if let posts = _posts {
            for (index, _post) in posts.enumerate() {
                if _post.isIdentical(post) {
                    // Remove post from array
                    cachedSizes.removeAtIndex(index)
                    _posts?.removeAtIndex(index)
                    
                    //Delete cell
                    let indexPath = NSIndexPath(forItem: index, inSection: 0)
                    _collectionNode?.view.deleteItemsAtIndexPaths([indexPath])
                }
            }
        }
    }
}

