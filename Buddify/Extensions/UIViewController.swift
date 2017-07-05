//
//  UIViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 15/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIViewController {
    func setUpViewControllerExpands() {
        self.edgesForExtendedLayout = [UIRectEdge.Bottom, UIRectEdge.Top]
        self.automaticallyAdjustsScrollViewInsets = true
        self.view.clearsContextBeforeDrawing = true
        self.view.autoresizesSubviews = true
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
    }
    
    func swizzling_viewDidLoad() {
        self.swizzling_viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: #selector(self.dynamicType.viewDidLoad))
    }
    
    public class func swizzleViewDidLoadMethod() {
        let originalMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewDidLoad))
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.swizzling_viewDidLoad))
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}