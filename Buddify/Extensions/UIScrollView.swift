//
//  UITableView.swift
//  Buddify
//
//  Created by Vo Duc Tung on 28/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

private var loadingManagerKey: UInt8 = 1
private var shouldAnimatingKey: UInt8 = 2
private var refreshControlKey: UInt8 = 3

extension UIScrollView {
    var loadingManager : LoadingManager?{
        get {
            return objc_getAssociatedObject(self, &loadingManagerKey) as? LoadingManager
        }
        set(newValue) {
            objc_setAssociatedObject(self, &loadingManagerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var shouldAnimating : Bool{
        get {
            return objc_getAssociatedObject(self, &shouldAnimatingKey) as! Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &shouldAnimatingKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var refreshControl: UIRefreshControl? {
        set {
            objc_setAssociatedObject(self, &refreshControlKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &refreshControlKey) as? UIRefreshControl
        }
    }
    
    func addLoadingManager(size: CGSize?, loadingManagerDelegate delegate: LoadingManagerDelegate, scrollDirection: ScrollDirection) {
        self.shouldAnimating = true
        let loadingManager = LoadingManager(scrollView: self, size: size, delegate: delegate, scrollDirection: scrollDirection)
        self.loadingManager = loadingManager
    }
    
    /* Need to call before the scrollView is deallocated */
    func removeLoadingManager() {
        self.loadingManager = nil
    }
    
    func startLoading() {
        self.loadingManager?.loader.startAnimation()
    }
    
    func stopLoading() {
        self.loadingManager?.loader.stopAnimation()
    }
    
    func addRefreshControl(target: AnyObject?, action: Selector, tintColor: UIColor) {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = tintColor
        refreshControl?.addTarget(target, action: action, forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(refreshControl!)
    }
}
