//
// MSRangeSlider.h
//
// Created by Maksym Shcheglov on 2015-05-07.
// Copyright (c) 2015 Maksym Shcheglov.
// License: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
    IB_DESIGNABLE

/**
 *  The MSRangeSlider class implements the range slider control.
 */
@interface MSRangeSlider : UIControl

/**
 *  The slider's minimum value. The default value is 0.0. Should be lower than maximumValue.
 */
@property (nonatomic, assign) IBInspectable CGFloat minimumValue;
/**
 *  The slider's maximum value. The default value is 1.0. Should be higher than minimumValue.
 */
@property (nonatomic, assign) IBInspectable CGFloat maximumValue;
/**
 *  The minimum diapason between sliders. The default value is 0.1.
 */
@property (nonatomic, assign) IBInspectable CGFloat minimumInterval;
/**
 *  The color used to tint the selected range.
 */
@property (nonatomic, strong) IBInspectable UIColor *selectedTrackTintColor;// UI_APPEARANCE_SELECTOR;
/**
 *  The color used to tint the unselected range.
 */
@property (nonatomic, strong) IBInspectable UIColor *trackTintColor;// UI_APPEARANCE_SELECTOR;
/**
 *  The color used to tint the thumbs.
 */
@property (nonatomic, strong) IBInspectable UIColor *thumbTintColor;// UI_APPEARANCE_SELECTOR;
/**
 *  The left handle's position. The default value is 0.0. this value will be pinned to min/max.
 */
@property (nonatomic, assign) IBInspectable CGFloat fromValue;
/**
 *  The right handle's position. The default value is 1.0. this value will be pinned to min/max.
 */
@property (nonatomic, assign) IBInspectable CGFloat toValue;

@end

NS_ASSUME_NONNULL_END
