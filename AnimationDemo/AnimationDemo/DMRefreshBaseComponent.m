//
//  DMRefreshBaseComponent.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/31.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "DMRefreshBaseComponent.h"
#import "DMRefreshConst.h"
#import "UIView+RefreshFrame.h"

@interface DMRefreshBaseComponent()

@property (nonatomic, assign)   UIEdgeInsets    scrollViewOriginalInset;
@property (nonatomic, weak)     UIScrollView   *scrollView;

@end

@implementation DMRefreshBaseComponent

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //base property
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        //default fontColor and fontSize
        self.textColor = DMRefreshLabelTextColor;
        self.font = DMRefreshLabelFont;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:DMRefreshContentOffset context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:DMRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        //base setting
        self.rf_width = newSuperview.rf_width;
        self.rf_x = 0;
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollView.alwaysBounceVertical = YES;
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
}

#pragma mark - public func

- (void)beginRefreshing {
    
}

- (void)endRefresing {
    
}

- (BOOL)isRefreshing {
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
