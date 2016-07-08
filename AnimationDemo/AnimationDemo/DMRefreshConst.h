//
//  DMRefreshConst.h
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/31.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

//RGB Color
#define DMColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//font color
#define DMRefreshLabelTextColor DMColor(100,100,100)

//font size
#define DMRefreshLabelFont [UIFont boldSystemFontOfSize:13]

//const
UIKIT_EXTERN const CGFloat    DMRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat    DMRefreshFooterHeight;
UIKIT_EXTERN const CGFloat    DMRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat    DMRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const DMRefreshHeaderUpdatedTimeKey;
UIKIT_EXTERN NSString *const DMRefreshContentOffset;
UIKIT_EXTERN NSString *const DMRefreshContentSize;
UIKIT_EXTERN NSString *const DMRefreshPanState;

UIKIT_EXTERN NSString *const DMRefreshHeaderStateIdleText;
UIKIT_EXTERN NSString *const DMRefreshHeaderStatePullingText;
UIKIT_EXTERN NSString *const DMRefreshHeaderStateRefreshingText;

UIKIT_EXTERN NSString *const DMRefreshFooterStateIdleText;
UIKIT_EXTERN NSString *const DMRefreshFooterStateRefreshingText;
UIKIT_EXTERN NSString *const DMRefreshFooterStateNoMoreDataText;