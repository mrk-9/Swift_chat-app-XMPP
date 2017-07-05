//
//  UIAlertController.swift
//  Buddify
//
//  Created by Admin on 15/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

extension UIAlertController {
    class func alertControllerWithTitle(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, cancelButtonTitle: String?, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.Cancel, handler: handler)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    class func internetConnectionAlertController(handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        return UIAlertController.alertControllerWithTitle("No internet", message: "There is no internet access on this device. Please try again.", preferredStyle: UIAlertControllerStyle.Alert, cancelButtonTitle: "OK", handler: handler)
    }
}