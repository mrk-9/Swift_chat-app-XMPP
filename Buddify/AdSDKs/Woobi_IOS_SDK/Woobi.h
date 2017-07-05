//
//  Woobi.h
//  Woobi
//
//  Created by Noam Segev IOS Dev Team on 9/20/14.
//  Copyright (c) 2014 Woobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, WoobiError) {
    _WOOBI_API_ERROR_INIT_FAILED,
    _WOOBI_API_ERROR_USER_OPT_OUT,
    _WOOBI_API_ERROR_INVALID_APP,
    _WOOBI_API_ERROR_INVALID_CLIENT,
    _WOOBI_API_ERROR_NO_INTERNET_CONNECTION,
    _WOOBI_API_ERROR_SERVER,
    _WOOBI_API_ERROR_NO_OFFERS,
    _WOOBI_API_ERROR_OPEN_OFFER,
    _WOOBI_API_ERROR_FRAUD,
    _WOOBI_API_ERROR_FAILED_LOADING_CONFIG,
    _WOOBI_API_ERROR_FAILED_LOADING_ASSETS,
    _WOOBI_API_ERROR_FAILED_LOADING_LOCALISATIONS,
    _WOOBI_API_ERROR_INVALID_COUNT_LISTENER,
    _WOOBI_API_ERROR_SPONSORED_BY_OBJECT_INVALID,
    _WOOBI_API_ERROR_MISSING_PARENT_CONTEXT,
    _WOOBI_API_ERRROR_ALREADY_RUNNING,
    _WOOBI_API_ERRROR_INVALID_AD_TYPE,
    _WOOBI_API_ERROR_INVALID_GET_POINTS_LISTENER,
    _WOOBI_API_ERROR_ALREADY_INITIALIZING
};

typedef NS_ENUM(NSInteger, WoobiAdType) {
    _WOOBI_AUTO_SELECT    = 0,
    _WOOBI_PURCHASE       = 1,
    _WOOBI_FREE_TRIAL     = 2,
    _WOOBI_REGISTRATION   = 3,
    _WOOBI_MOBILE_CONTENT = 4,
    _WOOBI_VIDEO          = 5,
    _WOOBI_APP_INSTALL    = 6
};

typedef NS_ENUM(NSInteger, WoobiAnimationType) {
    _WOOBI_NONE
};


@protocol WoobiEventListener

- (void) onInitialized;

- (void) onError:(WoobiError) error;

- (void) onShowOffers;

- (void) onCloseOffers;

- (void) onShowPopup;

- (void) onClosePopup;

@end

@protocol WoobiCountListener

- (void) onError:(WoobiError) error;

- (void) onOffersCount:(int) count;

- (void) onPopupCount:(int) count;

@end

@protocol WoobiGetPointsListener

- (void) onPointsRetrieved:(double) points;

- (void) onError:(WoobiError) error;

@end

@interface WoobiSponsoredBy : NSObject

@property (nonatomic, strong)    NSString* mUrl;
@property (nonatomic, strong)    NSString* mBrandImageUrl;
@property (nonatomic, strong)    NSString* mBrandName;
@property (nonatomic, readwrite) double    mCredits;
@property (nonatomic, strong)    NSString* mCreditsName;
@property (nonatomic, readwrite) WoobiAdType mType;
@property (nonatomic, readwrite) int mAdId;


@end

@protocol WoobiGetSponosoredByListener

- (void) onSponsoredByReceived:(WoobiSponsoredBy*) sponsoredByObject;

- (void) onError:(WoobiError) error;

@end

@interface Woobi : NSObject

+ (void) start;
+ (void) setEventListener:(id<WoobiEventListener>) listener;
+ (id<WoobiEventListener>) getEventListener;
+ (NSString *)getVersion;
+ (BOOL) isVerbose;
+ (void) setVerbose:(BOOL) isVerbose;
+ (BOOL) isStaging;
+ (void) setStaging:(BOOL) isStaging;
+ (NSString*) woobiErrorToString:(WoobiError) woobiError;

//show an offer wall
+ (void) showOffers:(UIViewController*)parentViewController :(NSString*)appId :(NSString*)clientId :(NSString*)customParams :(NSString*)userStat :(NSString*)level;

//shows a video popup
+ (void) showPopup:(UIViewController*)parentViewController :(NSString*)appId :(NSString*)clientId :(NSString*)customParams :(NSString*)userStat :(NSString*)level :(WoobiAnimationType) animationType;

//shows an app install popup
+ (void) showNonIncentivizedPopup:(UIViewController*)parentViewController :(NSString*)appId :(NSString*)clientId :(NSString*)customParams :(NSString*)userStat :(NSString*)level :(WoobiAdType) adType :(WoobiAnimationType) animationType;

//shows sponsored by
+ (void) getSponsoredBy:(UIViewController*)parentViewController :(NSString*)appId :(NSString*)clientId :(NSString*)customParams :(NSString*)userStat :(NSString*)level sponsoredByListener:(id<WoobiGetSponosoredByListener>) sponsoredByListener :(BOOL) showDefault;

//shows sponsored by
+ (void) showSponsoredBy:(UIViewController*)parentViewController :(WoobiSponsoredBy*) sponsoredByObject;

+ (void) getOffersCount:(id<WoobiCountListener>) countListener  :(NSString*)appId :(NSString*)clientId :(NSString*)customParams :(NSString*)userStat :(NSString*)level;

+ (void) getPopupsCount:(id<WoobiCountListener>) countListener  :(NSString*)appId :(NSString*)clientId :(NSString*)customParams :(NSString*)userStat :(NSString*)level;

+ (void) getPoints:(NSString*)appId :(NSString*)clientId :(NSString*)secretKey :(id<WoobiGetPointsListener>) pointsListener;

@end

