//
//  NativeXAdDelegate.h
//  NativeXSDK
//
//  Created by Joel Braun on 2015.08.10.
//
//  Copyright 2015 NativeX, LLC. All rights reserved.

#import <Foundation/Foundation.h>

/**
 *  Protocol defining different Ad events that NativeX Ads may go through in their lifecycle of the SDK.
 *  All protocol methods are optional; can be defined or ignored at the app developer's discretion.
 */
@protocol NativeXAdEventDelegate <NSObject>

@optional

#pragma mark - Fetch delegate methods

/**
 *  Called when the ad is successfully fetched from NativeX's servers, and is ready to be displayed
 *  @param placementName    - the placement name string of the Ad that was fetched.
 */
- (void) adFetched:(NSString*)placementName;
/**
 *  Called when there is no ad available at this time.
 *  @param placementName    - the placement name string that has no ads available.
 */
- (void) noAdAvailable:(NSString*)placementName;
/**
 *  Called when there was an error fetching the ad from NativeX's servers *
 *  @param placementName    - the placement name string of the Ad that failed to fetch.
 *  @param error            - error object that describes the exact error encountered when fetching the ad
 */
- (void) adFetchFailed:(NSString*)placementName withError:(NSError*)error;

#pragma mark - Show delegate methods

/**
 *  Called when the SDK needs to get the presenting View Controller for displaying the ad.
 *  if your delegate omits this method or returns nil, presentingViewController will default to the keyWindow's rootViewController,
 *  but this method can be used to set a specific parent view controller for the AdView
 *  Note: if the rootViewController is specified in the [NativeXSDK showAd:] call, this delegate will not be called.
 *  @param placementName    - the placement name string of the Ad that will be shown.
 *  @return                 - delegate should return the UIViewController that should be used as the parent for the ad
 */
- (UIViewController *)presentingViewControllerForAd:(NSString*) placementName;
/**
 *  Called when the ad has expired for the specific placement.  If Autofetch is on, the ad will be automatically fetched again;
 *  otherwise your app should fetch the ad again.
 *  @param placementName    - the placement name string of the Ad that has expired.
 */
- (void) adExpired:(NSString*)placementName;
/**
 *  Called right after the ad is displayed on the device
 *  @param placementName    - the placement name string of the Ad that has been displayed
 */
- (void) adShown:(NSString*)placementName;
/**
 *  Called when the ad failed to display for some reason
 *  @param placementName    - the placement name string of the Ad that failed to be displayed.
 *  @param error            - error object that describes the exact error encountered when showing the ad
 */
- (void) adFailedToShow:(NSString*)placementName withError:(NSError*)error;
/**
 *  Called when the ad is redirecting away from the application, to either Safari or App Store.  
 *  Occurs when the user clicks on an ad.
 *  @param placementName    - the placement name string of the Ad that will redirect away from the app.
 */
- (void) userRedirected:(NSString*)placementName;
/**
 *  Called when the rewarded Ad has converted, and rewards will be given to the user
 *  Will only be fired with rewarded ad placements.
 *  @param placementName    - the placement name string of the Ad that has converted.
 */
- (void) adConverted:(NSString*)placementName;
/**
 *  Called when the ad has been dismissed from being displayed, and control will return to your app
 *  @param placementName    - the placement name string of the Ad that has been dismissed.
 *  @param converted        - BOOL describing whether the ad has converted; rewarded ad placement only.  Has no meaning on non-rewarded ad placements (will be NO)
 */
- (void) adDismissed:(NSString*)placementName converted:(BOOL)converted;


@end

