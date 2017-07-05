//
//  NativeXCurrency.h
//  NativeXPublisherSdk
//
//  This file is subject to the SDK Source Code License Agreement defined in file
//  "SDK_SourceCode_LicenseAgreement", which is part of this source code package.
//
//  Created by Andrey Marinov on 29.11.2011.
//  Copyright (c) 2011 NativeX, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

__deprecated_msg("Class is deprecated along with [redeemCurrency] method and [nativeXSDKDidRedeemWithCurrencyInfo] delegate.  Please use [NativeXSDK getRewards], NativeXRewardDelegate protocol, NativeXRewardInfo and NativeXReward classes instead.")
@interface NativeXCurrency : NSObject
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *externalCurrencyId;

- (id)initWithDictionary:(NSDictionary *) dictionary;
- (id)proxyForJson;

@end
