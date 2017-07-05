//
//  NativeXSDK.h
//  NativeXSDK
//
//  This file is subject to the SDK Source Code License Agreement defined in file
//  "SDK_SourceCode_LicenseAgreement", which is part of this source code package.
//
//  Created by Patrick Brennan on 10/6/11.
//  Copyright 2013 NativeX, LLC. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NativeXAdView.h"
#import "NativeXCurrency.h"
#import "NativeXRedeemedCurrencyInfo.h"
#import "NativeXReward.h"
#import "NativeXRewardInfo.h"
#import "NativeXRewardDelegate.h"
#import "NativeXInAppPurchaseTrackRequest.h"

#import "NativeXAdEventDelegate.h"
#import "NativeXAdInfo.h"

/** These are predefined placements that can be associated with Multi-Format Ads 
 *
 *  AD PLACEMENTS:
 *  - NativeX Ad Placement: a pre-defined list of game interaction points.
 *  - Custom Placement: a string that describes the interaction point of an ad within your game.
 *
 *  BENEFITS:
 *  - Higher eCPMs
 *  - Control over ad format
 *  - Enhanced Reporting
 *  - Turn off ads per placement
 **/

typedef enum {
    kAdPlacementGameLaunch,              //"Game Launch"
    kAdPlacementMainMenuScreen,          //"Main Menu Screen"
    kAdPlacementPauseMenuScreen,         //"Pause Menu Screen"
    kAdPlacementPlayerGeneratedEvent,    //"Player Generated Event"
    kAdPlacementLevelCompleted,          //"Level Completed"
    kAdPlacementLevelFailed,             //"Level Failed"
    kAdPlacementPlayerLevelsUp,          //"Player Levels Up"
    kAdPlacementP2P_CompetitionWon,      //"P2P competition won"
    kAdPlacementP2P_CompetitionLost,     //"P2P competition lost"
    kAdPlacementStoreOpen,               //"Store Open"
    kAdPlacementExitFromApp              //"Exit Ad from Application"
} NativeXAdPlacement;

//portrait: 320x50 or 768x66
//landscape: 480x32 or 1024x66
typedef enum {
    kBannerPositionTop,
    kBannerPositionBottom,
} NativeXBannerPosition;

@protocol NativeXSDKDelegate;

/** Main class for NativeXSDK */
@interface NativeXSDK : NSObject

@property (nonatomic, strong) id<NativeXSDKDelegate> delegate;
@property (nonatomic, strong) UIViewController *presenterViewController;

#pragma mark - Monetization API

- (void) setShouldOutputDebugLog:(BOOL)enable __deprecated_msg("setShouldOutputDebugLog: is deprecated; use the new [NativeXSDK enableDebugLog:(BOOL)] instead");

/** 
 * Provides access to the NativeXSDK shared object.
 *
 * @return a singleton NativeXSDK instance.
 */
+ (NativeXSDK *)sharedInstance;

/** 
 * Provides access to the NativeXSDK version
 *
 * @return NativeXSDK Version
 */
- (NSString *)getSDKVersion __deprecated_msg("instanced getSDKVersion is deprecated; use the new static [NativeXSDK getSDKVersion] method instead");

/**
 * Use this method to get sessionId for current session
 *
 * @return the current sessionId
 */
- (NSString *)getSessionId __deprecated_msg("instanced getSessionId is deprecated; use the new static [NativeXSDK getSessionId] instead");

/**
 * Create a session with NativeX offer network.
 * Call this in AppDidFinishLaunchingWithOptions{}
 *
 * @param   appId (required)
 *          the unique Identifier you receive from NativeX
 */
- (void)createSessionWithAppId:(NSString *)appId __deprecated_msg("createSessionWithAppID: is deprecated; use the new static [NativeXSDK initializeWithAppId] instead");

/**
 * Create a session with NativeX offer network.
 * Call this in AppDidFinishLaunchingWithOptions{}
 *
 * @param   appId (required) 
 *          the unique Identifier you receive from NativeX
 * @param   publisherUserId (optional) 
 *          an id that can be used for publisher currency postback
 */
- (void)createSessionWithAppId:(NSString *)appId
       andPublisherUserId:(NSString *)publisherUserId __deprecated_msg("createSessionWithAppId:andPublisherUserId: is deprecated; use the new static [NativeXSDK initializeWithAppId:andPublisherId:] instead");

/** 
 * Call to fetch and return balances for user
 * Automatically called once on create session
 *
 * @warning **Deprecated**: Please use `<redeemRewards>` instead.
 */
- (void)redeemCurrency __deprecated_msg("method is deprecated; use redeemRewards instead");


/**
 * Call to fetch and return reward balances for user
 * Automatically called once on create session
 */
- (void)redeemRewards __deprecated_msg("redeemRewards is deprecated; use the new static [NativeXSDK isRewardAvailable:] and [NativeXSDK getRewards:] instead");

/**
 * Stateless only!!  Call to fetch and return reward balances for user
 * @param rewardDelegate (required)
 *        the NativeXRewardDelegate that should be called when rewards are given
 */
- (void)redeemStatelessRewards:(id<NativeXRewardDelegate>)rewardDelegate __deprecated_msg("redeemRewards is deprecated; use the new static [NativeXSDK isRewardAvailable:] and [NativeXSDK getRewards:] instead");

#pragma mark - NativeX Ad Methods

/**
 * Checks to see if there is an ad of this placement ready 
 * to show.
 *
 * @param   placement (required)
 *          A pre-defined set of game interaction points
 */
- (BOOL)isAdReadyWithPlacement:(NativeXAdPlacement)placement __deprecated_msg("isAdReadyWithPlacement is deprecated; use the new static [NativeXSDK isAdFetchedWithPlacement:] instead");

/**
 * Checks to see if there is an ad of this placement ready
 * to show.
 *
 * @param   customPlacement (required)
 *          A string that describes the interaction point of an ad within your game
 */
- (BOOL)isAdReadyWithCustomPlacement:(NSString*)customPlacement __deprecated_msg("isAdReadyWithCustomPlacement is deprecated; use the new static [NativeXSDK isAdFetchedWithName:] instead");

/**
 * Checks to see if there is a Stateless ad of this placement ready to show.
 *
 * @param   placement (required)
 *          A pre-defined set of game interaction points
 * @param   aDelegate (required)
 *          Delegate
 */
- (BOOL) isStatelessAdReadyWithPlacement:(NativeXAdPlacement)placement delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("isStatelessAdReadyWithPlacement: is deprecated; use the new static [NativeXSDK isAdFetchedWithPlacement:] instead");

/**
 * Checks to see if there is a Stateless ad of this placement ready to show.
 *
 * @param   customPlacement (required)
 *          A string that describes the interaction point of an ad within your game
 * @param   aDelegate (required)
 *          Delegate
 */
- (BOOL) isStatelessAdReadyWithCustomPlacement:(NSString*)customPlacement delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("isStatelessAdReadyWithCustomPlacement: is deprecated; use the new static [NativeXSDK isAdFetchedWithName:] instead");

/**
 * Show a multi-format ad with a NativeX placement from key window,
 * used for targeting certain ads for certain in app placements.
 *
 * @param   placement (required) 
 *          A pre-defined set of game interaction points
 */
- (void)showAdWithPlacement:(NativeXAdPlacement)placement __deprecated_msg("instance method showAdWithPlacement: is deprecated; use the new static [NativeXSDK showAdWithPlacement:] instead");

/**
 * Show a multi-format ad  only if it is loaded and ready to instantly show with a custom
 * placement from key window, used for targeting certain ads for certain in app placements.
 *
 * @param   placement (required)
 *          A pre-defined set of game interaction points
 */
- (void)showReadyAdWithPlacement:(NativeXAdPlacement)placement __deprecated_msg("instance method showReadyAdWithPlacement: is deprecated; use the new static [NativeXSDK showAdWithPlacement:] instead");

/**
 * Show a multi-format ad  only if it is loaded and ready to instantly show with a custom
 * placement from key window, used for targeting certain ads for certain in app placements.
 *
 * @param   customPlacement (required)
 *          A string that describes the interaction point of an ad within your game
 */
- (void)showReadyAdWithCustomPlacement:(NSString *)customPlacement __deprecated_msg("instance method showReadyAdWithCustomPlacement: is deprecated; use the new static [NativeXSDK showAdWithName:] instead");

/**
 * Show a multi-format ad  only if it is loaded and ready to instantly show with a custom
 * placement from key window, used for targeting certain ads for certain in app placements.
 *
 * @param   placement (required)
 *          A pre-defined set of game interaction points
 * @param   aDelegate (required)
 *          Delegate
 */
- (void)showReadyAdStatelessWithPlacement:(NativeXAdPlacement)placement delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("instance method showReadyAdStatelessWithPlacement:delegate: is deprecated; use the new static [NativeXSDK showAdWithPlacement:andShowDelegate:] instead");

/**
 * Show a multi-format ad  only if it is loaded and ready to instantly show with a custom
 * placement from key window, used for targeting certain ads for certain in app placements.
 *
 * @param   placement (required)
 *          A pre-defined set of game interaction points
 * @param   aDelegate (required)
 *          Delegate
 * @param rootViewController (required)
 *          View controller from which to present the ad view controller
 */
- (void)showReadyAdStatelessWithPlacement:(NativeXAdPlacement)placement delegate:(id<NativeXAdViewDelegate>)aDelegate rootViewController:(UIViewController*)rootViewController __deprecated_msg("instance method showReadyAdStatelessWithPlacement:delegate:rootViewController: is deprecated; use the new static [NativeXSDK showAdWithPlacement:andShowDelegate:rootViewController:] instead");


/**
 * Show a multi-format ad (in Stateless Mode) only if it is loaded and ready to instantly show with a custom
 * placement from key window, used for targeting certain ads for certain in app placements.
 *
 * @param   customPlacement (required)
 *          A string that describes the interaction point of an ad within your game
 * @param   aDelegate (required)
 *          Delegate
 */
-(void)showReadyAdStatelessWithCustomPlacement:(NSString *)customPlacement delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("instance method showReadyAdStatelessWithCustomPlacement:delegate: is deprecated; use the new static [NativeXSDK showAdWithName:andShowDelegate:] instead");

/**
 * Show a multi-format ad (in Stateless Mode) only if it is loaded and ready to instantly show with a custom
 * placement from key window, used for targeting certain ads for certain in app placements.
 *
 * @param   customPlacement (required)
 *          A string that describes the interaction point of an ad within your game
 * @param   aDelegate (required)
 *          Delegate
 * @param rootViewController (required)
 *          View controller from which to present the ad view controller
 */
-(void)showReadyAdStatelessWithCustomPlacement:(NSString *)customPlacement delegate:(id<NativeXAdViewDelegate>)aDelegate rootViewController:(UIViewController*)rootViewController __deprecated_msg("instance method showReadyAdStatelessWithCustomPlacement:delegate:rootViewController: is deprecated; use the new static [NativeXSDK showAdWithName:andShowDelegate:rootViewcontroller:] instead");

/**
 * Show a multi-format ad with a custom placement from key window,
 * used for targeting certain ads for certain in app placements.
 * 
 * @param   customPlacement (required) 
 *          A string that describes the interaction point of an ad within your game
 */
- (void)showAdWithCustomPlacement:(NSString *)customPlacement __deprecated_msg("instance method showAdWithCustomPlacement: is deprecated; use the new static [NativeXSDK showAdWithName:] instead");

/**
 * Fetch/cache a multi-format ad that presents modally (fullscreen)
 *
 * @param   placement (required) 
 *          A pre-defined set of game interaction points
 * @param   aDelegate (optional) 
 *          used to set delegate
 */
- (void)fetchAdWithPlacement:(NativeXAdPlacement)placement delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("instance method fetchAdWithPlacement:delegate: is deprecated; use the new static [NativeXSDK fetchAdWithPlacement:andFetchDelegate:] instead");

/**
 * Fetch/cache a multi-format ad that presents modally (fullscreen)
 * 
 * @param   customPlacement (required) 
 *          A string that describes the interaction point of an ad within your game
 * @param   aDelegate (optional) 
 *          used to set delegate
 */
- (void)fetchAdWithCustomPlacement:(NSString *)customPlacement delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("instance method fetchAdWithCustomPlacement:delegate: is deprecated; use the new static [NativeXSDK fetchAdWithName:andFetchDelegate:] instead");

/**
 * Fetch/cache a multi-format ad that presents modally (fullscreen)
 *
 * @param   placement (required)
 *          A pre-defined set of game interaction points
 * @param   appId (required)
 *          the unique app identifier you receive from NativeX
 * @param   aDelegate (required)
 *          Delegate
 */
- (void)fetchAdStatelessWithPlacement:(NativeXAdPlacement)placement withAppId:(NSString*)appId delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("instance method fetchAdStatelessWithPlacement:withAppId:delegate: is deprecated; use the new static [NativeXSDK fetchAdWithPlacement:andFetchDelegate:] instead");

/**
 * Fetch/cache a multi-format ad (in Stateless Mode) that presents modally (fullscreen)
 *
 * @param   customPlacement (required)
 *          A string that describes the interaction point of an ad within your game
 * @param   appId (required)
 *          the unique app identifier you receive from NativeX
 * @param   aDelegate (required)
 *          Delegate
 */
- (void)fetchAdStatelessWithCustomPlacement:(NSString *)customPlacement withAppId:(NSString*)appId delegate:(id<NativeXAdViewDelegate>)aDelegate __deprecated_msg("instance method fetchAdStatelessWithCustomPlacement:withAppId:delegate: is deprecated; use the new static [NativeXSDK fetchAdWithPlacement:andFetchDelegate:] instead");

/**
 * Dismiss the adview (Insterstitial)
 *
 * @param   placement (required)
 *          A pre-defined game interaction point
 *
 */
- (void)dismissAdWithPlacement:(NativeXAdPlacement)placement;

/**
 * Dismiss the adview (Insterstitial)
 *
 * @param   placement (required)
 *          A custom game interaction point
 *
 */
- (void)dismissAdWithCustomPlacement:(NSString*)placement;

#pragma mark NativeX Banner Methods

/**
 *  Fetch/cache a multi-format banner that presents inline
 *
 *  @param  placement  (required)
 *          A pre-defined game interaction point
 *  @param  adPosition (required)
 *          A pre-defined ad position (top or bottom)
 *  @param  aDelegate  (optional)
 *          delegate object for protocol methods
 */

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)fetchBannerWithPlacement:(NativeXAdPlacement)placement
                        position:(NativeXBannerPosition)adPosition
                        delegate:(id<NativeXAdViewDelegate>)aDelegate;

/**
 *  Show a multi-format banner with a NativeX placement from keywindow
 *
 *  @param  placement (required)
 *          A pre-defined game interaction point
 *  @param  adPosition (required)
 *          A pre-defined NativeX ad position (top or botton)
 */
- (void)showBannerWithPlacement:(NativeXAdPlacement)placement position:(NativeXBannerPosition)adPosition;

/**
 *  Fetch/cache a multi-format banner that presents inline
 *
 *  @param  placement  (required)
 *          A string representation of game interaction point
 *  @param  adPosition (required)
 *          A pre-defined NativeX ad position (top or bottom)
 *  @param  aDelegate  (optional)
 *          delegate object for protocol methods
 */
- (void)fetchBannerWithCustomPlacement:(NSString *)placement
                              position:(NativeXBannerPosition)adPosition
                              delegate:(id<NativeXAdViewDelegate>)aDelegate;
#pragma clang diagnostic pop

/**
 *  Show a multi-format banner
 *
 *  @param  placement (required)
 *          A pre-defined game interaction point
 *  @param  adPosition (required)
 *          A pre-defined NativeX ad position (top or botton)
 */
- (void)showBannerWithCustomPlacement:(NSString *)placement position:(NativeXBannerPosition)adPosition;

/**
 * Advanced: use custom positioning by updating the frame for a fetched banner
 *
 * @param   newFrame
 *          the new position for the banner
 * @param   placement
 *          defines which banner frame you would like to update
 * @warning could result in weird layout behavior for html ad. May need to setup custom template
 */
- (void)setCustomFrame:(CGRect)newFrame forBannerWithPlacement:(NSString *)placement;

/**
 * Dismiss the adview (Banner)
 *
 * @param   placement (required)
 *          A pre-defined game interaction point
 *
 */
- (void)dismissBannerWithPlacement:(NativeXAdPlacement)placement;

/**
 * Dismiss the adview (Banner)
 *
 * @param   placement (required)
 *          A custom game interaction point
 *
 */
- (void)dismissBannerWithCustomPlacement:(NSString*)placement;

#pragma mark NativeX Ads Common Methods

/**
 *  Converts a NativeX pre-defined placement to a string
 *
 *  @param  placement (required)
 *          NativeX pre-defined placement using enum
 *
 *  @return NSString representation of NativeX placement
 */
- (NSString *)convertAdPlacementToString:(NativeXAdPlacement)placement __deprecated_msg("instance method convertAdPlacementToString: is deprecated; use static [NativeXSDK convertAdPlacementToString:] instead");
+ (NSString *)convertAdPlacementToString:(NativeXAdPlacement)placement;

- (void)resetSession;

#pragma mark - In App Purchase Tracking (IAPT) methods
/**
 * Used for In App Purchase Tracking
 * 
 * @param   trackRecord     
 *          data record of purchase
 * @param   delegate
 *          used to set delegate file
 * 
 * @return  NativeXInAppPurchaseRequest
 */
- (NativeXInAppPurchaseTrackRequest *)trackInAppPurchaseWithTrackRecord:(NativeXInAppPurchaseTrackRecord *)trackRecord
                                                               delegate:(id<NativeXInAppPurchaseTrackDelegate>)delegate; //if the delegate is about to be deallocated clear return value's delegate property

#pragma mark - NativeX Advertiser API (CPE Campaigns)

/**
 * call this to connect to NativeX and inform that the app "actionID" was performed
 * 
 * @param   actionID (required) 
 *          the unique Action Identifier for cost-per-event campaigns, you receive from NativeX
 */
- (void)actionTakenWithActionID:(NSString*)actionID;

#pragma mark - New NativeX SDK interface methods

/**
 *  Enables debug logging for the SDK, outputting additional information to console window
 *  NOTE: make sure this value is not set to "YES" when releasing to the app store!!
 *  @param enable "YES" to enable, "NO" to disable
 */
+ (void) enableDebugLog:(BOOL)enable;
/**
 *  Returns the current version of the SDK
 *  @return string SDK version
 */
+ (NSString*) getSDKVersion;
/**
 *  returns current session ID for the SDK
 *  @return current session ID string, or empty string if not initialized
 */
+ (NSString*) getSessionId;

/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId - your App ID from Self Service ( http://selfservice.nativex.com )
 */
+ (void) initializeWithAppId:(NSString *)appId;
/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId        - your App ID from Self Service ( http://selfservice.nativex.com )
 *  @param sdkDelegate  - (optional) reference to the object that implements NativeXSDKDelegate protocol (for initialization callbacks)
 */
+ (void) initializeWithAppId:(NSString *)appId andSDKDelegate:(id<NativeXSDKDelegate>)sdkDelegate;
/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId            - your App ID from Self Service ( http://selfservice.nativex.com )
 *  @param rewardDelegate   - (optional) reference to the object that implements NativeXRewardDelegate protocol (for reward callbacks)
 */
+ (void) initializeWithAppId:(NSString *)appId andRewardDelegate:(id<NativeXRewardDelegate>)rewardDelegate;
/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId            - your App ID from Self Service ( http://selfservice.nativex.com )
 *  @param sdkDelegate      - (optional) reference to the object that implements NativeXSDKDelegate protocol (for initialization callbacks)
 *  @param rewardDelegate   - (optional) reference to the object that implements NativeXRewardDelegate protocol (for reward callbacks)
 */
+ (void) initializeWithAppId:(NSString *)appId andSDKDelegate:(id<NativeXSDKDelegate>)sdkDelegate andRewardDelegate:(id<NativeXRewardDelegate>)rewardDelegate;
/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId            - your App ID from Self Service ( http://selfservice.nativex.com )
 *  @param publisherUserId  - (optional) any ID that uniquely identifies a user
 */
+ (void) initializeWithAppId:(NSString *)appId andPublisherUserId:(NSString*)publisherUserId;
/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId            - your App ID from Self Service ( http://selfservice.nativex.com )
 *  @param publisherUserId  - (optional) any ID that uniquely identifies a user
 *  @param sdkDelegate      - (optional) reference to the object that implements NativeXSDKDelegate protocol (for initialization callbacks)
 */
+ (void) initializeWithAppId:(NSString *)appId andPublisherUserId:(NSString*)publisherUserId andSDKDelegate:(id<NativeXSDKDelegate>)sdkDelegate;
/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId            - your App ID from Self Service ( http://selfservice.nativex.com )
 *  @param publisherUserId  - (optional) any ID that uniquely identifies a user
 *  @param rewardDelegate   - (optional) reference to the object that implements NativeXRewardDelegate protocol (for reward callbacks)
 */
+ (void) initializeWithAppId:(NSString *)appId andPublisherUserId:(NSString*)publisherUserId andRewardDelegate:(id<NativeXRewardDelegate>)rewardDelegate;
/**
 *  initializes the SDK, getting it ready to serve ads
 *  @param appId            - your App ID from Self Service ( http://selfservice.nativex.com )
 *  @param publisherUserId  - (optional) any ID that uniquely identifies a user
 *  @param sdkDelegate      - (optional) reference to the object that implements NativeXSDKDelegate protocol (for initialization callbacks)
 *  @param rewardDelegate   - (optional) reference to the object that implements NativeXRewardDelegate protocol (for reward callbacks)
 */
+ (void) initializeWithAppId:(NSString *)appId andPublisherUserId:(NSString*)publisherUserId andSDKDelegate:(id<NativeXSDKDelegate>)sdkDelegate andRewardDelegate:(id<NativeXRewardDelegate>)rewardDelegate;

/**
 *  Optional; Sets the SDK Delegate that will receive Initialization callbacks (success, error)
 *  @param sdkDelegate      - (optional) reference to the object that implements NativeXSDKDelegate protocol
 */
+ (void) setSDKDelegate:(id<NativeXSDKDelegate>)sdkDelegate;
/**
 *  Optional; Sets the Reward delegate that will receive reward callbacks when rewards are available
 *  @param rewardDelegate   - (optional) reference to the object that implements NativeXRewardDelegate protocol (for reward callbacks)
 */
+ (void) setRewardDelegate:(id<NativeXRewardDelegate>)rewardDelegate;
/**
 *  Optional; Sets an Ad Event delegate that will receive all ad based events (fetched, show, etc).  This delegate is global; it will receive
 *  all Ad Event calls for every ad in the system.  Note that if an ad event delegate is specified for a single ad (fetch or call), this global
 *  delegate will not get called (ad-specific delegate takes precedence).
 *  @param adEventDelegate - (optional) reference to the object that implements NativeXAdEventDelegate protocol (for ad events)
 */
+ (void) setAdEventDelegate:(id<NativeXAdEventDelegate>)adEventDelegate;

/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placement - NativeXAdPlacement (enum) value for predefined placement in Self Service
 */
+ (void) fetchAdsAutomaticallyWithPlacement:(NativeXAdPlacement)placement;
/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement.
 */
+ (void) fetchAdsAutomaticallyWithPlacement:(NativeXAdPlacement)placement andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate;
/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param enabled          - BOOL value that determines whether placement should be automatically fetched (YES) or not automatically fetched (NO)
 */
+ (void) fetchAdsAutomaticallyWithPlacement:(NativeXAdPlacement)placement enabled:(BOOL)enabled;
/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement.
 *  @param enabled          - (optional) BOOL value that determines whether placement should be automatically fetched (YES) or not automatically fetched (NO)
 */
+ (void) fetchAdsAutomaticallyWithPlacement:(NativeXAdPlacement)placement andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate enabled:(BOOL)enabled;
/**
 *  Will set the given placement list to automatically fetch from NativeX's servers when possible.
 *  @param placementList    - Array of either NativeXAdPlacement (enum) values, or NSString* placement names, that should be automatically fetched
 */
+ (void) fetchAdsAutomaticallyWithList:(NSArray*)placementList;
/**
 *  Will set the given placement list to automatically fetch from NativeX's servers when possible.
 *  @param placementList    - Array of either NativeXAdPlacement (enum) values, or NSString* placement names, that should be automatically fetched
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement placement.
 */
+ (void) fetchAdsAutomaticallyWithList:(NSArray*)placementList andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate;
/**
 *  Will set the given placement list to automatically fetch from NativeX's servers when possible.
 *  @param placementList    - Array of either NativeXAdPlacement (enum) values, or NSString* placement names, that should be automatically fetched
 *  @param enabled          - (optional) BOOL value that determines whether placement should be automatically fetched (YES) or not automatically fetched (NO)
 */
+ (void) fetchAdsAutomaticallyWithList:(NSArray*)placementList enabled:(BOOL)enabled;
/**
 *  Will set the given placement list to automatically fetch from NativeX's servers when possible.
 *  @param placementList    - Array of either NativeXAdPlacement (enum) values, or NSString* placement names, that should be automatically fetched
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement
 *  @param enabled          - (optional) BOOL value that determines whether placement should be automatically fetched (YES) or not automatically fetched (NO)
 */
+ (void) fetchAdsAutomaticallyWithList:(NSArray*)placementList andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate enabled:(BOOL)enabled;
/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placementName    - String of a custom placement name from Self Service
 */
+ (void) fetchAdsAutomaticallyWithName:(NSString *)placementName;
/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placementName    - String of a custom placement name from Self Service
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement
 */
+ (void) fetchAdsAutomaticallyWithName:(NSString *)placementName andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate;
/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placementName    - String of a custom placement name from Self Service
 *  @param enabled          - (optional) BOOL value that determines whether placement should be automatically fetched (YES) or not automatically fetched (NO)
 */
+ (void) fetchAdsAutomaticallyWithName:(NSString *)placementName enabled:(BOOL)enabled;
/**
 *  Will set the given placement to automatically fetch from NativeX's servers when possible.
 *  @param placementName    - String of a custom placement name from Self Service
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement
 *  @param enabled          - (optional) BOOL value that determines whether placement should be automatically fetched (YES) or not automatically fetched (NO)
 */
+ (void) fetchAdsAutomaticallyWithName:(NSString *)placementName andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate enabled:(BOOL)enabled;

/**
 *  Fetches an ad with the given placement name from NativeX's servers
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 */
+ (void) fetchAdWithPlacement:(NativeXAdPlacement)placement;
/**
 *  Fetches an ad with the given placement name from NativeX's servers
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement.
 */
+ (void) fetchAdWithPlacement:(NativeXAdPlacement)placement andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate;
/**
 *  Fetches an ad with the given placement name from NativeX's servers
 *  @param placementName    - String of a custom placement name from Self Service
 */
+ (void) fetchAdWithName:(NSString *)placementName;
/**
 *  Fetches an ad with the given placement name from NativeX's servers
 *  @param placementName    - String of a custom placement name from Self Service
 *  @param fetchDelegate    - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive fetch events for the given placement.
 */
+ (void) fetchAdWithName:(NSString *)placementName andFetchDelegate:(id<NativeXAdEventDelegate>)fetchDelegate;

/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @return                 - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement;
/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param showDelegate     - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @return                 - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate;
/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param fetchNow         - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @return                 - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement fetchNowIfNeeded:(BOOL)fetchNow;
/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement            - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement rootViewController:(UIViewController*)rootViewcontroller;
/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement        - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param showDelegate     - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @param fetchNow         - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @return                 - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate fetchNowIfNeeded:(BOOL)fetchNow;
/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement            - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param showDelegate         - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate rootViewController:(UIViewController*)rootViewcontroller;
/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement            - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param fetchNow             - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement fetchNowIfNeeded:(BOOL)fetchNow rootViewController:(UIViewController*)rootViewcontroller;
/**
 *  Shows an already fetched ad with the given pre-defined placement.
 *  @param placement            - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @param showDelegate         - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @param fetchNow             - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithPlacement:(NativeXAdPlacement)placement andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate fetchNowIfNeeded:(BOOL)fetchNow rootViewController:(UIViewController*)rootViewcontroller;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithName:(NSString *)placementName;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @param showDelegate         - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithName:(NSString *)placementName andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @param fetchNow             - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithName:(NSString *)placementName fetchNowIfNeeded:(BOOL)fetchNow;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithName:(NSString *)placementName rootViewController:(UIViewController*)rootViewcontroller;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @param showDelegate         - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @param fetchNow             - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithName:(NSString *)placementName andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate fetchNowIfNeeded:(BOOL)fetchNow;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @param showDelegate         - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If no, will not show the ad
 */
+ (BOOL) showAdWithName:(NSString *)placementName andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate rootViewController:(UIViewController*)rootViewcontroller;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @param fetchNow             - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithName:(NSString *)placementName fetchNowIfNeeded:(BOOL)fetchNow rootViewController:(UIViewController*)rootViewcontroller;
/**
 *  Shows an already fetched ad with the given custom placement name.
 *  @param placementName        - String for the custom placement name in Self Service
 *  @param showDelegate         - (optional) reference to the object that implements NativeXAdEventDelegate protocol; will receive show events for the given placement.
 *  @param fetchNow             - (optional) flag for whether the ad should be fetched immediately if it is not ready to be shown.
 *  @param rootViewcontroller   - (optional) UIViewController that shouold be set as the root view controller for the ad
 *  @return                     - YES if the placement is fetched and ready to be shown; NO if it is not ready.  If fetchNow == YES, the function will return NO, will immediately fetch the given placement and immediately show after it is fetched.
 */
+ (BOOL) showAdWithName:(NSString *)placementName andShowDelegate:(id<NativeXAdEventDelegate>)showDelegate fetchNowIfNeeded:(BOOL)fetchNow rootViewController:(UIViewController*)rootViewcontroller;

/**
 *  Will return whether the given pre-defined placement is fetched and ready to be shown.
 *  @param placement    - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @return             - YES if the placement is fetched and ready to be shown, NO otherwise
 */
+ (BOOL) isAdFetchedWithPlacement:(NativeXAdPlacement)placement;
/**
 *  Will return whether the given custom placement name is fetched and ready to be shown.
 *  @param placementName    - String for the custom placement name in Self Service
 *  @return                 - YES if the placement is fetched and ready to be shown, NO otherwise
 */
+ (BOOL) isAdFetchedWithName:(NSString *)placementName;

/**
 *  Gets the NativeXAdInfo object for the given pre-defined placement
 *  @param placement    - NativeXAdPlacement (enum) value for predefined placement in Self Service
 *  @return             - the NativeXAdInfo object for the given placement
 */
+ (NativeXAdInfo*) getAdInfoWithPlacement:(NativeXAdPlacement)placement;
/**
 *  Gets the NativeXAdInfo object for the given custom placement name
 *  @param placementName    - String for the custom placement name in Self Service
 *  @return                 - the NativeXAdInfo object for the given placement
 */
+ (NativeXAdInfo*) getAdInfoWithName:(NSString*)placementName;

/**
 *  Checks to see if any rewards are availabe to be given to the user.  Returns whether any stored rewards are found, 
 *  and starts a new rewards check to NativeX's servers.
 *  @return - YES if any rewards are available to be given; NO otherwise.
 */
+ (BOOL) isRewardAvailable;
/**
 *  Returns any rewards that are available to be given to the user.  All rewards returned by this method will be cleared from the SDK's internal
 *  cache; make sure these rewards are applied to your user after calling this method.
 *  @return     - the NativeXRewardInfo object containing an array of NativeXReward objects that should be given to your user.
 */
+ (NativeXRewardInfo*) getRewards;

/**
 * NativeX custom settings.  Do not use unless explicitly directed by NativeX!
 */
+ (void) disableBackupAds;
+ (void) disableLightningPlay;

@end

#pragma mark - Monetization Protocol Definition

@protocol NativeXSDKDelegate <NSObject>

#pragma mark Required Delegate Methods
@required

@optional

/** Called when the Offer Wall is successfully initialized. */
- (void)nativeXSDKDidCreateSession __deprecated_msg("nativeXSDKDidCreateSession: protocol method is deprecated; use (optional) nativeXSDKInitialized: protocol method instead");

/** Called when there is an error trying to initialize the Offer Wall. 
 *
 * @param   error
 *          reason why create session call failed
 */
- (void)nativeXSDKDidFailToCreateSession: (NSError *) error  __deprecated_msg("nativeXSDKDidFailToCreateSession: protocol method is deprecated; use (optional) nativeXSDKFailedToInitializeWithError: protocol method instead");

/** Called when the currency redemption is unsuccessfull.
 *
 * @param   error
 *          reason why redeem currency call failed
 */
- (void)nativeXSDKDidRedeemWithError:(NSError *)error __deprecated_msg("nativeXSDKDidRedeemWithError: is deprecated (no replacements available)");


/** Called when the currency redemption is successfull.
 *
 * @param   redeemedCurrencyInfo
 *          an object containing messages, balances and recieptIDs
 * @warning **Deprecated**: Please implement [nativeXSDKDidRedeemWithRewardsInfo] delegate instead.
 */
- (void)nativeXSDKDidRedeemWithCurrencyInfo:(NativeXRedeemedCurrencyInfo *)redeemedCurrencyInfo __deprecated_msg("method is deprecated; use the NativeXRewardDelegate protocol's rewardAvailable: method instead");

/** Called when the rewards redemption is successful.
 *
 * @param rewardInfo
 *        an object containing the list of reciepts, as well as some helper methods
*/
- (void)nativeXSDKDidRedeemWithRewardInfo:(NativeXRewardInfo*)rewardInfo __deprecated_msg("method is deprecated; use the NativeXRewardDelegate protocol's rewardAvailable: method instead");


/** Called when redirecting user away from application (safari or app store) */
- (void)nativeXSDKWillRedirectUser __deprecated_msg("method is deprecated; use the NativeXAdEventDelegate protocol's userRedirected: method instead");

#pragma mark new interface delegate methods - all optional

/**
 *  Optional protocol method that is called when the SDK has finished initializing and is ready to fetch/show ads.
 */
- (void)nativeXSDKInitialized;
/**
 *  Optional protocol method that is called when the SDK has failed to initialize for some reason.
 *  @param error    - error object that describes the exact error encountered by the SDK
 */
- (void)nativeXSDKFailedToInitializeWithError:(NSError*) error;

@end
