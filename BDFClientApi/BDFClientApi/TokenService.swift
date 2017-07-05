//
//  TokenService.swift
//  Buddify
//
//  Created by Vo Duc Tung on 04/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

let headerAuthorization = "Basic aW9zOmV3OEAzMmZlKkAj"

public class TokenServices: WebServices {
    ///
    /// Refresh token
    /// Refresh token is nullable when user is not logging in.
    private var _refreshToken: String?
    
    ///
    /// Update refresh token
    ///
    public func updateRefreshToken(token: String) {
        _refreshToken = token
    }
    
    ///
    /// Log in with username & password
    ///
    public func logInWithUsername(username: String, password: String, progressBlock: WebServicesProgresssBlock?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "token")
        let parameters = ["username": username, "password": password, "grant_type": "password"]
        self.sessionManager.requestSerializer.setValue(headerAuthorization, forHTTPHeaderField: "Authorization")
        self.request(NetworkingMethod.POST, request: request, paramaters: parameters, progress: progressBlock, success: successBlock, failure: failureBlock)
    }
    
    ///
    /// Log in with Facebook
    ///
    public func loginWithFacebook(facebookAccessToken: String, progressBlock: WebServicesProgresssBlock?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "token")
        let parameters = ["access_token": facebookAccessToken, "grant_type": "fb"]
        self.sessionManager.requestSerializer.setValue(headerAuthorization, forHTTPHeaderField: "Authorization")
        self.request(NetworkingMethod.POST, request: request, paramaters: parameters, progress: progressBlock, success: successBlock, failure: failureBlock)
    }
    
    ///
    /// Sign up with email
    ///
    public func signUpWithName(name: String, email: String, password: String, progressBlock: WebServicesProgresssBlock?, successBlock: WebServicesSuccessBlock?, failureBlock: WebServicesFailureBlock?) {
        let request = self.requestWith("1", endpoint: "users")
        let parameters = ["full_name": name, "email": email, "password": password]
        self.request(NetworkingMethod.POST, request: request, paramaters: parameters, progress: progressBlock, success: successBlock, failure: failureBlock)
    }
    
    ///
    /// Reset password
    ///
    
}
