//
//  UIScrollView+RefreshFrame.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "UIScrollView+RefreshFrame.h"

@implementation UIScrollView (RefreshFrame)

- (void)setRf_insetT:(CGFloat)rf_insetT {
    UIEdgeInsets inset = self.contentInset;
    inset.top = rf_insetT;
    self.contentInset = inset;
}

- (CGFloat)rf_insetT {
    return self.contentInset.top;
}

- (void)setRf_insetL:(CGFloat)rf_insetL {
    UIEdgeInsets inset = self.contentInset;
    inset.left = rf_insetL;
    self.contentInset = inset;
}

- (CGFloat)rf_insetL {
    return self.contentInset.left;
}

- (void)setRf_insetB:(CGFloat)rf_insetB {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = rf_insetB;
    self.contentInset = inset;
}

- (CGFloat)rf_insetB {
    return self.contentInset.bottom;
}

- (void)setRf_insetR:(CGFloat)rf_insetR {
    UIEdgeInsets inset = self.contentInset;
    inset.right = rf_insetR;
    self.contentInset = inset;
}

- (CGFloat)rf_insetR {
    return self.contentInset.right;
}

- (void)setRf_offsetX:(CGFloat)rf_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = rf_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)rf_offsetX {
    return self.contentOffset.x;
}

- (void)setRf_offsetY:(CGFloat)rf_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = rf_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)rf_offsetY {
    return self.contentOffset.y;
}

- (void)setRf_contentSizeW:(CGFloat)rf_contentSizeW {
    CGSize contentSize = self.contentSize;
    contentSize.width = rf_contentSizeW;
    self.contentSize = contentSize;
}

- (CGFloat)rf_contentSizeW {
    return self.contentSize.width;
}

- (void)setRf_contentSizeH:(CGFloat)rf_contentSizeH {
    CGSize contentSize = self.contentSize;
    contentSize.height = rf_contentSizeH;
    self.contentSize = contentSize;
}

- (CGFloat)rf_contentSizeH {
    return self.contentSize.height;
}

@end

