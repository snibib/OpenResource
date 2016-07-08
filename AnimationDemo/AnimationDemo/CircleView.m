//
//  CircleView.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/11.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    circlePathLayer = [[CAShapeLayer alloc] init];
    circleRadius = CGRectGetWidth(self.bounds)/2;
    
    circlePathLayer.backgroundColor = [UIColor greenColor].CGColor;
    circlePathLayer.frame = [self bounds];
    circlePathLayer.lineWidth = 2;
    circlePathLayer.fillColor = [UIColor redColor].CGColor;
    circlePathLayer.strokeColor = [UIColor redColor].CGColor;
    circlePathLayer.path = [self circlePath:[self bounds]].CGPath;
    [self.layer addSublayer:circlePathLayer];
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor yellowColor];
}

- (UIBezierPath *)circlePath:(CGRect)rect {
    return [UIBezierPath bezierPathWithOvalInRect:rect];
}

- (CGRect)outerRect {
    double finalRadius = sqrt((circleRadius*circleRadius) + (circleRadius*circleRadius));
    double radiusInset = finalRadius - circleRadius;
    CGRect outerRect = CGRectInset([self bounds], -radiusInset, -radiusInset);
    return outerRect;
}

- (void)reveal {
    
    CGPathRef toPath = [self circlePath:[self outerRect]].CGPath;
    
    CGPathRef fromPath = circlePathLayer.path;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animation];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.keyPath = @"path";
    pathAnimation.fromValue = (__bridge id)fromPath;
    pathAnimation.toValue = (__bridge id)toPath;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.duration = 0.2;
    pathAnimation.delegate = self;
    [circlePathLayer addAnimation:pathAnimation forKey:@"revealPath"];
}

- (void)conceal {
    CGPathRef fromPath = circlePathLayer.path;
    
    CGPathRef toPath = [self circlePath:[self bounds]].CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animation];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.keyPath = @"path";
    pathAnimation.fromValue = (__bridge id)fromPath;
    pathAnimation.toValue = (__bridge id)toPath;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.duration = 0.2;
    pathAnimation.delegate = self;
    [circlePathLayer addAnimation:pathAnimation forKey:@"concealPath"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    circlePathLayer.path = (__bridge CGPathRef _Nullable)(animation.toValue);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
