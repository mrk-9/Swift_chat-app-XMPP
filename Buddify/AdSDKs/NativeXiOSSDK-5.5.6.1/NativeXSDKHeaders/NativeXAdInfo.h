//
//  NativeXAdInfo.h
//  NativeXSDK
//
//  Created by Joel Braun on 2015.08.10.
//
//  Copyright 2015 NativeX, LLC. All rights reserved.

#import <Foundation/Foundation.h>

/**
 Enum describing the current state of the ad in the NativeX SDK
 */
typedef enum {
    AdStateInit = 0,                    // initial state; ad is not fetched
    AdStateFetching,                    // ad is in the progress of being fetched from NativeX's servers
    AdStateFetched,                     // ad has been successfully fetched from NativeX's servers
    AdStateFetchFailed,                 // ad fetch has failed; check console logs for reason
    AdStateNoAdAvailable,               // no ad is available for the given placement
    AdStateExpired,                     // ad has expired, and will not be available for display
    AdStateWillShow,                    // ad is in the process of being displayed on the user's screen
    AdStateShowing,                     // ad is currently been displayed on the user's screen
    AdStateShowFailed,                  // ad show has failed; check console logs for reason
    AdStateShowingUserRedirected,       // ad has redirected out of the application, to either Safari or App Store
    AdStateDismissed                    // ad has finished showing, and has been dismissed
} AdState;

/**
 *  NativeXAdInfo describes information about a given ad placement; its current state and features of the ad
 */
@interface NativeXAdInfo : NSObject

/**
 *  the Placement name string of the ad as defined in Self Service and passed to the SDK from your app
 */
@property (nonatomic, strong, readonly)     NSString*       placementName;
/**
 *  Current state of the ad, as defined by the AdState enum values
 */
@property (nonatomic, readonly)             AdState         adState;
/**
 *  Boolean denoting whether the ad will play audio or not; if it will, your app should mute or pause any audio that it is playing
 */
@property (nonatomic, readonly)             BOOL            willPlayAudio;
/**
 *  Whether the ad has converted or not and rewards will be given to the user.  Only applicable to rewarded ad placements.
 *  Will only be YES after the rewarded ad has actually converted
 */
@property (nonatomic, readonly)             BOOL            converted;

// overriding description method from NSObject
- (NSString *) description;

/**
 *  Helper function in converting AdState enum values to string values (for logging purposes)
 *  @param state    - AdState enum value to convert to a string
 *  @return         - string value of the AdState passed to the method
 */
+ (NSString*) adEventStateToString:(AdState) state;

@end
