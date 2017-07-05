//
//  WebServices.swift
//  BDFClientApi
//
//  Created by Tung Vo  on 12/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import UIKit
import AFNetworking

private let kAccessTokenErrorCode = 401

public class WebServices: NSObject {
    let sessionManager = AFHTTPSessionManager()
    let requestSerializer = AFHTTPRequestSerializer()
    var timeOutInterval: NSTimeInterval = 10
    
    var runningTasks: [NSURLSessionDataTask] = [NSURLSessionDataTask]()
    var waitingTasks: [(() -> Void)] = []
    
    //Locked queue used when update access token, access token refresh call should be called only once at a time
    private var _isUpdatingAccessToken = false
    private var _lockedQueue = dispatch_queue_create("com.test.LockQueue", nil)
    private var _baseURL: String
    
    ///
    /// Initializer
    ///
    public init(baseURLString: String) {
        _baseURL = baseURLString
        super.init()
    }
    
    
    func requestWith(version : String, endpoint : String) -> String {
        return _baseURL + "v" + version + "/" + endpoint
    }
    
    func requestWithCustomURLString(next : String) -> String {
        return _baseURL + next
    }
    
    func request(action : NetworkingMethod,
                       request : String,
                       paramaters : NSDictionary?,
                       progress: ((NSProgress) -> Void)?,
                       success: ((NSURLSessionDataTask, AnyObject?) -> Void)?,
                       failure: ((NSURLSessionDataTask?, NSError?) -> Void)?)
    {
        if action == .POST {
            sessionManager.POST(request, parameters: paramaters, progress: progress, success: success, failure: failure)
        }
        else if action == .GET {
            sessionManager.GET(request, parameters: paramaters, progress: progress, success: success, failure: failure)
        }
        else if action == .PUT {
            sessionManager.PUT(request, parameters: paramaters, success: success, failure: failure)
        }
        else if action == .DELETE {
            sessionManager.DELETE(request, parameters: paramaters, success: success, failure: failure)
        }
    }
    
    func request(request : String,
                parameters : NSDictionary?,
                formDatas : [(NSData, String, String, String)]?,
                progress: ((NSProgress) -> Void)?,
                success: ((NSURLSessionDataTask, AnyObject?) -> Void)?,
                failure: ((NSURLSessionDataTask?, NSError?) -> Void)?) {
        let block : ((AFMultipartFormData) -> Void) = {(formData : AFMultipartFormData) -> Void in
            // All file
            if let _formDatas = formDatas {
                if _formDatas.count > 0 {
                    for (data, name, fileName, mimeType) in _formDatas {
                        formData.appendPartWithFileData(data, name: name, fileName: fileName, mimeType: mimeType)
                    }
                }
            }
        }
        
        sessionManager.POST(request, parameters: parameters, constructingBodyWithBlock: block, progress: progress, success: success, failure: failure)
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

