//
//  NativeXReward.h
//  NativeXSDK
//
//  Created by Joel Braun on 2015.02.06.
//
//  Copyright 2015 NativeX, LLC. All rights reserved.

#import <Foundation/Foundation.h>

/**
 *  Object defining a specific NativeX Reward, as configured on Self Service
 */
@interface NativeXReward : NSObject

/**
 *  Amount of reward type given to the user
 */
@property (nonatomic, readonly, getter=getAmount) NSNumber* amount;
/**
 *  The proper reward name as defined on Self Service; should use rewardName as the display name of the reward
 */
@property (nonatomic, readonly) NSString* rewardName;
/**
 *  The ID (or type) of the reward as defind on Self Service; internally used to collect rewards together of the same type
 */
@property (nonatomic, readonly) NSString* rewardId;

/**
 * a string identifier for this reward that you can use to verify transactions with our servers.
 */
-(NSArray*) getReceipts;

/**
 *  override NSObject's description: method
 */
-(NSString *)description;

- (id)proxyForJson;

@end
