//
//  ClientApi.swift
//  BDFClientApi
//
//  Created by Tung Vo  on 12/05/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import AFNetworking

enum NetworkingMethod : String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

public let WebServicesAccessTokenExpiredNotificationKey = "WebServicesAccessTokenExpiredNotification"
public let WebServicesRefreshTokenExpiredNotificationKey = "WebServicesRefreshTokenExpiredNotification"
public let WebServicesTokensUpdatedNotificationKey = "WebServicesRefreshTokenUpdatedNotification"

public typealias WebServicesSuccessBlock = ((NSURLSessionDataTask, AnyObject?) -> Void)
public typealias WebServicesFailureBlock = ((NSURLSessionDataTask?, NSError?) -> Void)
public typealias WebServicesProgresssBlock = ((NSProgress) -> Void)
