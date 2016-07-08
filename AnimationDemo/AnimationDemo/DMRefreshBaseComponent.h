//
//  DMRefreshBaseComponent.h
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/31.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMRefreshBaseComponent : UIView
{
    UIEdgeInsets     _scrollViewOriginalInset;
    __weak  UIScrollView        *_scrollView;
}

#pragma mark - font

/** font color */
@property (nonatomic, strong)   UIColor         *textColor;

/** font size */
@property (nonatomic, strong)   UIFont          *font;


#pragma mark - refresh

//** refresh block */
@property (nonatomic, copy)     void  (^refreshingBlock)();

//** begin refreshing */
- (void)beginRefreshing;

//** end refreshing */
- (void)endRefresing;

//** during refreshing */
- (BOOL)isRefreshing;

@end
