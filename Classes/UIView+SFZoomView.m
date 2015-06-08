//
//  UIView+SFZoomView.m
//  SFZoomView
//
//  Created by Simon Fortelny on 6/5/15.
//  Copyright (c) 2015 Simon Fortelny. All rights reserved.
//

#import "UIView+SFZoomView.h"

static NSString *zoomOutAnimation = @"zoomOut";
static NSString *zoomInAnimation = @"zoomIn";
static CGFloat defaultDuration = 0.4;

// keyframe from http://stackoverflow.com/questions/2160150/mimic-uialertview-bounce
@implementation UIView (SFZoomView)

- (void)sf_makeZoomedOut{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [CATransaction setDisableActions:YES];
    bounceAnimation.fillMode = kCAFillModeBoth;
    bounceAnimation.removedOnCompletion = YES;
    bounceAnimation.duration = 0;
    bounceAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)]];
    bounceAnimation.keyTimes = @[@1.0f];
    bounceAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    bounceAnimation.removedOnCompletion = false;
    [self.layer addAnimation:bounceAnimation forKey:zoomOutAnimation];
}

- (void)sf_zoomOutCustomDuration:(CGFloat)duration values:(NSArray *)values keyTimes:(NSArray *)keyTimes timing:(NSArray *)timing {
    if(self.sf_isZoomedOut){
        return;
    }
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    bounceAnimation.fillMode = kCAFillModeBoth;
    bounceAnimation.duration = duration;
    bounceAnimation.values = values;
    bounceAnimation.keyTimes = keyTimes;
    bounceAnimation.timingFunctions = timing;
    bounceAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:bounceAnimation forKey:zoomOutAnimation];
}

- (void)sf_zoomOut{
    [self sf_zoomOutCustomDuration:defaultDuration
                            values:[[[self sf_defaultAnimationValues] reverseObjectEnumerator] allObjects]
                          keyTimes:[self sf_defaultAnimationKeyTimesOut]
                            timing:[[[self sf_defaultAnimationTimings] reverseObjectEnumerator]allObjects]];
}

- (void)sf_zoomInCustomDuration:(CGFloat)duration values:(NSArray *)values keyTimes:(NSArray *)keyTimes timing:(NSArray *)timing {
    if(!self.sf_isZoomedOut){
        return;
    }
    [self.layer removeAnimationForKey:zoomOutAnimation];
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    bounceAnimation.fillMode = kCAFillModeBoth;
    bounceAnimation.removedOnCompletion = YES;
    bounceAnimation.duration = duration;
    bounceAnimation.values = values;
    bounceAnimation.keyTimes = keyTimes;
    bounceAnimation.timingFunctions = timing;
    [self.layer addAnimation:bounceAnimation forKey:zoomInAnimation];
}

- (void)sf_zoomIn{
    [self sf_zoomInCustomDuration:defaultDuration
                            values:[self sf_defaultAnimationValues]
                          keyTimes:[self sf_defaultAnimationKeyTimesIn]
                            timing:[self sf_defaultAnimationTimings]];
}

- (BOOL)sf_isZoomedOut{
    return self.layer.animationKeys && [self.layer.animationKeys indexOfObject:zoomOutAnimation] != NSNotFound;
}

- (NSArray *) sf_defaultAnimationKeyTimesIn {
    return @[@0.0f, @0.5f, @0.75f, @1.0f];
}

- (NSArray *) sf_defaultAnimationKeyTimesOut {
    return @[@0.0f, @0.25f, @0.5f, @1.0f];
}

- (NSArray *)sf_defaultAnimationValues{
    return @[
      [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.001f, 0.001f, 0.001f)],
      [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.1f)],
      [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 0.9f)],
      [NSValue valueWithCATransform3D:CATransform3DIdentity]
      ];
}

- (NSArray *)sf_defaultAnimationTimings{
    return @[
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
            ];
}

@end
