//
//  NativeXRewardDelegate.h
//  NativeXSDK
//
//  Created by Joel Braun on 2015.08.31.
//  Copyright (c) 2015 NativeX, LLC. All rights reserved.
//

#pragma mark NativeXRewardDelegate protocol definition

/**
 *  protocol defining reward notifications from the NativeX SDK to your app.
 *  All protocol methods are optional; can be defined or ignored at the app developer's discretion.
 */
@protocol NativeXRewardDelegate <NSObject>

@optional

/** Called when the currency redemption is unsuccessfull.
 *
 * @param   error
 *          reason why redeem currency call failed
 */
- (void)rewardDidRedeemWithError:(NSError *)error __deprecated_msg("rewardDidRedeemWithError: is deprecated (no replacements available)");


/** Called when the rewards redemption is successful.
 *
 * @param rewardInfo
 *        an object containing the list of reciepts, as well as some helper methods
 */
- (void)rewardDidRedeemWithRewardInfo:(NativeXRewardInfo*)rewardInfo __deprecated_msg("method is deprecated; use the rewardAvailable: method instead");

/**
 *  Optional - Called when rewards have been collected from NativeX's servers.
 *  @param rewardInfo - the NativeXRewardInfo object containing an array of NativeXReward objects that should be given to your user.
 */
- (void) rewardAvailable:(NativeXRewardInfo*) rewardInfo;

@end
