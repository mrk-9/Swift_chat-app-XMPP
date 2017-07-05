//
//  DTParallaxScrollViewController.swift
//  Pods
//
//  Created by Tung Vo  on 07/05/16.
//
//

import UIKit

///
/// Class DTParallaxScrollViewController
///
public class DTParallaxScrollViewController: UIViewController, UIScrollViewDelegate {
    ///
    /// Delegate
    ///
    public weak var delegate: DTParallaxScrollViewDelegate? {
        //Remove old header view before adding new one
        set {
            _parallaxScrollView.parallaxDelegate = newValue
        }
        
        get {
            return _parallaxScrollView.parallaxDelegate
        }
    }
    
    ///
    /// Parallax scroll view
    /// Note: parallaxScrollView access could be removed in the future.
    ///
    private var _parallaxScrollView: DTParallaxScrollView!
    public var parallaxScrollView: DTParallaxScrollView! {
        return _parallaxScrollView
    }
    
    ///
    /// Header height
    /// Default value is 100.
    ///
    public var headerHeight: CGFloat {
        set {
            //Update after setting new header height
            _parallaxScrollView.headerHeight = newValue
        }
        
        get {
            return _parallaxScrollView.headerHeight
        }
    }
    
    ///
    /// External scroll view
    /// scrollEnabled should not be set to true for DTParallaxScrollViewController to work properly.
    /// The only way to set external scroll view is via initializer so it is safe here.
    ///
    private var _externalScrollView: UIScrollView! {
        didSet {
            _parallaxScrollView = DTParallaxScrollView(frame: CGRectZero, scrollView: _externalScrollView)
        }
    }
    
    public var externalScrollView: UIScrollView! {
        return _externalScrollView
    }
    
    ///
    /// Update block based on content offset of internal scroll view.
    /// CGFloat is vertical offet of internal scroll view.
    /// Bool indicates if header view is visible from scroll view.
    ///
    public var updateBlock: ((CGFloat, Bool) -> Void)? {
        set {
            _parallaxScrollView.updateBlock = newValue
        }
        
        get {
            return _parallaxScrollView.updateBlock
        }
    }
    
    public init(scrollView: UIScrollView, headerHeight: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        
        //Do common init
        _commonInit(scrollView)
        
        self.headerHeight = headerHeight
    }
    
    public init(scrollView: UIScrollView) {
        super.init(nibName: nil, bundle: nil)
        
        //Do common init
        _commonInit(scrollView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _commonInit(scrollView: UIScrollView) {
        _externalScrollView = scrollView
    }
    
    //MARK: UIViewController
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set frame for _parallaxScrollView
        _parallaxScrollView.frame = self.view.bounds
        
        if let navigationController = self.navigationController {
            _parallaxScrollView.frame.size.height -= (navigationController.navigationBar.translucent == false) ? navigationController.navigationBar.frame.height : 0
            
            if !UIApplication.sharedApplication().statusBarHidden && navigationController.navigationBar.translucent == false {
                _parallaxScrollView.frame.size.height -= 20
            }
        }
        
        if let tabBarController = self.tabBarController {
            _parallaxScrollView.frame.size.height -= (tabBarController.tabBar.translucent == false) ? tabBarController.tabBar.frame.height : 0
        }
        
        
        self.view.addSubview(_parallaxScrollView)
    }
}
