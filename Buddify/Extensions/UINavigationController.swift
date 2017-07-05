//
//  UINavigationController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 17/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

extension UINavigationController {
    
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController
    }
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
}
