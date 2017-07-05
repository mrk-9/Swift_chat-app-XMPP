//
//  PagerViewController.swift
//  Sportademo
//
//  Created by Vo Duc Tung on 07/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

@objc public protocol PagerViewControllerDelegate: NSObjectProtocol {
    optional func pagerViewControllerSelectedIndexDidChange(pagerViewController: PagerViewController, selectedIndex: Int)
    optional func pagerViewControllerSelectedIndexWillChange(pagerViewController: PagerViewController, oldSelectedIndex: Int, newSelectedIndex: Int)
    optional func pagerViewControllerSelectedIndexProbablyChange(pagerViewController: PagerViewController, oldSelectedIndex: Int, newSelectedIndex: Int)
}


public class PagerViewController : UIViewController, UIScrollViewDelegate {
    //Public variables
    var bar : UIView!
    
    ///
    /// Delegate
    ///
    public weak var delegate: PagerViewControllerDelegate?
    
    ///
    /// Height of segmented bar.
    /// Default value is 44.
    ///
    public var segmentedBarHeight: CGFloat = 44 {
        didSet {
            
        }
    }
    
    ///
    /// Height of segmented indicator.
    /// Default value is 3.
    ///
    public var segmentedIndicatorHeight: CGFloat = 2 {
        didSet {
            
        }
    }
    
    public var currentPageIndex : Int = 0
    
//    class var segmentControlHeight : CGFloat {
//        return 44
//    }
    
    ///
    /// Get only values.
    /// View controllers in Pager View Controller
    ///
    public private(set) var viewControllers: [UIViewController]!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var selectedIndex : Int {
        //pageSegment.selectedSegmentIndex can sometimes return -1, so return 0 instead
        if pageSegment == nil {
            return 0
        }
        
        return pageSegment.selectedSegmentIndex < 0 ? 0 : pageSegment.selectedSegmentIndex
    }
    
    //Private variables
    private var pageSegment : SegmentedControl!
    private var pageScrollView : UIScrollView!
    
    //Public methods
    func setCurrentPageIndex(index : Int, animated : Bool) {
        
    }
    
    init(viewControllers : [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    override public func loadView() {
        super.loadView()
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = UIRectEdge.Bottom
        self.automaticallyAdjustsScrollViewInsets = true
        self.view.clipsToBounds = true
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        
        //Make page scroll view
        self.pageScrollView = UIScrollView()
        self.pageScrollView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.pageScrollView.showsHorizontalScrollIndicator = false
        self.pageScrollView.contentSize = CGSize(width: CGRectGetWidth(self.view.bounds) * CGFloat(viewControllers.count), height: 0)
        self.pageScrollView.delegate = self
        self.pageScrollView.pagingEnabled = true
        self.pageScrollView.scrollsToTop = false
        self.pageScrollView.alwaysBounceVertical = false
        
        //Make array of titles + Add view to scroll view
        var titles = [String]()
        
        for (index, viewController) in viewControllers.enumerate() {
            titles.append(viewController.title ?? "")
            self.pageScrollView.addSubview(viewController.view)
            viewController.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
            
            if index == 0 {
                self.addChildViewController(viewController)
                viewController.didMoveToParentViewController(self)
            }
        }
        
        //Menu buttons
        pageSegment = SegmentedControl(titles: titles)
        pageSegment.clipsToBounds = false
        pageSegment.layer.masksToBounds = false
        pageSegment.layer.shadowColor = UIColor.blackColor().CGColor
        pageSegment.layer.shadowOpacity = 0.2
        pageSegment.layer.shadowRadius = 5
        pageSegment.layer.shadowOffset = CGSize(width: 0, height: 7)
        pageSegment.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.view.bounds), height: self.segmentedBarHeight)
        pageSegment.addTarget(self, action: #selector(PagerViewController.pageSegmentValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        pageSegment.selectedSegmentIndex = currentPageIndex
        
        //Bar
        bar = UIView()
        bar.backgroundColor = UIColor.appPurpleColor()
        
        let stripe = UIView()
        stripe.backgroundColor = UIColor.whiteColor()
        stripe.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.view.bounds), height: 0.5)
        
        self.view.addSubview(self.pageScrollView)
        self.view.addSubview(pageSegment)
        //self.view.addSubview(stripe)
        
        self.view.addSubview(bar)
        bar.frame = CGRect(x: 0, y: segmentedBarHeight - segmentedIndicatorHeight, width: CGRectGetWidth(self.view.bounds)/CGFloat(viewControllers.count), height: segmentedIndicatorHeight)
        //Customize title view of navigation bar
        
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let size = self.view.bounds.size
        
        //Setting up frames of subviews in here
        //Scroll view
        self.pageScrollView.frame = CGRect(x: 0, y: segmentedBarHeight, width: size.width, height: size.height - segmentedBarHeight)
        
        //View controllers
        for (index, viewController) in viewControllers.enumerate() {
            var tabbarHeight: CGFloat
            if let tabbar = self.tabBarController?.tabBar {
                if !tabbar.hidden && tabbar.opaque {
                    tabbarHeight = tabbar.bounds.size.height
                }
                else {
                    tabbarHeight = 0
                }
            }
            else {
                tabbarHeight = 0
            }
            
            viewController.view.frame = CGRect(x: CGFloat(index) * size.width, y: 0, width: size.width, height: size.height - segmentedBarHeight - tabbarHeight)
            print(size.height - segmentedBarHeight)
        }
    }
    
    //MARK: PageSegmentValueChanged
    func pageSegmentValueChanged() {
        if currentPageIndex != pageSegment.selectedSegmentIndex {
            //Call delegate method before changing value
            self.delegate?.pagerViewControllerSelectedIndexWillChange?(self, oldSelectedIndex: currentPageIndex, newSelectedIndex: pageSegment.selectedSegmentIndex)
            
            let oldViewController = viewControllers[currentPageIndex]
            let newViewController = viewControllers[pageSegment.selectedSegmentIndex]
            newViewController.viewWillAppear(true)
            oldViewController.viewWillDisappear(true)
            
            //Call these two methods to notify that two view controllers are being removed or added to container view controller (Check Documentation)
            oldViewController.willMoveToParentViewController(nil)
            self.addChildViewController(newViewController)
            
            let size = self.view.bounds.size
            let contentOffset = CGFloat(pageSegment.selectedSegmentIndex) * size.width
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.5, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.pageScrollView.contentOffset = CGPoint(x: contentOffset, y: 0)
                }, completion: { (finished) -> Void in
                    //Call these two methods to notify that two view controllers are already removed or added to container view controller (Check Documentation)
                    oldViewController.removeFromParentViewController()
                    newViewController.didMoveToParentViewController(self)
                    oldViewController.viewDidDisappear(true)
                    newViewController.viewDidAppear(true)
                    
                    //Call delegate method after changing value
                    self.delegate?.pagerViewControllerSelectedIndexDidChange?(self, selectedIndex: self.pageSegment.selectedSegmentIndex)
            })
            
            //Setting up new currentPageIndex for next change
            delegate?.pagerViewControllerSelectedIndexProbablyChange?(self, oldSelectedIndex: currentPageIndex, newSelectedIndex: pageSegment.selectedSegmentIndex)
            currentPageIndex = pageSegment.selectedSegmentIndex
        }
    }
    
    //MARK: UIScrollViewDelegate's method
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        //Update bar position
        bar.frame.origin.x = scrollView.contentOffset.x/scrollView.contentSize.width * scrollView.frame.size.width
        //When content offset changes, check if it is closer to the next page
        var index: Int = 0
        if scrollView.contentOffset.x == 0 && scrollView.frame.size.width == 0 {
            index = 0
        }
        else {
            index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        }
        
        if self.pageSegment.selectedSegmentIndex != index {
            self.pageSegment.selectedSegmentIndex = index
        }
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageSegment.selectedSegmentIndex = index
        self.pageSegmentValueChanged()
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
            pageSegment.selectedSegmentIndex = index
            self.pageSegmentValueChanged()
        }
    }
}

class SegmentedControl : UISegmentedControl {
    
    init(titles: [String]) {
        super.init(items: titles)
        self.commonInit(titles.count)
        self.selectedSegmentIndex = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit(self.numberOfSegments)
    }
    
    func commonInit(numberOfItems : Int) {
        //Menu buttons
        self.backgroundColor = UIColor.whiteColor()
        
        self.setTitleTextAttributes([NSFontAttributeName : UIFont.appFont(CGFloat.normalFontSize), NSForegroundColorAttributeName : UIColor(white: 0.5, alpha: 1)], forState: UIControlState.Normal)
        self.setTitleTextAttributes([NSFontAttributeName : UIFont.boldAppFont(CGFloat.normalFontSize), NSForegroundColorAttributeName : UIColor.appPurpleColor()], forState: UIControlState.Selected)
        self.setTitleTextAttributes([NSFontAttributeName : UIFont.appFont(CGFloat.normalFontSize), NSForegroundColorAttributeName : UIColor(white: 0.3, alpha: 1)], forState: UIControlState.Highlighted)
        
        self.setBackgroundImage(UIImage.image(UIColor.whiteColor()), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        self.setBackgroundImage(UIImage.image(UIColor.whiteColor()), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        self.setBackgroundImage(UIImage.image(UIColor.whiteColor()), forState: UIControlState.Highlighted, barMetrics: UIBarMetrics.Default)
        
        self.setDividerImage(UIImage(), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        self.setDividerImage(UIImage(), forLeftSegmentState: UIControlState.Selected, rightSegmentState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
    }
}
