//
//  DTPageControl.swift
//  OnboardingBuddify
//
//  Created by Thinh Duc on 31/03/16.
//  Copyright © 2016 Thinh Duc. All rights reserved.
//

import UIKit
typealias OnboardingCompletion = (control: OnboardingPageControl) -> ()

class OnboardingPageControl: NSObject{
    
    private let pageControlItemWidth: CGFloat = 8
    private let pageControlItemHeight: CGFloat = 8
    private let pageControlItemY: CGFloat = CGFloat.screenHeight - 20
    private let distanceBetweenItems: CGFloat = 25
    private var pageControlItems: [OnboardingPageControlItem] = []
    private var activePageControlItems : [OnboardingPageControlItem] = []
    
    private var numberOfPages: Int!
    private var starting: Bool!
    private var motherView: UIView!
    private let itemColor: UIColor = UIColor.appPurpleColor()
    
    var motherViewBounds: CGRect!
    
    var completionHandler: OnboardingCompletion?
    
    init(attatchedToView: UIView, numberOfPages: Int) {
        super.init()
        self.motherView = attatchedToView
     
        self.numberOfPages = numberOfPages
        self.starting = false
        self.motherViewBounds = motherView.bounds
        self.firstLaunch()
    }
    
    private func firstLaunch() {
        let firstItemX = CGFloat.screenWidth / 2 - (CGFloat(numberOfPages) / 2 - 0.5) * distanceBetweenItems - pageControlItemWidth / 2
        
        for index in 1...(numberOfPages) {
            let itemX = firstItemX + CGFloat(index - 1) * distanceBetweenItems
            let item = OnboardingPageControlItem(frame: CGRect(x: itemX, y: pageControlItemY, width: pageControlItemWidth, height: pageControlItemWidth), color: UIColor.grayColor())
            let itemOffsetX = (CGFloat.screenWidth - pageControlItemWidth) / 2 - itemX
            item.transform = CGAffineTransformMakeTranslation(itemOffsetX, 0)
            if pageControlItems.count > 0 {
                let firstItem = pageControlItems[0]
                motherView.insertSubview(item, belowSubview: firstItem)
            } else {
                motherView.addSubview(item)
            }
    
            pageControlItems.append(item)
        }
        
        for index in 1...(numberOfPages) {
            let item = pageControlItems[index - 1]
            let activeItem = OnboardingPageControlItem(frame: item.bounds, color: itemColor)
            activeItem.alpha = 0.0
            if index == 1 {
                activeItem.alpha = 1.0
            }
            item.addSubview(activeItem)
            activePageControlItems.append(activeItem)
        }
    }
    
    func expandPageControlItems(completion: ()->()) {
        var delay = 0.0
        for item in pageControlItems {
            
            UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: .CurveEaseIn, animations: {
                item.transform = CGAffineTransformIdentity
                }, completion: nil)
            delay += 0.06
        }
        completion()
    }
    
    func updateActivePageControlItem(scrollView: UIScrollView) {
        var fadeInItem: OnboardingPageControlItem?
        var fadeOutItem: OnboardingPageControlItem?
        let progress = (scrollView.contentOffset.x + CGFloat.screenWidth) / (CGFloat(numberOfPages) * CGFloat.screenWidth)
        
        if progress >= 0.25 && progress <= 0.5 {
            fadeInItem = activePageControlItems[1]
            fadeOutItem = activePageControlItems[0]
            fadeInItem?.alpha = (progress - 0.25) / 0.25
            fadeOutItem?.alpha = 1 - (progress - 0.25) / 0.25
        } else if progress > 0.5 && progress < 0.75 {
            fadeInItem = activePageControlItems[2]
            fadeOutItem = activePageControlItems[1]
            fadeInItem?.alpha = (progress - 0.5) / 0.25
            fadeOutItem?.alpha = 1 - (progress - 0.5) / 0.25
        }
        else {
            fadeInItem = activePageControlItems[3]
            fadeOutItem = activePageControlItems[2]
            fadeInItem?.alpha = (progress - 0.75) / 0.25
            fadeOutItem?.alpha = 1 - (progress - 0.75) / 0.25
        }
    }
    
}


class OnboardingPageControlItem: UIView {
    private var color: UIColor!
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.layer.cornerRadius = frame.size.height / 2
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}