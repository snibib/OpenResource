//
//  UIScrollView+RefreshFrame.h
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (RefreshFrame)

@property (nonatomic, assign) CGFloat rf_insetT;
@property (nonatomic, assign) CGFloat rf_insetB;
@property (nonatomic, assign) CGFloat rf_insetL;
@property (nonatomic, assign) CGFloat rf_insetR;

@property (nonatomic, assign) CGFloat rf_offsetX;
@property (nonatomic, assign) CGFloat rf_offsetY;

@property (nonatomic, assign) CGFloat rf_contentSizeW;
@property (nonatomic, assign) CGFloat rf_contentSizeH;

@end
