//
//  AuthenticatedServices.swift
//  Buddify
//
//  Created by Vo Duc Tung on 20/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AFNetworking

public let WebServiceServerErrorCode = 0
public let WebServiceRefreshTokenErrorCode = 2
public let WebServiceAccessTokenErrorCode = 6
public let BDFNetworkingOperationFailingURLResponseDataErrorKey = AFNetworkingOperationFailingURLResponseDataErrorKey

public class AuthenticatedServices: WebServices {
    public override init(baseURLString: String) {
        super.init(baseURLString: baseURLString)
        sessionManager.responseSerializer.acceptableContentTypes?.insert("text/html")
        sessionManager.requestSerializer = requestSerializer
    }
    
    ///
    /// A class array instance that contain all of current rest calls.
    /// The purpose of this instance is to save them when they fail because of expired access token.
    /// And when a new token is acquired, all of the call will be reactivated.
    /// They should be managed in a thread-safe way.
    ///
    static var _waitingRequest: [(() throws -> Void)] = []
    
    ///
    /// A class queue instance.
    /// Responsible for thread safe
    ///
    static var _requestQueue: dispatch_queue_t = dispatch_queue_create("webservice.api.buddify.io", DISPATCH_QUEUE_SERIAL)
    
    ///
    /// A class flag instance
    /// Indicate whethe it is refreshing access token.
    ///
    static var _isRefreshingTokens = false
    
    ///
    /// Access token
    /// Access token is nullable when user is not logging in.
    ///
    private var accessToken: String?
    
    ///
    /// Refresh token
    /// Refresh token is nullable when user is not logging in.
    private var refreshToken: String?
    
    ///
    /// Update access token
    ///
    public func updateAccessToken(token: String) {
        accessToken = token
    }
    
    ///
    /// Update refresh token
    ///
    public func updateRefreshToken(token: String) {
        refreshToken = token
    }
    
    /// Create bearer token
    func bearerToken() throws -> String {
        if let token = accessToken {
            let bearerToken = "Bearer " + token
            print(bearerToken)
            return bearerToken
        }
        else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorUserAuthenticationRequired, userInfo: nil)
        }
    }
    
    override func request(action: NetworkingMethod, request: String, paramaters: NSDictionary?, progress: ((NSProgress) -> Void)?, success: ((NSURLSessionDataTask, AnyObject?) -> Void)?, failure: ((NSURLSessionDataTask?, NSError?) -> Void)?) {

        // We create a recall block which is identical to block in order to have something to call when access token is updated
        // Notice that in this block, recallBlock is nil (is most cases, it will work just fine)
        // Better solution would be recursive closure (I do not know how to do it yet.)
        let recallBlock: (() throws -> Void) = {() -> Void in
            do {
                //Add access token to header before sending request
                try self.requestSerializer.setValue(self.bearerToken(), forHTTPHeaderField: "Authorization")
                super.request(action, request: request, paramaters: paramaters, progress: progress, success: { (task: NSURLSessionDataTask, object: AnyObject?) in
                    success?(task, object)
                    }, failure: { (task: NSURLSessionDataTask?, error: NSError?) in
                        // Investigate failure block to check if access token is expired
                        self.executeFailureBlock(failure, dataTask: task, error: error, recallBlock: nil)
                })
            }
            catch {
                print("There is no access token.\n")
            }
        }
        
        let block: (() throws -> Void) = {() -> Void in
            do {
                //Add access token to header before sending request
                try self.requestSerializer.setValue(self.bearerToken(), forHTTPHeaderField: "Authorization")
                super.request(action, request: request, paramaters: paramaters, progress: progress, success: { (task: NSURLSessionDataTask, object: AnyObject?) in
                    success?(task, object)
                    }, failure: { (task: NSURLSessionDataTask?, error: NSError?) in
                        // Investigate failure block to check if access token is expired
                        self.executeFailureBlock(failure, dataTask: task, error: error, recallBlock: recallBlock)
                })
            }
            catch {
                print("There is no access token.\n")
            }
        }
        
        self.executeAPICallBlock(block)
    }
    
    ///
    /// Execute block API call
    ///
    private func executeAPICallBlock(block: (() throws -> Void)) {
        dispatch_sync(AuthenticatedServices._requestQueue) {
            
            // If is not refreshing tokens
            if AuthenticatedServices._isRefreshingTokens == false {
                // Execute block
                do {
                    try block()
                }
                catch {
                    
                }
            }
            else {
                // Add block to array of ongoing blocks
                AuthenticatedServices._waitingRequest.append(block)
                
                print("Web service is refreshing access token.\n")
            }
        }
    }
    
    ///
    /// Investigate failure block of a normal API call (not refreshing token call)
    /// recallBlock will be executed when refresh token is succeeded
    ///
    private func executeFailureBlock(_failureBlock: ((NSURLSessionDataTask?, NSError?) -> Void)?, dataTask _dataTask: NSURLSessionDataTask?, error _error: NSError?, recallBlock: (() throws -> Void)?) {
        if (_dataTask?.response as? NSHTTPURLResponse)?.statusCode == 401 {
            
            do {
                // Check error body
                if let data = _error?.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? NSData {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    if let response = json as? NSDictionary {
                        // Check error code
                        if let error = response["error_code"] as? NSNumber {
                            if error.integerValue == WebServiceAccessTokenErrorCode {
                                // Unauthenticated token
                                // Should handle refresh token call here.
                                // However, other failure block might activate refresh token before, so it is
                                // reasonable to check again the status before actually refresing tokens
                                dispatch_sync(AuthenticatedServices._requestQueue) {
                                    if AuthenticatedServices._isRefreshingTokens == false {
                                        self.refreshTokens({ (task: NSURLSessionDataTask, object: AnyObject?) in
                                            // Update the flag
                                            AuthenticatedServices._isRefreshingTokens = false
                                            
                                            // Update the tokens
                                            if let dictionary = object as? NSDictionary {
                                                if let accessToken = dictionary["access_token"] as? String {
                                                    self.updateAccessToken(accessToken)
                                                }
                                                
                                                if let refreshToken = dictionary["refresh_token"] as? String {
                                                    self.updateRefreshToken(refreshToken)
                                                }
                                                
                                                // Post the notification to let others update tokens
                                                NSNotificationCenter.defaultCenter().postNotificationName(WebServicesTokensUpdatedNotificationKey, object: dictionary)
                                                
                                                // Refreshing token is succeeded should follow recall api call
                                                do {
                                                    try recallBlock?()
                                                }
                                                catch {
                                                    
                                                }
                                            }
                                            
                                            // After refreshing tokens successfully, what we need to do is
                                            // execute all API calls in the queue
                                            while AuthenticatedServices._waitingRequest.count > 0 {
                                                let block = AuthenticatedServices._waitingRequest.removeAtIndex(0)
                                                do {
                                                    try block()
                                                }
                                                catch {
                                                    
                                                }
                                            }
                                            
                                            }, failureBlock: { (task: NSURLSessionDataTask?, error: NSError?) in
                                                // Update the flag
                                                AuthenticatedServices._isRefreshingTokens = false
                                                
                                                // For some reason, the failure block is always called even though 
                                                // the api call succeeded.
                                                
                                                if self.investigateTokensRefreshingFailureBlock(error) {
                                                    NSLog("It went here even though call is successful")
                                                    NSNotificationCenter.defaultCenter().postNotificationName(WebServicesRefreshTokenExpiredNotificationKey, object: nil)
                                                }
                                                else {
                                                    // Otherwise excute failure block
                                                    _failureBlock?(_dataTask, _error)
                                                }
                                        })
                                    }
                                }
                            }
                        }
                    }
                    
                    return
                }
                
                //
                // Otherwise excute failure block
                _failureBlock?(_dataTask, _error)
                return
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        }
        
        // Otherwise excute failure block
        _failureBlock?(_dataTask, _error)
    }
    
    override func request(request: String, parameters: NSDictionary?, formDatas: [(NSData, String, String, String)]?, progress: ((NSProgress) -> Void)?, success: ((NSURLSessionDataTask, AnyObject?) -> Void)?, failure: ((NSURLSessionDataTask?, NSError?) -> Void)?) {
        do {
            //Add access token to header before sending request
            try requestSerializer.setValue(self.bearerToken(), forHTTPHeaderField: "Authorization")
            
            super.request(request, parameters: parameters, formDatas: formDatas, progress: progress, success: { (task: NSURLSessionDataTask, object: AnyObject?) in
                success?(task, object)
                }, failure: { (task: NSURLSessionDataTask?, error: NSError?) in
                    failure?(task, error)
            })
        }
        catch {
            
        }
    }
    
    ///
    /// Private func to investigate refresh token failure
    /// return true if token is expired
    /// return false otherwise
    ///
    private func investigateTokensRefreshingFailureBlock(error: NSError?) -> Bool {
        do {
            if let data = error?.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? NSData {
                
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                // Investigate reason of failure of refreshing token
                if let response = json as? NSDictionary {
                    // Check error code
                    if let errorCode = response["error_code"] as? NSNumber {
                        if errorCode.integerValue == WebServiceRefreshTokenErrorCode {
                            // Push notification to notify that the refresh token is already expired
                            return true
                        }
                    }
                }
                
            }
            
        }
        catch {
            return false
        }
        return false
    }
    
    ///
    /// Refresh tokens, here is where we need
    ///
    public func refreshTokens(successBlock: ((NSURLSessionDataTask, AnyObject?) -> Void), failureBlock: ((NSURLSessionDataTask?, NSError?) -> Void)) {
        if AuthenticatedServices._isRefreshingTokens == false {
            
            // Refresh token now
            if let refreshToken = self.refreshToken {
                // Fuck this shit, I have no idea why I need to build request manually and still send parameters
                // Send only parameters, grant_type will not be taken
                // Build the request only, the refresh_token is missing
                // NO FUCKING IDEA WHY!
                let parameters = ["refresh_token": refreshToken, "grant_type": "refresh_token"]
                self.sessionManager.requestSerializer.setValue(headerAuthorization, forHTTPHeaderField: "Authorization")
                
                // See the comment above
                let request = self.requestWith("1", endpoint: "token?refresh_token=\(refreshToken)&grant_type=refresh_token")
                
                super.request(NetworkingMethod.POST, request: request, paramaters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, object: AnyObject?) in
                    successBlock(task, object)
                    }, failure: { (task: NSURLSessionDataTask?, error: NSError?) in
                        // Investigate failure block to check if access token is expired
                        failureBlock(task, error)
                        print("Error refreshing tokens!")
                })
                
                // Update flag
                AuthenticatedServices._isRefreshingTokens = true
            }
        }
    }
}
