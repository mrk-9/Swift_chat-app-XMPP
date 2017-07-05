//
//  WYInteractiveTransitions.swift
//  WYInteractiveTransitions
//
//  Created by Wang Yu on 6/5/15.
//  Copyright (c) 2015 Yu Wang. All rights reserved.
//

import UIKit

public enum WYTransitoinType {
    case Push
    case Zoom
    case Up
    case Swing
}

public class WYInteractiveTransitions: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var panEdgeGesture: UIPanGestureRecognizer!
    
    public func configureTransition(presentingDuration presentingDuration: NSTimeInterval?=nil, dismissingDuration: NSTimeInterval?=0.3, toView toViewController: UIViewController, panEnable handGestureEnable: Bool?=true, type transitionType: WYTransitoinType) {
        if let duration = presentingDuration {
            self.presentingDuration = duration
        }
        else {
            self.presentingDuration = 0.5
        }
        
        if let duration = dismissingDuration {
            self.dismissingDuration = duration
        }
        else {
            self.dismissingDuration = 0.3
        }
        
        self.transitionType = transitionType
        self.toViewController = toViewController
        self.toViewController?.transitioningDelegate = self
        self.toViewController?.modalPresentationStyle = .Custom
        if handGestureEnable == true {
            panEdgeGesture = UIPanGestureRecognizer(target: self, action: #selector(WYInteractiveTransitions.handlePanGesture(_:)))
            toViewController.view.addGestureRecognizer(panEdgeGesture)
        }
    }
    
    private var presenting = true
    private var gestureEnable = true
    private var handIn = false
    private var transitionType = WYTransitoinType.Up
    private var toViewController: UIViewController?
    var presentingDuration: Double!
    var dismissingDuration: Double!
    
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if let toView = toViewController {
            let location: CGPoint = gesture.translationInView(toView.view)
            let velocity = gesture.velocityInView(toView.view).y
            
            switch gesture.state {
            case .Began:
                self.handIn = true
                toView.dismissViewControllerAnimated(true, completion: nil)
            case .Changed:
                let animationRatio: CGFloat = location.y / toView.view.bounds.height
                self.updateInteractiveTransition(animationRatio)
            case .Ended, .Cancelled, .Failed:
                self.handIn = false
                if velocity > 400 {
                    finishInteractiveTransition()
                } else {
                    cancelInteractiveTransition()
                }
            default: break
            }
        }
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromView = fromViewController.view
        let toView = toViewController.view
        let duration = self.transitionDuration(transitionContext)
        
        let completeTransition: () -> () = {
            let isCancelled = transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(!isCancelled)
            UIApplication.sharedApplication().keyWindow!.addSubview(toViewController.view)
            
            if isCancelled {
                container.insertSubview(toView, belowSubview: fromView)
            }
        }

        switch transitionType {
        case WYTransitoinType.Push:
            let moveToLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
            let moveToRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
            toView.transform = self.presenting ? moveToRight : moveToLeft
            container.addSubview(toView)
            container.addSubview(fromView)
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.75, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                fromView.transform = self.presenting ? moveToLeft : moveToRight
                toView.transform = CGAffineTransformIdentity
                }) { (finished) -> Void in
                    completeTransition()
            }
            
        case WYTransitoinType.Up:
            if presenting {
                toView.frame = container.bounds
                toView.transform = CGAffineTransformMakeTranslation(0, container.frame.size.height)
                container.addSubview(fromView)
                container.addSubview(toView)
                
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.75, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    fromView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    fromView.alpha = 0.5
                    toView.transform = CGAffineTransformIdentity
                    }, completion: { (finished) in
                        toViewController.modalPresentationStyle = .Custom
                        completeTransition()
                })
            } else {
                let transfrom = toView.transform
                toView.transform = CGAffineTransformIdentity
                toView.frame = container.bounds
                toView.transform = transfrom
                
                container.addSubview(toView)
                container.addSubview(fromView)
                
                UIView.animateWithDuration(duration, animations: { () -> Void in
                    fromView.transform = CGAffineTransformMakeTranslation(0, fromView.frame.size.height)
                    toView.transform = CGAffineTransformIdentity
                    toView.alpha = 1
                    }, completion: { (finished) -> Void in
                        completeTransition()
                })
            }
            
        case WYTransitoinType.Zoom:
            if presenting {
                container.addSubview(fromView)
                container.addSubview(toView)
                toView.alpha = 0
                toView.transform = CGAffineTransformMakeScale(2, 2)
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    fromView.transform = CGAffineTransformMakeScale(0.5, 0.5)
                    fromView.alpha = 0
                    toView.transform = CGAffineTransformIdentity
                    toView.alpha = 1
                    }, completion: { (finished) -> Void in
                        completeTransition()
                })
            } else {
                container.addSubview(toView)
                container.addSubview(fromView)
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    fromView.transform = CGAffineTransformMakeScale(2, 2)
                    fromView.alpha = 0
                    toView.transform = CGAffineTransformMakeScale(1, 1)
                    toView.alpha = 1
                    }, completion: { (finished) -> Void in
                        completeTransition()
                        
                })
            }
            
        case WYTransitoinType.Swing:
            let offScreenRight = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
            let offScreenLeft = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            
            toView.transform = self.presenting ? offScreenRight : offScreenLeft
            
            toView.layer.anchorPoint = CGPoint(x:0, y:0)
            fromView.layer.anchorPoint = CGPoint(x:0, y:0)
            toView.layer.position = CGPoint(x:0, y:0)
            fromView.layer.position = CGPoint(x:0, y:0)
            container.addSubview(toView)
            container.addSubview(fromView)
            let duration = self.transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: [], animations: {
                fromView.transform = self.presenting ? offScreenLeft : offScreenRight
                toView.transform = CGAffineTransformIdentity
                }, completion: { finished in
                    completeTransition()
            })
        }
    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if self.presenting {
            return presentingDuration
        }
        return dismissingDuration
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        toViewController = presenting
        self.presenting = true
        return self
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if handIn == true {
            return self
        } else { return nil }
    }
    
    public func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
