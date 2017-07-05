//
// MSRangeSlider.m
//
// Created by Maksym Shcheglov on 2015-05-07.
// Copyright (c) 2015 Maksym Shcheglov.
// License: http://opensource.org/licenses/MIT
//

#import "MSRangeSlider.h"
#import "UIControl+HitTestEdgeInsets.h"

static CGFloat const kRangeSliderTrackHeight = 2.0f;
static CGFloat const kRangeSliderDimension = 28.0f;
static CGFloat const kThumbViewEdgeInset = -7.5f;

@interface MSThumbView : UIControl
@property (nonatomic, strong) CALayer *thumbLayer;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIGestureRecognizer* gestureRecognizer;
@end

@implementation MSThumbView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        self.thumbLayer = [CALayer layer];

        self.thumbLayer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.4].CGColor;
        self.thumbLayer.borderWidth = .5;
        self.thumbLayer.cornerRadius = kRangeSliderDimension / 2;
        self.thumbLayer.backgroundColor = [UIColor whiteColor].CGColor;
        self.thumbLayer.shadowColor = [UIColor blackColor].CGColor;
        self.thumbLayer.shadowOffset = CGSizeMake(0.0, 3.0);
        self.thumbLayer.shadowRadius = 2;
        self.thumbLayer.shadowOpacity = 0.3f;
        [self.layer addSublayer:self.thumbLayer];
        self.gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
        [self addGestureRecognizer:self.gestureRecognizer];
    }

    return self;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    if (layer != self.layer) {
        return;
    }

    self.thumbLayer.bounds = CGRectMake(0, 0, kRangeSliderDimension, kRangeSliderDimension);
    self.thumbLayer.position = CGPointMake(kRangeSliderDimension / 2, kRangeSliderDimension / 2);
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    self.thumbLayer.backgroundColor = tintColor.CGColor;
}

@end

@interface MSRangeSlider ()

@property (nonatomic, strong) CALayer *trackLayer;
@property (nonatomic, strong) CALayer *selectedTrackLayer;

@property (nonatomic, strong) MSThumbView *fromThumbView;
@property (nonatomic, strong) MSThumbView *toThumbView;

@end

@implementation MSRangeSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self ms_init];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self ms_init];
    }

    return self;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kRangeSliderDimension);
}

- (void)layoutSubviews
{
    [self ms_updateThumbs];
    [self ms_updateTrackLayers];
}

- (void)setFromValue:(CGFloat)fromValue
{
    _fromValue = fromValue;
    [self ms_alignValues];
    [self setNeedsLayout];
}

- (void)setToValue:(CGFloat)toValue
{
    _toValue = toValue;
    [self ms_alignValues];
    [self setNeedsLayout];
}

- (void)setMinimumValue:(CGFloat)minimumValue
{
    _minimumValue = minimumValue;
    [self ms_alignValues];
    [self setNeedsLayout];
}

- (void)setMaximumValue:(CGFloat)maximumValue
{
    _maximumValue = maximumValue;
    [self ms_alignValues];
    [self setNeedsLayout];
}

- (void)setMinimumInterval:(CGFloat)minimumInterval
{
    _minimumInterval = minimumInterval;
    [self ms_alignValues];
    [self setNeedsLayout];
}

- (void)setSelectedTrackTintColor:(UIColor *)selectedTrackTintColor
{
    NSParameterAssert(selectedTrackTintColor);
    _selectedTrackTintColor = selectedTrackTintColor;
    self.selectedTrackLayer.backgroundColor = selectedTrackTintColor.CGColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    NSParameterAssert(trackTintColor);
    _trackTintColor = trackTintColor;
    self.trackLayer.backgroundColor = trackTintColor.CGColor;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor
{
    NSParameterAssert(thumbTintColor);
    _thumbTintColor = thumbTintColor;
    self.fromThumbView.tintColor = thumbTintColor;
    self.toThumbView.tintColor = thumbTintColor;
}

#pragma mark - Private methods

- (void)ms_init
{
    _minimumValue = 0.0;
    _maximumValue = 1.0;
    _minimumInterval = 0.1;
    _fromValue = _minimumValue;
    _toValue = _maximumValue;
    self.hitTestEdgeInsets = UIEdgeInsetsMake(kThumbViewEdgeInset, kThumbViewEdgeInset, kThumbViewEdgeInset, kThumbViewEdgeInset);

    _selectedTrackTintColor = [UIColor colorWithRed:0.0 green:122.0 / 255.0 blue:1.0 alpha:1.0];
    _trackTintColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
    _thumbTintColor = [UIColor whiteColor];

    self.trackLayer = [CALayer layer];
    self.trackLayer.backgroundColor = self.trackTintColor.CGColor;
    self.trackLayer.cornerRadius = 1.3;
    [self.layer addSublayer:self.trackLayer];

    self.selectedTrackLayer = [CALayer layer];
    self.selectedTrackLayer.backgroundColor = self.selectedTrackTintColor.CGColor;
    self.selectedTrackLayer.cornerRadius = 1.3;
    [self.layer addSublayer:self.selectedTrackLayer];

    self.fromThumbView = [[MSThumbView alloc] init];
    self.fromThumbView.hitTestEdgeInsets = UIEdgeInsetsMake(kThumbViewEdgeInset, kThumbViewEdgeInset, kThumbViewEdgeInset, 0);
    [self.fromThumbView.gestureRecognizer addTarget:self action:@selector(ms_didPanFromThumbView:)];
    [self addSubview:self.fromThumbView];

    self.toThumbView = [[MSThumbView alloc] init];
    self.toThumbView.hitTestEdgeInsets = UIEdgeInsetsMake(kThumbViewEdgeInset, 0, kThumbViewEdgeInset, kThumbViewEdgeInset);
    [self.toThumbView.gestureRecognizer addTarget:self action:@selector(ms_didPanToThumbView:)];
    [self addSubview:self.toThumbView];
}

- (void)ms_alignValues
{
    _minimumValue = MIN(self.maximumValue, self.minimumValue);
    _maximumValue = MAX(self.maximumValue, self.minimumValue);
    _minimumInterval = MIN(self.minimumInterval, self.maximumValue - self.minimumValue);
    _toValue = MIN(MAX(self.toValue, self.fromValue + self.minimumInterval), self.maximumValue);
    _fromValue = MAX(MIN(self.fromValue, self.toValue - self.minimumInterval), self.minimumValue);
}

- (void)ms_updateThumbs
{
    CGPoint fromThumbLocation = [self ms_thumbLocationForValue:self.fromValue];

    self.fromThumbView.frame = CGRectMake(fromThumbLocation.x, fromThumbLocation.y, kRangeSliderDimension, kRangeSliderDimension);

    CGPoint toThumbLocation = [self ms_thumbLocationForValue:self.toValue];
    self.toThumbView.frame = CGRectMake(toThumbLocation.x + kRangeSliderDimension, toThumbLocation.y, kRangeSliderDimension, kRangeSliderDimension);
}

- (void)ms_updateTrackLayers
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);

    self.trackLayer.bounds = CGRectMake(0, 0, width, kRangeSliderTrackHeight);
    self.trackLayer.position = CGPointMake(width / 2, height / 2);

    CGFloat from = CGRectGetMaxX(self.fromThumbView.frame);
    CGFloat to = CGRectGetMinX(self.toThumbView.frame);

    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    self.selectedTrackLayer.bounds = CGRectMake(0, 0, to - from, kRangeSliderTrackHeight);
    self.selectedTrackLayer.position = CGPointMake((from + to) / 2, height / 2);
    [CATransaction commit];
}

- (void)ms_didPanFromThumbView:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan && gestureRecognizer.state != UIGestureRecognizerStateChanged) {
        return;
    }

    CGPoint translation = [gestureRecognizer translationInView:self];
    [gestureRecognizer setTranslation:CGPointZero inView:self];
    CGFloat fromValue = [self ms_applyTranslation:translation.x forValue:self.fromValue];
    self.fromValue = MAX(MIN(fromValue, self.toValue - self.minimumInterval), self.minimumValue);

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)ms_didPanToThumbView:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan && gestureRecognizer.state != UIGestureRecognizerStateChanged) {
        return;
    }

    CGPoint translation = [gestureRecognizer translationInView:self];
    [gestureRecognizer setTranslation:CGPointZero inView:self];
    CGFloat toValue = [self ms_applyTranslation:translation.x forValue:self.toValue];
    self.toValue = MIN(MAX(toValue, self.fromValue + self.minimumInterval), self.maximumValue);

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (CGFloat)ms_applyTranslation:(CGFloat)translation forValue:(CGFloat)value
{
    CGFloat width = CGRectGetWidth(self.bounds) - 2 * kRangeSliderDimension;
    CGFloat valueRange = (self.maximumValue - self.minimumValue);

    return value + valueRange * translation / width;
}

- (CGPoint)ms_thumbLocationForValue:(CGFloat)value
{
    CGFloat width = CGRectGetWidth(self.bounds) - 2 * kRangeSliderDimension;
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat valueRange = (self.maximumValue - self.minimumValue);

    CGFloat x = valueRange == 0 ? 0 : width * (value - self.minimumValue) / valueRange;

    return CGPointMake(x, (height - kRangeSliderDimension) / 2);
}

@end
