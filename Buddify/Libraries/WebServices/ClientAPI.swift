//
//  ClientAPI.swift
//  Buddify
//
//  Created by Vo Duc Tung on 20/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AFNetworking

enum NetworkingMethod : String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

class ClientAPI: NSObject {
    let sessionManager = AFHTTPSessionManager()
    let requestSerializer = AFJSONRequestSerializer()
    var timeOutInterval: NSTimeInterval = 10
    let baseAddress: String
    
    init(baseAddress address: String, timeOutInterval interval: NSTimeInterval) {
        timeOutInterval = interval
        baseAddress = address
        sessionManager.requestSerializer = requestSerializer
        super.init()
    }
    
    func request(action : NetworkingMethod,
                       request : String,
                       paramaters : NSDictionary?,
                       progress: ((NSProgress) -> Void)?,
                       success: ((NSURLSessionDataTask, AnyObject?) -> Void)?,
                       failure: ((NSURLSessionDataTask?, NSError?) -> Void)?)
    {
        delay(1.0) { 
            success?(NSURLSessionDataTask(), NSDictionary())
        }
//        if action == .GET {
//            sessionManager.GET(request, parameters: paramaters, progress: progress, success: success, failure: failure)
//        }
//        else if action == .POST {
//            //POST action here
//            sessionManager.POST(request, parameters: paramaters, progress: progress, success: success, failure: failure)
//        }
//        else if action == .DELETE {
//            //DELETE action here
//            sessionManager.DELETE(request, parameters: paramaters, success: success, failure: failure)
//        }
//        else {
//            //PUT action here
//            sessionManager.PUT(request, parameters: paramaters, success: success, failure: failure)
//        }
    }
    
    func requestStringWithExtension(extensionString: String, customRequest : String?) -> String {
        return self.requestFromRequest(baseAddress + extensionString, customRequest: customRequest)
    }
    
    func requestFromRequest(request : String, customRequest : String?) -> String {
        if let url = customRequest {
            return url
        }
        else {
            return request
        }
    }
}
