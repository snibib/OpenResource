//
//  DMRefreshDefaultFooter.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/5.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "DMRefreshDefaultFooter.h"
#import "UIView+RefreshFrame.h"
#import "UIScrollView+RefreshFrame.h"

@interface DMRefreshDefaultFooter()

@property (nonatomic, weak) UIActivityIndicatorView *activityInditor;
@property (nonatomic, weak) UIImageView             *gifView;

@end

@implementation DMRefreshDefaultFooter

- (UIActivityIndicatorView *)activityInditor {
    if (_activityInditor == nil) {
        UIActivityIndicatorView *activityInditor = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityInditor = activityInditor;
        
        [self addSubview:_activityInditor];
    }
    return _activityInditor;
}

- (UIImageView *)gifView {
    if (_gifView == nil) {
        UIImageView *gifView = [[UIImageView alloc] init];
        _gifView = gifView;
        
        [self addSubview:_gifView];
    }
    return _gifView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.stateHidden) {
        if (self.refreshingImages && [self.refreshingImages count]) {
            self.gifView.frame = self.bounds;
            self.gifView.contentMode = UIViewContentModeCenter;
        }else {
            self.activityInditor.hidden = NO;
            
            self.activityInditor.center = CGPointMake(self.rf_width*0.5, self.rf_height*0.5);
        }
    } else {
        if (self.refreshingImages && [self.refreshingImages count]) {
            self.gifView.frame = self.bounds;
            self.gifView.contentMode = UIViewContentModeRight;
            self.gifView.rf_width = self.rf_width*0.5-90;
        }else {
            self.activityInditor.center = CGPointMake(self.rf_width*0.5-100, self.rf_height*0.5);
        }
    }
}

- (void)setState:(DMRefreshFooterState)state {
    if (self.state == state) {
        return;
    }
    
    switch (state) {
        case DMRefreshFooterStateIdle:
            if (self.refreshingImages && [self.refreshingImages count]) {
                self.gifView.hidden = YES;
                [self.gifView stopAnimating];
            }else {
                [self.activityInditor stopAnimating];
            }
            break;
        case DMRefreshFooterStateRefreshing:
            if (self.refreshingImages && [self.refreshingImages count]) {
                self.gifView.hidden = NO;
                [self.gifView startAnimating];
            }else {
                [self.activityInditor startAnimating];
            }
            break;
        case DMRefreshFooterStateNoMoreData:
            if (self.refreshingImages && [self.refreshingImages count]) {
                self.gifView.hidden = YES;
                [self.gifView stopAnimating];
            }else {
                [self.activityInditor stopAnimating];
            }
            break;
        default:
            break;
    }
    
    [super setState:state];
}

- (void)setRefreshingImages:(NSArray *)refreshingImages {
    _refreshingImages = refreshingImages;
    
    self.gifView.animationImages = refreshingImages;
    self.gifView.animationDuration = refreshingImages.count * 0.1;
    
    UIImage *image = [refreshingImages firstObject];
    if (image.size.height > self.rf_height) {
        _scrollView.rf_insetB -= self.rf_height;
        self.rf_height = image.size.height;
        _scrollView.rf_insetB += self.rf_height;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
