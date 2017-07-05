//
//  DTHighLightButtons.swift
//  Dispot
//
//  Created by MacBook Pro on 10/11/14.
//  Copyright (c) 2014 MacBook Pro. All rights reserved.
//

import Foundation


//MARK: Highlight button
class HighLightButton: UIButton {    
    override init(frame: CGRect) {
        super.init(frame: frame)    
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var highlighted: Bool {
        set{
            super.highlighted = newValue
            if newValue {
                self.alpha = 0.5
                //self.imageView?.alpha = 0.5
            }
            else{
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.alpha = 1.0
                    //self.imageView?.alpha = 1.0
                })
            }
        }
        get{
            return super.highlighted
        }
    }
}

//Custom bar button

enum DTBarButtonPosition{
    case Left
    case Right
}

extension HighLightButton {
    convenience init(title: String, position : DTBarButtonPosition){
        self.init(frame: CGRectMake(0, 0, 60, 44))
        self.titleLabel?.font = UIFont.appFontRegular(CGFloat.normalTextSize)
        self.setTitle(title, forState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        self.setTitleColor(UIColor.appDimTextColor(), forState: UIControlState.Disabled)
        self.contentHorizontalAlignment = position == DTBarButtonPosition.Left ? UIControlContentHorizontalAlignment.Left : UIControlContentHorizontalAlignment.Right
    }
    
    convenience init(image: UIImage, position : DTBarButtonPosition){
        self.init(frame: CGRectMake(0, 0, 60, 44))
        self.setImage(image, forState: UIControlState.Normal)
        self.setImage(image.imageTintedWithColor(UIColor.appLightGreyColor()), forState: UIControlState.Highlighted)
        self.contentHorizontalAlignment = position == DTBarButtonPosition.Left ? UIControlContentHorizontalAlignment.Left : UIControlContentHorizontalAlignment.Right
    }
}

//MARK: ScaleButton
class ScaleButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.clipsToBounds = false
        self.imageView?.contentMode = UIViewContentMode.Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override var selected: Bool {
//        set{
//            if newValue != super.selected {
//                super.selected = newValue
//                if newValue {
//                    UIView.animateWithDuration(0.1, animations: { () -> Void in
//                        self.imageView?.transform = CGAffineTransformMakeScale(1.2, 1.2)
//                        }, completion: { (finished) -> Void in
//                            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                                let animation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
//                                animation.toValue = NSValue(CGSize: CGSize(width: 1.0, height: 1.0))
//                                animation.springSpeed = 10.0
//                                animation.springBounciness = 7.0
//                                self.imageView?.layer.pop_addAnimation(animation, forKey: "popScale")
//                            })
//                    })
//                }
//                else{
//                    
//                }
//            }
//        }
//        
//        get{
//            return super.selected
//        }
//    }
    
    func setSelectedWithScaleAnimation(selected : Bool) {
        if self.selected != selected {
            if selected {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.imageView?.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    }, completion: { (finished) -> Void in
                        let animation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
                        animation.toValue = NSValue(CGSize: CGSize(width: 1.0, height: 1.0))
                        animation.duration = 0.2
                        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                        self.imageView?.layer.pop_addAnimation(animation, forKey: "popScale")
                })
            }
            
            //Animate title label if it's not nil, otherwise just change value without animation
            if let titleLabel = self.titleLabel {
                UIView.transitionWithView(titleLabel, duration: 0.3, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
                    self.selected = selected
                    }, completion: { (finished) -> Void in
                        
                })
            }
            else {
                self.selected = selected
            }
            
        }
    }
}






