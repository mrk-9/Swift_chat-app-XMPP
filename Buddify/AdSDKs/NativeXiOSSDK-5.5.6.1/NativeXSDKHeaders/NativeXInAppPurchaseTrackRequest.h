//
//  InAppPurchaseTrackRequest.h
//  NativeXPublisherSdk
//
//  This file is subject to the SDK Source Code License Agreement defined in file
//  "SDK_SourceCode_LicenseAgreement", which is part of this source code package.
//
//  Created by Bozhidar Mihaylov on 4/25/12.
//  Copyright (c) 2012 NativeX, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NativeXInAppPurchaseTrackRecord.h"

@protocol NativeXInAppPurchaseTrackDelegate;
@interface NativeXInAppPurchaseTrackRequest : NSObject

@property (nonatomic, strong) NativeXInAppPurchaseTrackRecord *trackRecord;
@property (nonatomic, weak) id<NativeXInAppPurchaseTrackDelegate> delegate;

@end


@protocol NativeXInAppPurchaseTrackDelegate <NSObject>

@optional
- (void)trackInAppPurchaseDidSucceedForRequest:(NativeXInAppPurchaseTrackRequest *)inAppPurchaseRequest;
- (void)trackInAppPurchaseForRequest:(NativeXInAppPurchaseTrackRequest *)inAppPurchaseRequest didFailWithError:(NSError *)error;

@end

