//
//  ContentOffsetManager.swift
//  Buddify
//
//  Created by Vo Duc Tung on 01/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import BLMultiColorLoader

private let kLoaderSize: CGFloat = 30

enum ScrollDirection {
    case Vertical
    case Horizontal
}

protocol LoadingManagerDelegate: NSObjectProtocol {
    func loadingManagerLoaderDidStartAnimating(loadingManager: LoadingManager)
}

class LoadingManager: NSObject {
    weak var delegate: LoadingManagerDelegate?
    
    var scrollDirection: ScrollDirection = .Vertical {
        didSet {
            guard let _scrollView = scrollView else {
                return
            }
            
            if scrollDirection == .Vertical {
                loader.frame.origin = CGPoint(x: (_scrollView.frame.size.width - kLoaderSize)/2, y: _scrollView.contentSize.height + (_scrollView.contentInset.bottom - 49 - kLoaderSize)/2)
            }
            else {
                loader.frame.origin = CGPoint(x: _scrollView.contentSize.width - _scrollView.contentInset.right + _scrollView.contentInset.right/2, y: (_scrollView.frame.size.height - kLoaderSize)/2)
            }
        }
    }
    
    var thresHold: CGFloat = 100
    var loader: BLMultiColorLoader!
    private var insetValue: CGFloat!
    
    weak var scrollView: UIScrollView? {
        willSet {
            scrollView?.removeObserver(self, forKeyPath: "contentOffset")
            scrollView?.removeObserver(self, forKeyPath: "contentSize")
        }
        
        didSet {
            scrollView?.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
            scrollView?.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        }
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
        scrollView?.removeObserver(self, forKeyPath: "contentSize")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillResignActiveNotification, object: nil)
    }
    
    convenience init(scrollView: UIScrollView!, size _size: CGSize?, delegate: LoadingManagerDelegate?, scrollDirection: ScrollDirection) {
        self.init()
        
        var size = _size
        
        if size == nil {
            size = CGSize(width: kLoaderSize, height: kLoaderSize)
        }
        
        self.scrollView = scrollView
        self.delegate = delegate
        self.scrollDirection = scrollDirection
        
        if scrollDirection == .Vertical {
            DTLog(scrollView.contentInset)
            insetValue = size!.height + 40
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: insetValue, right: 0)
        }
        else {
            insetValue = size!.width + 40
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetValue)
        }
        
        loader = BLMultiColorLoader(frame: CGRect(origin: CGPointZero, size: size!))
        loader.colorArray = UIColor.appGradientColors()
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
        scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        scrollView.addSubview(loader)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: UIApplicationWillResignActiveNotification, object: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let _scrollView = scrollView else {
            return
        }
        
        if keyPath == "contentOffset" {
            if let newOffset = (change?[NSKeyValueChangeNewKey] as? NSValue)?.CGPointValue() {
                let shouldAnimate = self.scrollView?.shouldAnimating ?? true
                if scrollDirection == .Vertical {
                    //Should load more only at bottom and offset is big enough (prevent blank scroll view loading)
                    if _scrollView.contentSize.height - _scrollView.bounds.size.height - newOffset.y < thresHold && newOffset.y > thresHold {
                        if !loader.isAnimating() && shouldAnimate {
                            loader.startAnimation()
                            self.delegate?.loadingManagerLoaderDidStartAnimating(self)
                        }
                    }
                }
                else {
                    if _scrollView.contentSize.width - _scrollView.bounds.size.width - newOffset.x < thresHold && newOffset.x > thresHold {
                        if !loader.isAnimating() && shouldAnimate {
                            loader.startAnimation()
                            self.delegate?.loadingManagerLoaderDidStartAnimating(self)
                        }
                    }
                }
            }
        }
        else if keyPath == "contentSize" {
            if let newSize = (change?[NSKeyValueChangeNewKey] as? NSValue)?.CGSizeValue() {
                if scrollDirection == .Vertical {
                    loader.frame.origin = CGPoint(x: (_scrollView.frame.size.width - kLoaderSize)/2, y: newSize.height + _scrollView.contentInset.top + (insetValue - kLoaderSize)/2)
                }
                else {
                    loader.frame.origin = CGPoint(x: newSize.width + _scrollView.contentInset.left + (insetValue - kLoaderSize)/2, y: (_scrollView.frame.size.height - kLoaderSize)/2)
                }
            }
        }
    }
    
    internal func applicationWillResignActive(notification: NSNotification) {
        loader.stopAnimation()
    }
}
