//
//  PostServices.swift
//  Buddify
//
//  Created by Vo Duc Tung on 12/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

///
/// This class is a client api for creating content in the app.
///

public class PostServices: AuthenticatedServices {
    public func createNewPostWith(caption: String?, image: UIImage?, progressBlock: WebServicesProgresssBlock?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        if caption == nil && image == nil {
            return
        }
        else {
            let request = self.requestWith("1", endpoint: "posts")
            var parameters: [String: AnyObject] = ["provider": "ios"]
            
            if let _caption = caption {
                parameters["status"] = _caption
            }
            
            if let _image = image {
                if let data = UIImageJPEGRepresentation(_image, 1.0) {
                    parameters["item_type"] = "image"
                    //parameters["height"] = "\(_image.size.height)"
                    //parameters["width"] = "\(_image.size.width)"
                    self.request(request, parameters: parameters, formDatas: [(data, "file", "file.jpg", "image/jpeg")], progress: progressBlock, success: successBlock, failure: failureBlock)
                    
                    return
                }
                
            }
            
            // Post as status instead
            parameters["item_type"] = "status"
            self.request(request, parameters: parameters, formDatas: nil, progress: progressBlock, success: successBlock, failure: failureBlock)
        }
    }
}
