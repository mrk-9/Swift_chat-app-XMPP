//
//  ImagePickerAlert.swift
//  Buddify
//
//  Created by Vo Duc Tung on 23/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

extension UIAlertController {
    class func imagePickerAlertController(delegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>, viewController: UIViewController, galleryAllowsEditing: Bool, cameraAllowsEditing: Bool) -> UIAlertController
    {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let libraryButton = UIAlertAction(title: "Gallery upload", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = galleryAllowsEditing
            imagePickerController.delegate = delegate
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            viewController.presentViewController(imagePickerController, animated: true, completion: nil)
        })
        
        let cameraButton = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = cameraAllowsEditing
            imagePickerController.delegate = delegate
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            viewController.presentViewController(imagePickerController, animated: true, completion: nil)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
        })
        
        alertController.addAction(cameraButton)
        alertController.addAction(libraryButton)
        alertController.addAction(cancelButton)
        
        return alertController
    }
    
    class func imagePickerAlertController(delegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>, viewController: UIViewController) -> UIAlertController {
        return UIAlertController.imagePickerAlertController(delegate: delegate, viewController: viewController, galleryAllowsEditing: true, cameraAllowsEditing: true)
    }
}
