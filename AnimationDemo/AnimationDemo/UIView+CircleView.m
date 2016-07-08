//
//  UIView+CircleView.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/20.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "UIView+CircleView.h"
#import <objc/runtime.h>

static CGRect initFrame;

#define circleLayerKey "circleLayerKey"

@implementation UIView (CircleView)

- (CAShapeLayer *)circlePathLayer {
    
    CAShapeLayer *circleLayer = objc_getAssociatedObject(self, &circleLayerKey);
    if (circleLayer == nil) {
        self.layer.masksToBounds = YES;
        
        CALayer *firstLayer = nil;
        CGRect layerFrame;
        if ([self.layer.sublayers count] > 0) {
            firstLayer = [self.layer.sublayers firstObject];
            layerFrame = firstLayer.bounds;
        }
        
        circleLayer = [[CAShapeLayer alloc] init];
        
        BOOL haveInitFrame = CGRectEqualToRect(layerFrame, CGRectZero);
        initFrame = haveInitFrame?self.bounds:layerFrame;
        circleLayer.frame = CGRectMake((CGRectGetWidth(self.bounds)-CGRectGetWidth(initFrame))/2, (CGRectGetHeight(self.bounds)-CGRectGetHeight(initFrame))/2, CGRectGetWidth(initFrame), CGRectGetHeight(initFrame));
        circleLayer.masksToBounds = YES;
        circleLayer.hidden = YES;
        circleLayer.lineWidth = 0.1;
        circleLayer.fillColor = [UIColor greenColor].CGColor;
        circleLayer.strokeColor = [UIColor greenColor].CGColor;
        circleLayer.path = [self circlePath:CGRectInset(initFrame, CGRectGetWidth(initFrame)/2, CGRectGetHeight(initFrame)/2)].CGPath;
        [self.layer insertSublayer:circleLayer atIndex:0];
        
        objc_setAssociatedObject(self, &circleLayerKey, circleLayer, OBJC_ASSOCIATION_RETAIN);
    }
    
    return circleLayer;
}

- (UIBezierPath *)circlePath:(CGRect)rect {
    return [UIBezierPath bezierPathWithOvalInRect:rect];
}

- (CGRect)outerRectForRect:(CGRect)rect {
    CGFloat circleRadius = CGRectGetWidth(rect)/2;//内圆半径
    double finalRadius = sqrt((circleRadius*circleRadius) + (circleRadius*circleRadius));//外圆半径
    double radiusInset = finalRadius - circleRadius;
    CGRect outerRect = CGRectInset(rect, -radiusInset, -radiusInset);
    return outerRect;
}

- (void)reveal {
    [[self circlePathLayer] removeAllAnimations];
    [self circlePathLayer].hidden = NO;
    CGPathRef toPath = [self circlePath:[self outerRectForRect:initFrame]].CGPath;
    
    CGPathRef fromPath = [self circlePathLayer].path;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animation];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.keyPath = @"path";
    pathAnimation.fromValue = (__bridge id)fromPath;
    pathAnimation.toValue = (__bridge id)toPath;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.duration = 0.5;
    [[self circlePathLayer] addAnimation:pathAnimation forKey:@"revealPath"];
}

- (void)conceal {
    [[self circlePathLayer] removeAllAnimations];
    [self circlePathLayer].hidden = YES;
    CGPathRef fromPath = [self circlePath:[self outerRectForRect:initFrame]].CGPath;
    
    CGPathRef toPath = [self circlePath:CGRectInset(initFrame, CGRectGetWidth(initFrame)/2, CGRectGetHeight(initFrame)/2)].CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animation];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.keyPath = @"path";
    pathAnimation.fromValue = (__bridge id)fromPath;
    pathAnimation.toValue = (__bridge id)toPath;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.duration = 0.5;
    [[self circlePathLayer] addAnimation:pathAnimation forKey:@"concealPath"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    NSLog(@"stop");
    [self circlePathLayer].path = (__bridge CGPathRef _Nullable)(animation.toValue);
}

@end
