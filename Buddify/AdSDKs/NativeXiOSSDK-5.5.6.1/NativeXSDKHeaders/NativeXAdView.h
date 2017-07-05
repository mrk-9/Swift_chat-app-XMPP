//
//  NativeXAdView.h
//  NativeXSDK
//
//  This file is subject to the SDK Source Code License Agreement defined in file
//  "SDK_SourceCode_LicenseAgreement", which is part of this source code package.
//
//  Created by Ash Lindquist on 6/4/13.
//  Copyright (c) 2013 NativeX, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Ad placement type. */
typedef enum
{
    /// Ad is placed in application content.
    nativeXAdViewPlacementTypeInline = 0,
    
    /// Ad is placed over and in the way of application content.
    /// Generally used to place an ad between transitions in an application
    /// and consumes the entire screen.
    nativeXAdViewPlacementTypeInterstitial
    
} nativeXAdViewPlacementType;

@protocol NativeXAdViewDelegate;

@interface NativeXAdView : UIView <UIWebViewDelegate>

/** delegate file for ad view. */
@property (nonatomic, strong) id<NativeXAdViewDelegate> delegate;

/** Placement Type = Interstitial or Inline */
@property (nonatomic, readonly) nativeXAdViewPlacementType placementType;

/** give your ad a placement name to recall it (game interaction point)*/
@property (nonatomic, strong) NSString *placement;

/** Offer Ids = Array of all Offers contained in the AdView */
@property (nonatomic, readonly) NSArray *offerIds;

/** willPlayAudio = BOOL that is true if the ad will play audio (example: Video ad) */
@property (nonatomic, readonly) BOOL willPlayAudio;

/** adBehaviors = NSDictionry that stores ad behavior data like willPlayAudio */
@property (nonatomic, readonly) NSDictionary *adBehaviors;

/** adInfo = NSDictionry that stores ad adInfo and adBehavior*/
@property (nonatomic, readonly) NSDictionary *adInfo;

/** adHtml = NSString that stores the adViews ad html */
@property (nonatomic, readonly) NSString *adHtml;

/** View Controller that will be used to present view */
@property (nonatomic, strong) UIViewController *presentingViewController;

/** read only property to see if this ad will call redeem currency on dismiss **/
@property (nonatomic, readonly) BOOL shouldRedeemCurrencyOnDismiss;

/** read only property that denotes whether the adview redirected the user (on click) **/
@property (nonatomic, readonly) BOOL didRedirectUser;

/** if this is YES, NativeX will attempt to resize banner on device rotation (if app alllows rotation) **/
@property (nonatomic, assign) BOOL shouldUseNativeXBannerPositioning;

/** Asset MD5s = Array of asset md5's used in the AdView */
@property (nonatomic, readonly) NSArray *assetMD5s;

/** isAdReady = BOOL that is true if the ad content is loaded and ready to show */
@property (nonatomic, readonly) BOOL isAdReady;

/**
 * Advanced: call to initialize an instance of an interstitial ad
 * @see NativeXSDK/convertAdPlacementToString for using NativeX pre-defined placements
 *
 * @param placement     a string that describes the interaction point of an ad within a game
 * @param aDelegate     the delegate file to use for this interstitial instance
 *
 * @return              NativeXAdView Ad view with placementType = interstitial
 */
- (id)initWithPlacement:(NSString *)placement delegate:(id<NativeXAdViewDelegate>)aDelegate;

/**
 * Advanced: call to initialize an instance of an inline ad (banner)
 * @see NativeXSDK/convertAdPlacementToString for using NativeX pre-defined placements
 *
 * @param placement     a string that describes the interaction point of an ad within a game
 * @param aDelegate     the delegate file to use for this inline instance
 *
 * @return              NativeXAdView Ad view with placementType = inline
 */
- (id)initWithFrame:(CGRect)frame
          placement:(NSString *)placement
           delegate:(id<NativeXAdViewDelegate>)aDelegate;

/**
 * Advanced: update inline ad frame once loaded
 * ads may not display/look as expected
 *
 * @param frame             new default position for banner/inline ad
 * @param completionBlock   (block) allow action on completion (BOOL didUpdate)
 */
- (void)updateAdViewFrame:(CGRect)frame
               completion:(void(^)(BOOL didUpdate))completionBlock;

/** call to display the ad once the content has been loaded */
- (void)displayAdView;

/** call to display the ad from presenting VC once the content has been loaded */
- (void)displayAdView:(UIViewController *) presentingVC;

/** call to dismiss ad */
- (void)dismissAdView;

/** called when application enters foreground */
- (void)adWillEnterForeground;

@end

#pragma mark - NativeX Ad View Protocol Definition

__deprecated_msg("NativeXAdViewDelegate protocol is deprecated for interstitial and video placements.  Please use NativeXAdEventDelegate protocol instead.")
// TODO_v6: move this delegate into separate header, remove deprecated message (still needed for inline and base sdk)
@protocol NativeXAdViewDelegate <NSObject>

#pragma mark Optional Delegate Methods
@optional

/** Called when SDK needs to get presentingVC for displaying the adView
 * presentingViewController defaults to the keyWindow's rootviewcontroller,
 * but this method can be used to set a specific parent view controller for the AdView
 *
 * @param adView        the NativeX adView that will be the child view
 * @return              UIViewController the view controller that will be used as parent to adView
 */
- (UIViewController *)presentingViewControllerForAdView:(NativeXAdView *) adView;

/** Called when adView is loaded and ready to be displayed
 * use this method to override when adView is displayed
 * If this delegate does not exist when caching an ad it will be shown immediately
 *
 * @param adView        the NativeX adView that has been loaded
 * @param placement     NSString representation of placement, used to distinquish which ad is loaded
 */
- (void)nativeXAdView:(NativeXAdView *)adView didLoadWithPlacement:(NSString *)placement;

/** called if no ad is available at this time
 *
 * @param adView        the NativeX adView that has NOT been loaded
 */
- (void)nativeXAdViewNoAdContent:(NativeXAdView *)adView;

/** Called when error loading an ad (was the SDK initialized correctly?)
 *
 * @param adView        the NativeX adView that has NOT been loaded because of an error
 * @param error         reason why ad failed to load
 */
- (void)nativeXAdView:(NativeXAdView *)adView didFailWithError:(NSError *)error;

/** Called when ad content has expired for specific adView
 *
 * @param adView        the NativeX adView that has expired
 */
- (void)nativeXAdViewDidExpire:(NativeXAdView *)adView;

/** called right before an ad will be displayed
 *
 * @param adView        the NativeX adView that will be displayed
 */
- (void)nativeXAdViewWillDisplay:(NativeXAdView *)adView;

/** called after an ad has been displayed on screen
 *
 * @param adView        the NativeX adView that displayed
 */
- (void)nativeXAdViewDidDisplay:(NativeXAdView *)adView;

/** called right before an inline ad will change size (non-modal)
 *
 * @param adView        the NativeX adView that will change size
 * @param newFrame      the new size and position of ad
 */
- (void)nativeXAdView:(NativeXAdView *)adView willResizeToFrame:(CGRect)newFrame;

/** called after inline ad has resized (non-modal)
 *
 * @param adView        the NativeX adView that changed size
 * @param newFrame      the new size and position of ad
 */
- (void)nativeXAdView:(NativeXAdView *)adView didResizeToFrame:(CGRect)newFrame;

/** called right before an inline ad will expand to take up full screen (modal)
 *
 * @param adView        the NativeX adView that will expand
 */
- (void)nativeXAdViewWillExpand:(NativeXAdView *)adView;

/** called after an inline ad has expanded to take up full screen (modal)
 *
 * @param adView        the NativeX adView that expanded
 */
- (void)nativeXAdViewDidExpand:(NativeXAdView *)adView;

/** called right before inline ad will collapse back to default size
 *
 * @param adView        the NativeX adView that will collapse
 */
- (void)nativeXAdViewWillCollapse:(NativeXAdView *)adView;

/** called after inline ad collapses back to default size
 *
 * @param adView        the NativeX adView that collapsed
 */
- (void)nativeXAdViewDidCollapse:(NativeXAdView *)adView;

/** called right before an ad will be dismissed (removed from screen)
 *
 * @param adView        the NativeX adView that will be dismissed
 */
- (void)nativeXAdViewWillDismiss:(NativeXAdView *)adView;

/** called after an ad has been dismissed (removed from screen)
 *
 * @param adView        the NativeX adView that was dismissed
 */
- (void)nativeXAdViewDidDismiss:(NativeXAdView *)adView;

/** Used for capturing rich media events 
 *
 * @param adView        the NativeX adView for which the rich media request was fired.
 * @param event         The rich media event that was fired
 */
- (void)nativeXAdView:(NativeXAdView *)adView didProcessRichmediaRequest:(NSURLRequest*)event;

/** Called when redirecting user away from application (safari or app store).  
 *  If delegate is implemented, nativeXSDKWillRedirectUser will not be called
 * 
 * @param adView        the NativeX adView that will redirect the user
 */
- (void)nativeXAdViewWillRedirectUser:(NativeXAdView *)adView;

/** called when an Ad has converted; if rewarded placement, rewards will be awarded to the user
  *
  * @param placementName    The placement name of the ad that has converted
  */
- (void)nativeXAdViewAdConverted:(NSString*) placementName;

@end

