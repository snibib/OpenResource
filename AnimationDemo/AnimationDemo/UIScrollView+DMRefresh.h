//
//  UIScrollView+DMRefresh.h
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRefreshConst.h"

@class DMRefreshFooter, DMRefreshDefaultFooter;
@class DMRefreshHeader, DMRefreshDefaultHeader;

@interface UIScrollView (DMRefresh)

@property (nonatomic, strong, readonly) DMRefreshHeader *header;
@property (nonatomic, strong, readonly) DMRefreshFooter *footer;

@property (nonatomic, readonly) DMRefreshDefaultHeader *defaultHeader;
@property (nonatomic, readonly) DMRefreshDefaultFooter *defaultFooter;


- (DMRefreshDefaultHeader *)addDefaultHeaderWithRefreshingBlock:(void (^)())block;

- (DMRefreshDefaultFooter *)addDefaultFooterWithRefreshingBlock:(void (^)())block;

- (void)removeHeader;
- (void)removeFooter;

@end
