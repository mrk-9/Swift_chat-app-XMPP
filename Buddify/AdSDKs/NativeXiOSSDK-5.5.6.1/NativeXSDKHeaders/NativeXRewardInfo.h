//
//  NativeXRewardInfo.h
//  NativeXSDK
//
//  Created by Joel Braun on 2015.02.09.
//
//  Copyright 2015 NativeX, LLC. All rights reserved.

#import <Foundation/Foundation.h>
#include "NativeXReward.h"

@interface NativeXRewardInfo : NSObject

/*
 * Array of NativeXRewards detailing exact rewards to be given to the user
 */
@property (nonatomic, readonly, getter=getRewards) NSArray* rewards;

/**
 *  An array of string identifiers you can use to verify transactions with our servers.
 */
-(NSArray*) getReceipts;

/**
 *  count of rewards that are available in the rewards property Array (same as [[NativeXRewardInfo rewards] count])
 *  @return count of rewards in the array
 */
-(NSUInteger) count;

/**
 *  Optional method to display a native iOS alert view describing the rewards given to the user
 */
-(void)showRedeemAlert;

/**
 *  override NSObject's description: method
 */
-(NSString *)description;

-(id)proxyForJson;

@end
