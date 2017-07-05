//
//  InAppPurchaseTrackRecord.h
//  NativeXPublisherSdk
//
//  This file is subject to the SDK Source Code License Agreement defined in file
//  "SDK_SourceCode_LicenseAgreement", which is part of this source code package.
//
//  Created by Bozhidar Mihaylov on 4/25/12.
//  Copyright (c) 2012 NativeX, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NativeXInAppPurchaseTrackRecord : NSObject

@property (nonatomic, strong) NSString *storeProductID;
@property (nonatomic, strong) NSString *storeTransactionID;
@property (nonatomic, strong) NSDate *storeTransactionTime;
@property (nonatomic, strong) NSDecimalNumber *costPerItem;
@property (nonatomic, strong) NSLocale *currencyLocale;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, strong) NSString *productTitle;

@end
