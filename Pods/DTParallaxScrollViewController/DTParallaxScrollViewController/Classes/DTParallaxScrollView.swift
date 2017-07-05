//
//  DTParallaxScrollView.swift
//  Pods
//
//  Created by Tung Vo  on 16/05/16.
//
//

import Foundation

///
/// Protocol DTParallaxScrollViewControllerDelegate
///
public protocol DTParallaxScrollViewDelegate: class {
    func parallaxScrollViewViewForHeader(view: DTParallaxScrollView) -> UIView
}

///
/// Class DTParallaxScrollView
///
public class DTParallaxScrollView: UIScrollView, UIScrollViewDelegate {
    ///
    /// Delegate
    ///
    public weak var parallaxDelegate: DTParallaxScrollViewDelegate? {
        //Remove old header view before adding new one
        willSet {
            if let headerView = parallaxDelegate?.parallaxScrollViewViewForHeader(self) {
                headerView.removeFromSuperview()
            }
        }
        
        //Add new header view
        didSet {
            if delegate !== oldValue {
                if let headerView = parallaxDelegate?.parallaxScrollViewViewForHeader(self) {
                    self.insertSubview(headerView, atIndex: 0)
                }
            }
        }
    }
    
    ///
    /// Update block based on content offset of internal scroll view.
    /// CGFloat is vertical offet of internal scroll view.
    /// Bool indicates if header view is visible from scroll view.
    ///
    public var updateBlock: ((CGFloat, Bool) -> Void)?
    
    ///
    /// Header height
    /// Default value is 100.
    ///
    public var headerHeight: CGFloat = 100 {
        didSet {
            //Update after setting new header height
        }
    }
    
    ///
    /// External scroll view
    /// scrollEnabled should not be set to true for DTParallaxScrollViewController to work properly.
    ///
    private var _externalScrollView: UIScrollView!
    
    public var externalScrollView: UIScrollView! {
        return _externalScrollView
    }
    
    public convenience init(frame: CGRect, scrollView: UIScrollView, headerHeight: CGFloat) {
        self.init(frame: frame)
        _externalScrollView = scrollView
        self.headerHeight = headerHeight
        
        //Do common init
        _commonInit()
    }
    
    public convenience init(frame: CGRect, scrollView: UIScrollView) {
        self.init(frame: frame)
        _externalScrollView = scrollView
        
        //Do common init
        _commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    ///
    /// Common initializer
    ///
    private func _commonInit() {
        _externalScrollView.scrollEnabled = false
        self.addSubview(_externalScrollView)
        self.delegate = self
        
        // Add KVO for _externalScrollView, keypath contentSize so we can update content size
        // of _internalScrollView whenever it needs to change.
        _externalScrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        _externalScrollView.addObserver(self, forKeyPath: "contentInset", options: NSKeyValueObservingOptions.New, context: nil)
        
        // Add KVO for frame
        self.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
        
        _updateExternalScrollPosition()
    }
    
    //Deinitializer
    deinit {
        _externalScrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    ///
    /// Helper method to update correct frame of _externalScrollView
    ///
    private func _updateExternalScrollPosition() {
        var frame = self.bounds
        frame.origin.y = self.headerHeight
        _externalScrollView.frame = frame
    }
    
    ///
    /// Handle contentSize change.
    ///
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if object === _externalScrollView {
            if keyPath == "contentSize" || keyPath == "contentInset" {
                //Update content size of _internalScrollView based on contentSize and contentInset of _externalScrollView
                self.contentSize = CGSize(width: 0, height: _externalScrollView.contentSize.height + headerHeight + _externalScrollView.contentInset.top + _externalScrollView.contentInset.bottom)
            }
        }
        else if object === self {
            if keyPath == "frame" {
                //Update frame of external scroll view
                _updateExternalScrollPosition()
            }
        }
    }
}

//MARK: UIScrollViewDelegate
extension DTParallaxScrollView {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        // If scroll view scrolls over header height space
        // external scroll view y-position has to be updates
        // for every scroll
        if scrollView.contentOffset.y > headerHeight {
            // Make update so that scroll view is always on top
            _externalScrollView.frame.origin.y = scrollView.contentOffset.y
            
            // Make update content offset, should also consider the contentInset
            _externalScrollView.contentOffset.y = scrollView.contentOffset.y - headerHeight - _externalScrollView.contentInset.top
            updateBlock?(scrollView.contentOffset.y, false)
        }
        else {
            // Otherwise reset external scroll view back to original position
            if _externalScrollView.frame.origin.y != headerHeight {
                _externalScrollView.frame.origin.y = headerHeight
            }
            
            //Reset content offset
            if _externalScrollView.contentOffset.y != 0 {
                // Should also consider the contentInset
                _externalScrollView.contentOffset.y = -_externalScrollView.contentInset.top
            }
            
            updateBlock?(scrollView.contentOffset.y, true)
        }
    }
}
