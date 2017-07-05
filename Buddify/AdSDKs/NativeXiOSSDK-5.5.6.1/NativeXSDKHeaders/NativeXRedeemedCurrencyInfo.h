//
//  NativeXCurrencyInfo.h
//  NativeXSDK
//
//  Created by Ash Lindquist on 11/15/13.
//
//  Copyright 2015 NativeX, LLC. All rights reserved.

#import <Foundation/Foundation.h>

__deprecated_msg("Class is deprecated along with [redeemCurrency] method and [nativeXSDKDidRedeemWithCurrencyInfo] delegate.  Please use [redeemRewards], [nativeXSDKDidRedeemWithRewards], NativeXRewardInfo and NativeXReward classes instead.")
@interface NativeXRedeemedCurrencyInfo : NSObject

/**
 *  An array of messages that can be displayed to the user on successful redemption
 */
@property (nonatomic, readonly) NSArray *messages;

/**
 *  an array of balances that should be paid to user. Each object in the array represents one type of currency for your game
 */
@property (nonatomic, readonly) NSArray *balances;

/**
 *  an array of identifiers you can use to verify transactions with our servers.
 */
@property (nonatomic, readonly) NSArray *receipts;

/**
 *  Create CurrencyInfo object using API JSON response
 *
 *  @param APIResult    NSDictionary of API results
 *
 *  @return an object version of json response
 */
-(id)initWithRedeemBalancesResult:(NSDictionary *)APIResult;

/**
 *  Calling this method will display a native iOS alert view on success
 */
-(void)showRedeemAlert;

/**
 *  converts object to dictionary (to prep for JSON)
 *
 *  @return NSDictionary version of object
 */
-(id)proxyForJson;

@end
