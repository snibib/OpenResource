//
//  DMRefreshConst.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/31.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "DMRefreshConst.h"

const CGFloat DMRefreshHeaderHeight = 54.0;
const CGFloat DMRefreshFooterHeight = 44.0;
const CGFloat DMRefreshFastAnimationDuration = 0.25;
const CGFloat DMRefreshSlowAnimationDuration = 0.4;

NSString *const DMRefreshHeaderUpdatedTimeKey = @"DMRefreshHeaderUpdatedTimeKey";
NSString *const DMRefreshContentOffset = @"contentOffset";
NSString *const DMRefreshContentSize = @"contentSize";
NSString *const DMRefreshPanState = @"pan.state";

NSString *const DMRefreshHeaderStateIdleText = @"下拉可以刷新";
NSString *const DMRefreshHeaderStatePullingText = @"松开立即刷新";
NSString *const DMRefreshHeaderStateRefreshingText = @"正在刷新数据中...";

NSString *const DMRefreshFooterStateIdleText = @"点击加载更多";
NSString *const DMRefreshFooterStateRefreshingText = @"正在加载更多的数据...";
NSString *const DMRefreshFooterStateNoMoreDataText = @"没有更多了";