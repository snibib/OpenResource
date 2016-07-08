//
//  UIView+RefreshFrame.h
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/30.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RefreshFrame)

@property (nonatomic, assign)   CGFloat             rf_x;
@property (nonatomic, assign)   CGFloat             rf_y;
@property (nonatomic, assign)   CGFloat             rf_width;
@property (nonatomic, assign)   CGFloat             rf_height;

@property (nonatomic, assign)   CGSize              rf_size;

@property (nonatomic, assign)   CGPoint             rf_origin;
@property (nonatomic, assign)   CGPoint             rf_center;

@property (nonatomic, assign)   CGFloat             rf_left;
@property (nonatomic, assign)   CGFloat             rf_right;
@property (nonatomic, assign)   CGFloat             rf_top;
@property (nonatomic, assign)   CGFloat             rf_bottom;

@property (nonatomic, assign)   CGFloat             rf_centerX;
@property (nonatomic, assign)   CGFloat             rf_centerY;

@end
