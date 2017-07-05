//
//  CustomAnimator.swift
//  Buddify
//
//  Created by Vo Duc Tung on 26/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

class ScalingTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    var presenting = true
    private var duration : NSTimeInterval = 0.3
    private var interactiveTransition = ScalingInteractiveTransition()
    
    init(viewController: UIViewController) {
        super.init()
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .Custom
        interactiveTransition.attachToViewController(viewController)
    }
    
    deinit {
        DTLog("deinit")
    }
    
    //MARK: UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            self.presenting = true
            return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        guard let container = transitionContext.containerView() else {
            return
        }
        
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        // set up from 2D transforms that we'll use in the animation
        
        let offScreenTranslation =  CATransform3DMakeTranslation(0, fromViewController.view.bounds.size.height, 0)  //CGAffineTransformMakeTranslation(0, fromViewController.view.bounds.size.height)
        let scaleTransform = CATransform3DMakeScale(0.9, 0.9, 1) //CGAffineTransformMakeScale(0.9, 0.9)
        
        // prepare the toView for the animation
        if self.presenting {
            toViewController.view.layer.transform = offScreenTranslation
            //Add the both views to our view controller
            container.addSubview(toViewController.view)
        }
        else {
            toViewController.modalPresentationStyle = .FullScreen
            container.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            // add the both views to our view controller
            //toViewController.view.layer.transform = scaleTransform
        }
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            if self.presenting {
                fromViewController.view.layer.transform = scaleTransform
                toViewController.view.layer.transform = CATransform3DIdentity
            }
            else {
                fromViewController.view.layer.transform = offScreenTranslation
                toViewController.view.layer.transform = CATransform3DIdentity
            }
            
            }) { (finished) -> Void in
                //Add the both views to our view controller
                container.addSubview(toViewController.view)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
        //        let toView = toViewController.view
        //        let fromView = fromViewController.view
        //
        //        let completeTransition: () -> () = {
        //            let isCancelled = transitionContext.transitionWasCancelled()
        //            transitionContext.completeTransition(!isCancelled)
        //        }
        //
        //        if presenting {
        //            toView.frame = container.bounds
        //            toView.transform = CGAffineTransformMakeTranslation(0, container.frame.size.height)
        //            //container.addSubview(fromView)
        //            container.addSubview(toView)
        //            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
        //                fromView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        //                fromView.alpha = 0.5
        //                toView.transform = CGAffineTransformIdentity
        //                }, completion: { (finished) -> Void in
        //                    completeTransition()
        //            })
        //        } else {
        //            let transfrom = toView.transform
        //            toView.transform = CGAffineTransformIdentity
        //            toView.frame = container.bounds
        //            toView.transform = transfrom
        //
        //            container.addSubview(toView)
        //            //container.addSubview(fromView)
        //            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
        //                fromView.transform = CGAffineTransformMakeTranslation(0, fromView.frame.size.height)
        //                toView.transform = CGAffineTransformIdentity
        //                toView.alpha = 1
        //                }, completion: { (finished) -> Void in
        //                    completeTransition()
        //            })
        //        }
    }
    
    //Return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?)-> NSTimeInterval {
        return duration
    }
}

class ScalingInteractiveTransition: UIPercentDrivenInteractiveTransition {
    let percentageAdjustFactor: CGFloat = 1
    weak var parentViewController: UIViewController?
    
    func attachToViewController(viewController: UIViewController) {
        parentViewController = viewController
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ScalingInteractiveTransition.handlePanGesture(_:)))
        parentViewController?.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    internal func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        guard let viewController = parentViewController else {
            return
        }
        
        let progress = panGesture.translationInView(viewController.view).y / viewController.view.bounds.size.height / percentageAdjustFactor
        print("progress = \(progress)")
        print("completed = \(percentComplete)")

        switch panGesture.state {
        case UIGestureRecognizerState.Began:
            viewController.dismissViewControllerAnimated(true, completion: nil)
            self.updateInteractiveTransition(0)
            
        case UIGestureRecognizerState.Changed:
            self.updateInteractiveTransition(progress)
            
        default:
            if panGesture.velocityInView(viewController.view).y > 10 {
                self.finishInteractiveTransition()
                viewController.view.removeGestureRecognizer(panGesture)
            }
            else {
                self.cancelInteractiveTransition()
            }
        }
    }
}
