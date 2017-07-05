//
//  ProfilePostDataSource.swift
//  Buddify
//
//  Created by Vo Duc Tung on 11/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import LoremIpsum
import AFDateHelper
import pop
import DTPhotoViewerController
import Models

///
/// Class ProfilePostDataSource
/// This class provide data to ProfileViewController
///
class ProfilePostDataSource: NSObject, ASCollectionDataSource, ASCollectionDelegate, ASCollectionViewDelegateFlowLayout, ProfilePostNodeDelegate, LoadingManagerDelegate, AdBannderNodeDelegate {
    var userId: Int64?
    weak var _collectionNode: ASCollectionNode?
    weak var _viewController: UIViewController?

    weak var bigImageButton: UIImageView?
    //This is for testing purpose
    private var _posts: [Post]?
    private var _layoutInspector: MosaicCollectionViewLayoutInspector!
    private var _nextPageString: String?
    
    //Last biggest item index
    private var biggestAnimatedItem = 0
    
    // Content status of the list
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
    
    /* This array of sizes is some hack for smoothness, this value should be updated whenever there are changes in collectionNode like inserting, removing nodes */
    private var cachedSizes = [CGSize]()
    
    private let kAdBannerHeaderIdentifier = "AdBannerHeaderIdentifier"
    
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
        
        //Add refresh control
        collectionNode.view.addRefreshControl(self, action: #selector(ProfilePostDataSource.refresh(_:)), tintColor: UIColor.appPurpleColor())
        
        _collectionNode = collectionNode
        _viewController = viewController
        
        // Add ui update observer
        BDFUIUpdaterManager.sharedManager.addPostUIUpdater(self)
    }
    
    deinit {
        _collectionNode?.delegate = nil
        _collectionNode?.dataSource = nil
        _layoutInspector = nil
        
        // Remove ui update observer
        BDFUIUpdaterManager.sharedManager.removePostUIUpdater(self)
    }
    
    //MARK: Private methods
    private func goToPostAtIndex(index: Int) {
        guard var posts = _posts else {
            return
        }
        
        let singlePostViewController = SinglePostViewController()
        singlePostViewController.post = posts[index]
        _viewController?.navigationController?.pushViewController(singlePostViewController, animated: true)
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

    //MARK: ProfilePostNodeDelegate
    func timelineNodeCommentNumberButtonTapped(node: ProfilePostNode) {
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            self.goToPostAtIndex(indexPath.row)
        }
    }
    
    func timelineNodeImageViewTapped(node: ProfilePostNode) {
        //Present Image viewwer
        if let photoViewerController = DTPhotoViewerController(referenceView: node.postPhotoNode.view, image: node.postPhotoNode.image) {
            _viewController?.presentViewController(photoViewerController, animated: true, completion: nil)
        }
    }
    
    func timelineNodeLikeButtonTapped(button: ASButtonNode, node: ProfilePostNode) {
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            if let post = _posts?[indexPath.row] {
                if button.selected {
                    // Update likes
                    post.numberOfLikes += 1
                    
                    // Like the post
                    BDFAuthenticatedUser.currentUser.likePost(post.postId, successBlock: {
                        // Update post like
                        post.liked = true
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
                        }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                            // Update like button
                            post.numberOfLikes += 1
                            post.liked = true
                    })
                }
            }
        }
    }
    
    func timelineNodeLikeNumberButtonTapped(node: ProfilePostNode) {
        if let indexPath = _collectionNode?.view.indexPathForNode(node){
            guard let post = _posts?[indexPath.row] else {
                fatalError("Something is wrong, _posts is nil")
            }
            
            let type = UserListType.Likers(post.postId)
            let likerViewController = UserListViewController(type: type)
            _viewController?.navigationController?.pushViewController(likerViewController, animated: true)
            
        }
    }
    
    func timelineNodeProfileImageViewTapped(node: ProfilePostNode) {
        guard var posts = _posts else {
            return
        }
        
        if let indexPath = _collectionNode?.view.indexPathForNode(node) {
            let profileViewController = ProfileViewController()
            profileViewController.user = posts[indexPath.row].owner!
            _viewController?.navigationController?.pushViewController(profileViewController, animated: true)
        }
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
        guard let posts = _posts else {
            // Only show placeholder nodes if content has not been loaded
            if contentStatus == .NotLoaded {
                collectionView.userInteractionEnabled = false
                return Int(collectionView.bounds.size.height/TimelinePlaceHolderNode.defaultHeight())*2
            }
            
            // Otherwise return 0
            collectionView.userInteractionEnabled = true
            return 0
        }
        
        collectionView.userInteractionEnabled = true
        return posts.count
    }
    
    func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        guard var posts = _posts else {
            return {
                return TimelinePlaceHolderNode()
            }
        }
        
        return {
            let node = ProfilePostNode(post: posts[indexPath.row])
            node.nodeDelegate = self
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //If not tapping placeholder cell node
        guard let posts = _posts else {
            return
        }
        
        if indexPath.row < posts.count {
            self.goToPostAtIndex(indexPath.row)
        }
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
        let itemHeight = ProfilePostNode.nodeHeightWithWidth(itemWidth, post: posts[indexPath.row])
        cachedSizes[indexPath.row] = CGSize(width: itemWidth, height: itemHeight)
        return cachedSizes[indexPath.row]
    }
    
    func collectionView(collectionView: ASCollectionView, nodeForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> ASCellNode {
        // Show message if there is no content
        if contentStatus == .NoContent || contentStatus == .ErrorLoad {
            let node = DTTextCellNode(font: UIFont.appFont(CGFloat.normalFontSize), textColor: UIColor.blackColor(), textAlignment: NSTextAlignment.Center, textInsets: UIEdgeInsets(top: 20, left: CGFloat.leftMargin, bottom: 20, right: CGFloat.rightMargin))
            node.setUpAsHeader()
            
            if contentStatus == .NoContent {
                node.text = "User has not posted anything yet."
            }
            else if contentStatus == .ErrorLoad {
                node.text = "There is problem loading posts. Please try again."
            }
            
            return node
        }
        
        // Otherwise show ad
        let node = AdBannderNode1()
        node.delegate = self
        return node
    }
    
    func collectionView(collectionView: ASCollectionView, willDisplayNodeForItemAtIndexPath indexPath: NSIndexPath) {
        //SHould not animate placeholder cell node
        if indexPath.row > biggestAnimatedItem && _posts != nil {
            //Update biggest index
            biggestAnimatedItem = indexPath.row
            
            //Add animation
            let node = collectionView.nodeForItemAtIndexPath(indexPath)
            let animation: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            animation.fromValue = NSValue(CGPoint: CGPoint(x: 0.7, y: 0.7))
            animation.toValue = NSValue(CGPoint: CGPoint(x: 1, y: 1))
            animation.springSpeed = 10
            animation.springBounciness = 10
            node.view.pop_addAnimation(animation, forKey: "scaleAnimation")
        }
    }
}

extension ProfilePostDataSource {
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
        if refresh {
            // Remove next page
            _nextPageString = nil
        }
        
        BDFAuthenticatedUser.currentUser.getPostsFromUserWithUserId(self.userId!, nextPageString: _nextPageString, successBlock: {[weak self] (posts: [Post]?, nextPageString: String?) in
            guard let _self = self else {
                return
            }
            
            //If we are refreshing the content
            if let newPosts = posts {
                if refresh {
                    //Reset animated index to zero
                    _self.biggestAnimatedItem = 0
                    
                    //Create new array <-- easy way
                    _self._posts = []
                    _self.cachedSizes.removeAll()
                    
                    // Change content status
                    if newPosts.count == 0 {
                        _self.contentStatus = .NoContent
                        _self._collectionNode?.view.shouldAnimating = false
                    }
                    else {
                        _self.contentStatus = .Loaded
                        _self._collectionNode?.view.shouldAnimating = true
                    }
                    
                    _self._posts = _self._posts! + newPosts
                    let newSizes = Array(count:newPosts.count, repeatedValue:CGSizeZero)
                    _self.cachedSizes = _self.cachedSizes + newSizes
                    
                    _self._collectionNode?.view.reloadDataWithCompletion({
                        if animated {
                            //Reset content offset + shouldAnimating
                            _self._collectionNode?.view.refreshControl?.endRefreshing()
                        }
                        
                        completionHandler?(true)
                    })
                }
                else {
                    // Change content status
                    _self.contentStatus = .Loaded
                    
                    guard let _posts = _self._posts else {
                        return
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
            
            self?._collectionNode?.view.refreshControl?.endRefreshing()
            self?._collectionNode?.view.userInteractionEnabled = true
            self?.contentStatus = .ErrorLoad
            DTLog(error?.description)
        }
    }
}

//MAARK: BDFPostUIUpdater

///
/// Sync Post data in the app when a post is updated or deleted or new post is posted
///
extension ProfilePostDataSource: BDFPostUIUpdater {
    func updaterAddNewPost(post: Post) {
        // Add new post if this is owner of the post
        if post.owner.userId == self.userId {
            if let _ = _posts {
                cachedSizes.insert(CGSizeZero, atIndex: 0)
                _posts?.insert(post, atIndex: 0)
                let indexPath = NSIndexPath(forItem: 0, inSection: 0)
                _collectionNode?.view.insertItemsAtIndexPaths([indexPath])
            }
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
        // Delete post if same owner
        if post.owner.userId == self.userId {
            if let posts = _posts {
                for (index, _post) in posts.enumerate() {
                    if _post.isIdentical(post) {
                        // Remove post from array
                        _posts?.removeAtIndex(index)
                        
                        //Delete cell
                        let indexPath = NSIndexPath(forItem: index, inSection: 0)
                        _collectionNode?.view.deleteItemsAtIndexPaths([indexPath])
                    }
                }
            }
        }
    }
}
