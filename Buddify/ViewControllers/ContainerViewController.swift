//
//  ContainerViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 05/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

class ContainerViewController: UIViewController {
    weak var currentViewController : UIViewController!
    
    var detailView : UIView!
    private var _shouldAutoRotate = false
    
    //MARK: Initializers
    convenience init(viewController : UIViewController!) {
        self.init()
        currentViewController = viewController
        currentViewController.view.frame = self.view.bounds
    }
    
    class var sharedInstance : ContainerViewController!{
        get {
            struct Static {
                static var instance : ContainerViewController!
            }
            
            if Static.instance == nil {
                Static.instance = ContainerViewController()
            }
            
            return Static.instance!
        }
    }
    
    //MARK: Notifications
    func moviePlayerWillEnterFullscreen(notification : NSNotification!) {
        _shouldAutoRotate = true
    }
    
    func moviePlayerWillExitFullscreen(notification : NSNotification!) {
        _shouldAutoRotate = false
    }
    
    //MARK: UIViewController
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if let viewController = currentViewController as? UINavigationController {
            return viewController.topViewController?.preferredStatusBarStyle() ?? UIStatusBarStyle.LightContent
        }
        return currentViewController.preferredStatusBarStyle()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        if let viewController = currentViewController as? UINavigationController {
            return viewController.topViewController?.prefersStatusBarHidden() ?? true
        }
        return currentViewController.prefersStatusBarHidden()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(currentViewController)
        detailView = UIView(frame: self.view.bounds)
        self.view.addSubview(detailView)
        self.detailView.addSubview(currentViewController.view)
        currentViewController.didMoveToParentViewController(self)
    }
    
    func presentViewController(viewController: UIViewController!, completion: (() -> Void)?) {
        //currentViewController is going to be removed
        let oldViewController = currentViewController
        currentViewController = viewController
        self.setNeedsStatusBarAppearanceUpdate()
        oldViewController.willMoveToParentViewController(nil)
        
        //Generate image view
        let currentView = self.takeScreenshot(self.view.layer)
        
        let blackView = self.blackView
        blackView.addSubview(currentView)
        
        var oldFrame = currentView.layer.frame
        currentView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        currentView.layer.frame = oldFrame
        
        //Hide current view
        oldViewController.view.hidden = true
        oldViewController.view.removeFromSuperview()
        
        //Add new view to detail view
        
        self.detailView.addSubview(viewController.view)
        
        let nextView = self.takeScreenshot(self.view.layer)
        oldFrame = nextView.layer.frame
        nextView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        nextView.layer.frame = oldFrame
        nextView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: nextView.frame.size.width, height: nextView.frame.size.height)
        
        //Attach screen shot to background view
        blackView.addSubview(nextView)
        self.view.addSubview(blackView)
        self.addChildViewController(viewController)
        
        //The animation
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            currentView.frame = CGRect(x: 0, y: -currentView.frame.size.height, width: currentView.frame.size.width, height: currentView.frame.size.height)
            nextView.frame = CGRect(x: 0, y: 0, width: nextView.frame.size.width, height: nextView.frame.size.height)
        }) { (finished) -> Void in
            //Completion handler
            completion
            
            oldViewController.removeFromParentViewController()
            
            //Add new view controller as new child
            viewController.didMoveToParentViewController(self)
            blackView.removeFromSuperview()
        }
    }
    
    //Create a view with a black background
    private var blackView : UIView {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.blackColor()
        return view
    }
    
    private func takeScreenshot(layer : CALayer!) -> UIImageView {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, UIScreen.mainScreen().scale)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return UIImageView(image: image)
        
    }
}


//private var containerViewControllerKey: UInt8 = 0
extension UIViewController {
    weak var containerViewController : ContainerViewController?{
        get {
            var viewController : UIViewController?
            viewController = self
            while viewController != nil {
                if let containerViewController = viewController?.parentViewController as? ContainerViewController {
                    return containerViewController
                }
                else {
                    viewController = viewController?.parentViewController
                }
            }
            return nil
        }
    }
}
