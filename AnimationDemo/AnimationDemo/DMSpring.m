//
//  DMSpring.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/8.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "DMSpring.h"
#import <CoreFoundation/CoreFoundation.h>
@interface DMSpring()

@property (nonatomic, assign)    BOOL               autostart;
@property (nonatomic, assign)    BOOL               autohide;
@property (nonatomic, strong)    NSString           *animation;
@property (nonatomic, assign)    CGFloat            force;
@property (nonatomic, assign)    CGFloat            delay;
@property (nonatomic, assign)    CGFloat            duration;
@property (nonatomic, assign)    CGFloat            damping;
@property (nonatomic, assign)    CGFloat            velocity;
@property (nonatomic, assign)    float              repeatCount;
@property (nonatomic, assign)    CGFloat            springx;
@property (nonatomic, assign)    CGFloat            springy;
@property (nonatomic, assign)    CGFloat            scaleX;
@property (nonatomic, assign)    CGFloat            scaleY;
@property (nonatomic, assign)    CGFloat            rotate;
@property (nonatomic, assign)    CGFloat            opacity;
@property (nonatomic, assign)    BOOL               animateFrom;
@property (nonatomic, strong)    NSString           *curve;

@property (nonatomic, strong, readonly)    CALayer      *layer;
@property (nonatomic, assign)    CGAffineTransform      transform;
@property (nonatomic)            CGFloat                alpha;

@end

@implementation DMSpring

- (instancetype)initWithView:(id<DMSpringable>)newView {
    self = [super init];
    if (self) {
        self->view = newView;
        [self commonInit];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)commonInit {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didBecomeActiveNotification:(NSNotification *)notification {
    if (shouldAnimateAfterActive) {
        self.alpha = 0;
        [self animate];
    }
}

- (void)animate {
    self.animateFrom = YES;
    [self animatePreset];
    [self setView:^{}];
}

- (void)animateNext:(void (^)(void))completion {
    self.animateFrom = NO;
    [self animatePreset];
    [self setView:completion];
}

-(void)animateTo {
    self.animateFrom = NO;
    [self animatePreset];
    [self setView:^{}];
}

-(void)animateToNext:(void (^)(void))completion {
    self.animateFrom = NO;
    [self animatePreset];
    [self setView:completion];
}

- (void)setAutostart:(BOOL)autostart {
    view.autostart = autostart;
}

- (BOOL)autostart {
    return view.autostart;
}

- (void)setAutohide:(BOOL)autohide {
    view.autohide = autohide;
}

- (BOOL)autohide {
    return view.autohide;
}

- (void)setAnimation:(NSString *)animation {
    view.animation = animation;
}

- (NSString *)animation {
    return view.animation;
}

- (void)setForce:(CGFloat)force {
    view.force = force;
}

- (CGFloat)force {
    return view.force;
}

- (void)setDelay:(CGFloat)delay {
    view.delay = delay;
}

- (CGFloat)delay {
    return view.delay;
}

- (void)setDuration:(CGFloat)duration {
    view.duration = duration;
}

- (CGFloat)duration {
    return view.duration;
}

- (void)setDamping:(CGFloat)damping {
    view.damping = damping;
}

- (CGFloat)damping {
    return view.damping;
}

- (void)setVelocity:(CGFloat)velocity {
    view.velocity = velocity;
}

- (CGFloat)velocity {
    return view.velocity;
}

- (void)setRepeatCount:(float)repeatCount {
    view.repeatCount = repeatCount;
}

- (float)repeatCount {
    return view.repeatCount;
}

- (void)setSpringx:(CGFloat)springx {
    view.springx = springx;
}

- (CGFloat)springx {
    return view.springx;
}

- (void)setSpringy:(CGFloat)springy {
    view.springy = springy;
}

- (CGFloat)springy {
    return view.springy;
}

- (void)setScaleX:(CGFloat)scaleX {
    view.scaleX = scaleX;
}

- (CGFloat)scaleX {
    return view.scaleX;
}

- (void)setScaleY:(CGFloat)scaleY {
    view.scaleY = scaleY;
}

- (CGFloat)scaleY {
    return view.scaleY;
}

- (void)setRotate:(CGFloat)rotate {
    view.rotate = rotate;
}

- (CGFloat)rotate {
    return view.rotate;
}

- (void)setOpacity:(CGFloat)opacity {
    view.opacity = opacity;
}

- (CGFloat)opacity {
    return view.opacity;
}

- (void)setAnimateFrom:(BOOL)animateFrom {
    view.animateFrom = animateFrom;
}

- (BOOL)animateFrom {
    return view.animateFrom;
}

- (void)setCurve:(NSString *)curve {
    view.curve = curve;
}

- (NSString *)curve {
    return view.curve;
}

- (CALayer *)layer {
    return view.layer;
}

- (void)setTransform:(CGAffineTransform)transform {
    view.transform = transform;
}

- (CGAffineTransform)transform {
    return view.transform;
}

- (void)setAlpha:(CGFloat)alpha {
    view.alpha = alpha;
}

- (CGFloat)alpha {
    return view.alpha;
}

- (void)animatePreset {
    if ([self.animation  isEqual: @""]) {
        return;
    }
    
    if ([self.animation isEqual:@"slideLeft"]) {
        self.springx = 300*self.force;
        return;
    }
    if ([self.animation isEqual:@"slideRight"]) {
        self.springx = -300*self.force;
        return;
    }
    if ([self.animation isEqual:@"slideDown"]) {
        self.springy = -300*self.force;
        return;
    }
    if ([self.animation isEqual:@"slideUp"]) {
        self.springy = 300*self.force;
        return;
    }
    if ([self.animation isEqual:@"squeezeLeft"]) {
        self.springx = 300;
        self.scaleX = 3*self.force;
        return;
    }
    if ([self.animation isEqual:@"squeezeRight"]) {
        self.springx = -300;
        self.scaleX = 3*self.force;
        return;
    }
    if ([self.animation isEqual:@"squeezeDown"]) {
        self.springy = -300;
        self.scaleY = 3*self.force;
        return;
    }
    if ([self.animation isEqual:@"squeezeUp"]) {
        self.springy = 300;
        self.scaleY = 3*self.force;
        return;
    }
    if ([self.animation isEqual:@"fadeIn"]) {
        self.opacity = 0;
        return;
    }
    if ([self.animation isEqual:@"fadeOut"]) {
        self.animateFrom = NO;
        self.opacity = 0;
        return;
    }
    if ([self.animation isEqual:@"fadeOutIn"]) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"opacity";
        animation.fromValue = @1;
        animation.toValue = @0;
        animation.timingFunction = [self getTimingFunction:self.curve];
        animation.duration = self.duration;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        animation.autoreverses = YES;
        [self.layer addAnimation:animation forKey:@"fade"];
        return;
    }
    if ([self.animation isEqual:@"fadeInLeft"]) {
        self.opacity = 0;
        self.springx = 300*self.force;
        return;
    }
    if ([self.animation isEqual:@"fadeInRight"]) {
        self.springx = -300*self.force;
        self.opacity = 0;
        return;
    }
    if ([self.animation isEqual:@"fadeInDown"]) {
        self.springy = -300*self.force;
        self.opacity = 0;
        return;
    }
    if ([self.animation isEqual:@"fadeInUp"]) {
        self.springy = 300*self.force;
        self.opacity = 0;
        return;
    }
    if ([self.animation isEqual:@"zoomIn"]) {
        self.opacity = 0;
        self.scaleX = 2*self.force;
        self.scaleY = 2*self.force;
        return;
    }
    if ([self.animation isEqual:@"zoomOut"]) {
        self.animateFrom = NO;
        self.opacity = 0;
        self.scaleX = 2*self.force;
        self.scaleY = 2*self.force;
        return;
    }
    if ([self.animation isEqual:@"fall"]) {
        self.animateFrom = NO;
        self.springy = 600*self.force;
        return;
    }
    if ([self.animation isEqual:@"shake"]) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = @[@0,@(30*self.force),@(-30*self.force),@(30*self.force),@0];
        animation.keyTimes = @[@0,@0.2,@0.4,@0.6,@0.8,@1];
        animation.timingFunction = [self getTimingFunction:self.curve];
        animation.duration = self.duration;
        animation.additive = YES;
        animation.repeatCount = self.repeatCount;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:animation forKey:@"shake"];
        return;
    }
    if ([self.animation isEqual:@"pop"]) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.values = @[@0,@(0.2*self.force),@(-0.2*self.force),@(0.2*self.force),@0];
        animation.keyTimes = @[@0,@0.2,@0.4,@0.6,@0.8,@1];
        animation.timingFunction = [self getTimingFunction:self.curve];
        animation.duration = self.duration;
        animation.additive = YES;
        animation.repeatCount = self.repeatCount;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:animation forKey:@"pop"];
        return;
    }
    if ([self.animation isEqual:@"flipX"]) {
        self.rotate = 0;
        self.scaleX = 1;
        self.scaleY = 1;
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = -1.0 / self.layer.frame.size.width/2;
        
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DConcat(perspective, CATransform3DMakeRotation(M_PI, 0, 1, 0))];
        animation.duration = self.duration;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        animation.timingFunction = [self getTimingFunction:self.curve];
        [self.layer addAnimation:animation forKey:@"3d"];
        return;
    }
    if ([self.animation isEqual:@"flipY"]) {
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = -1.0 / self.layer.frame.size.width/2;
        
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DConcat(perspective,CATransform3DMakeRotation(M_PI, 1, 0, 0))];
        animation.duration = self.duration;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        animation.timingFunction = [self getTimingFunction:self.curve];
        [self.layer addAnimation:animation forKey: @"3d"];
        return;
    }
    if ([self.animation isEqual:@"morph"]) {
        CAKeyframeAnimation *morphX = [CAKeyframeAnimation animation];
        
        morphX.keyPath = @"transform.scale.x";
        morphX.values = @[@1, @(1.3*self.force), @0.7, @(1.3*self.force), @1];
        morphX.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        morphX.timingFunction = [self getTimingFunction:self.curve];
        morphX.duration = self.duration;
        morphX.repeatCount = self.repeatCount;
        morphX.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:morphX forKey: @"morphX"];
        
        CAKeyframeAnimation *morphY = [CAKeyframeAnimation animation];
        morphY.keyPath = @"transform.scale.y";
        morphY.values = @[@1, @0.7, @(1.3*self.force), @0.7, @1];
        morphY.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        morphY.timingFunction = [self getTimingFunction:self.curve];
        morphY.duration = self.duration;
        morphY.repeatCount = self.repeatCount;
        morphY.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:morphY forKey: @"morphY"];
        return;
    }
    if ([self.animation isEqual:@"squeeze"]) {
        CAKeyframeAnimation *morphX = [CAKeyframeAnimation animation];
        morphX.keyPath = @"transform.scale.x";
        morphX.values = @[@1, @(1.5*self.force), @0.5, @(1.5*self.force), @1];
        morphX.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        morphX.timingFunction = [self getTimingFunction:self.curve];
        morphX.duration = self.duration;
        morphX.repeatCount = self.repeatCount;
        morphX.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:morphX forKey: @"morphX"];
        
        CAKeyframeAnimation *morphY = [CAKeyframeAnimation animation];
        morphY.keyPath = @"transform.scale.y";
        morphY.values = @[@1, @0.5, @1, @0.5, @1];
        morphY.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        morphY.timingFunction = [self getTimingFunction:self.curve];
        morphY.duration = self.duration;
        morphY.repeatCount = self.repeatCount;
        morphY.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:morphY forKey: @"morphY"];
        return;
    }
    if ([self.animation isEqual:@"flash"]) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"opacity";
        animation.fromValue = @1;
        animation.toValue = @0;
        animation.duration = self.duration;
        animation.repeatCount = self.repeatCount * 2.0;
        animation.autoreverses = YES;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:animation forKey: @"flash"];
        return;
    }
    if ([self.animation isEqual:@"wobble"]) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.rotation";
        animation.values = @[@0, @(0.3*self.force), @(-0.3*self.force), @(0.3*self.force), @0];
        animation.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        animation.duration = self.duration;
        animation.additive = YES;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:animation forKey: @"wobble"];
        
        CAKeyframeAnimation *x = [CAKeyframeAnimation animation];
        x.keyPath = @"position.x";
        x.values = @[@0, @(30*self.force), @(-30*self.force), @(30*self.force), @0];
        x.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        x.timingFunction = [self getTimingFunction:self.curve];
        x.duration = self.duration;
        x.additive = YES;
        x.repeatCount = self.repeatCount;
        x.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:x forKey: @"x"];
        return;
    }
    if ([self.animation isEqual:@"swing"]) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.rotation";
        animation.values = @[@0, @(0.3*self.force), @(-0.3*self.force), @(0.3*self.force), @0];
        animation.keyTimes = @[@0, @0.2, @0.4, @0.6, @0.8, @1];
        animation.duration = self.duration;
        animation.additive = YES;
        animation.beginTime = CACurrentMediaTime() + self.delay;
        [self.layer addAnimation:animation forKey: @"swing"];
        return;
    }
    self.springx = 300;
}

- (CAMediaTimingFunction *)getTimingFunction:(NSString *)curve {
    if ([curve isEqual:@"easeIn"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    if ([curve isEqual:@"easeOut"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    if ([curve isEqual:@"easeInOut"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    }
    if ([curve isEqual:@"linear"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    if ([curve isEqual:@"spring"]) {
        return [CAMediaTimingFunction functionWithControlPoints:0.5 :1.1+self.force/3 :1 :1];
    }
    return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
}

- (UIViewAnimationOptions)getAnimationOptions:(NSString *)curve {
    if ([curve isEqual:@"easeIn"]) {
        return UIViewAnimationOptionCurveEaseIn;
    }
    if ([curve isEqual:@"easeOut"]) {
        return UIViewAnimationOptionCurveEaseOut;
    }
    if ([curve isEqual:@"easeInOut"]) {
        return UIViewAnimationOptionCurveEaseInOut;
    }
    if ([curve isEqual:@"linear"]) {
        return UIViewAnimationOptionCurveLinear;
    }
    if ([curve isEqual:@"spring"]) {
        return UIViewAnimationOptionCurveLinear;
    }
    return UIViewAnimationOptionCurveLinear;
}

- (void)customAwakeFromNib {
    if (self.autohide) {
        self.alpha = 0;
    }
}

- (void)customDidMoveToWindow {
    if (self.autostart) {
        if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
            shouldAnimateAfterActive = YES;
            return;
        }
        
        self.alpha = 0;
        [self animate];
    }
}

- (void)setView:(void (^)(void))completion {
    if (self.animateFrom) {
        CGAffineTransform translate = CGAffineTransformMakeTranslation(self.springx, self.springy);
        CGAffineTransform scale = CGAffineTransformMakeScale(self.scaleX, self.scaleY);
        CGAffineTransform rotate = CGAffineTransformMakeRotation(self.rotate);
        CGAffineTransform translateAndScale = CGAffineTransformConcat(translate, scale);
        self.transform = CGAffineTransformConcat(rotate, translateAndScale);
        
        self.alpha = self.opacity;
    }
    typeof(self) welkSelf = self;
    [UIView animateWithDuration:self.duration delay:self.delay usingSpringWithDamping:self.damping initialSpringVelocity:self.velocity options:[self getAnimationOptions:self.curve] animations:^{
        if (welkSelf.animateFrom) {
            welkSelf.transform = CGAffineTransformIdentity;
            welkSelf.alpha = 1;
        }
        else {
            CGAffineTransform translate = CGAffineTransformMakeTranslation(welkSelf.springx, welkSelf.springy);
            CGAffineTransform scale = CGAffineTransformMakeScale(welkSelf.scaleX, welkSelf.scaleY);
            CGAffineTransform rotate = CGAffineTransformMakeRotation(welkSelf.rotate);
            CGAffineTransform translateAndScale = CGAffineTransformConcat(translate, scale);
            welkSelf.transform = CGAffineTransformConcat(rotate, translateAndScale);
            
            welkSelf.alpha = welkSelf.opacity;
        }
    } completion:^(BOOL finished) {
        completion();
        if (self) {
            [self resetAll];
        }
    }];
}

- (void)reset {
    self.springx = 0;
    self.springy = 0;
    self.opacity = 1;
}

- (void)resetAll {
    self.springx = 0;
    self.springy = 0;
    self.animation = @"";
    self.opacity = 1;
    self.scaleX = 1;
    self.scaleY = 1;
    self.rotate = 0;
    self.damping = 0.7;
    self.velocity = 0.7;
    self.repeatCount = 1;
    self.delay = 0;
    self.duration = 0.7;
}

@end
