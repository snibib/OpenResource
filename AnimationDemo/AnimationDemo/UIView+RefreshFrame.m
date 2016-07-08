//
//  UIView+RefreshFrame.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/30.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "UIView+RefreshFrame.h"

@implementation UIView (RefreshFrame)

- (void)setRf_x:(CGFloat)rf_x {
    self.frame = CGRectMake(rf_x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)rf_x {
    return self.frame.origin.x;
}

- (void)setRf_y:(CGFloat)rf_y {
    self.frame = CGRectMake(self.frame.origin.x, rf_y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)rf_y {
    return self.frame.origin.y;
}

- (void)setRf_width:(CGFloat)rf_width {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, rf_width, self.frame.size.height);
}

- (CGFloat)rf_width {
    return self.frame.size.width;
}

- (void)setRf_height:(CGFloat)rf_height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rf_height);
}

- (CGFloat)rf_height {
    return self.frame.size.height;
}

- (void)setRf_size:(CGSize)rf_size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, rf_size.width, rf_size.height);
}

- (CGSize)rf_size {
    return self.frame.size;
}

- (void)setRf_origin:(CGPoint)rf_origin {
    self.frame = CGRectMake(rf_origin.x, rf_origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGPoint)rf_origin {
    return self.frame.origin;
}

- (void)setRf_center:(CGPoint)rf_center {
    self.center = rf_center;
}

- (CGPoint)rf_center {
    return self.center;
}

- (void)setRf_left:(CGFloat)rf_left {
    self.rf_x = rf_left;
}

- (CGFloat)rf_left {
    return self.rf_x;
}

- (void)setRf_right:(CGFloat)rf_right {
    self.rf_x = rf_right - self.rf_width;
}

- (CGFloat)rf_right {
    return self.rf_x + self.rf_width;
}

- (void)setRf_top:(CGFloat)rf_top {
    self.rf_y = rf_top;
}

- (CGFloat)rf_top {
    return self.rf_y;
}

- (void)setRf_bottom:(CGFloat)rf_bottom {
    self.rf_y = rf_bottom - self.rf_height;
}

- (CGFloat)rf_bottom {
    return self.rf_y + self.rf_height;
}

- (void)setRf_centerX:(CGFloat)rf_centerX {
    self.center = CGPointMake(rf_centerX, self.center.y);
}

- (CGFloat)rf_centerX {
    return self.center.x;
}

- (void)setRf_centerY:(CGFloat)rf_centerY {
    self.center = CGPointMake(self.center.x, rf_centerY);
}

- (CGFloat)rf_centerY {
    return self.center.y;
}

@end
