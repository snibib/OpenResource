//
//  DMSpringView.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/8.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "DMSpringView.h"

@implementation DMSpringView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.spring customAwakeFromNib];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self.spring customDidMoveToWindow];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autostart = NO;
        self.autohide = NO;
        self.animation = @"";
        self.force = 1.0;
        self.delay = 0.0;
        self.duration = 0.7;
        self.damping = 0.7;
        self.velocity = 0.7;
        self.repeatCount = 1.0;
        self.springx = 0.0;
        self.springy = 0.0;
        self.scaleX = 1.0;
        self.scaleY = 1.0;
        self.rotate = 0.0;
        self.curve = @"";
        self.opacity = 1.0;
        self.animateFrom = NO;
    }
    return self;
}

- (void)animate {
    [self.spring animate];
}

- (void)animateNext:(void (^)(void))completion {
    [self.spring animateNext:completion];
}

- (void)animateTo {
    [self.spring animateTo];
}

- (void)animateToNext:(void (^)(void))completion {
    [self.spring animateToNext:completion];
}

- (DMSpring *)spring {
    if (_spring == nil) {
        _spring = [[DMSpring alloc] initWithView:self];
    }
    return _spring;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
