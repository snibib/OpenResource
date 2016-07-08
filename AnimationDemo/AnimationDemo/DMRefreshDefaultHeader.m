//
//  DMRefreshDefaultHeader.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/5.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "DMRefreshDefaultHeader.h"
#import "UIView+RefreshFrame.h"
#import "DMRefreshConst.h"

@interface DMRefreshDefaultHeader()

@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation DMRefreshDefaultHeader

- (UIImageView *)arrowImage {
    if (_arrowImage == nil) {
        UIImageView *arrowImage = [[UIImageView alloc] init];
        _arrowImage = arrowImage;
        
        [self addSubview:_arrowImage];
    }
    return _arrowImage;
}

- (UIImageView *)gifView {
    if (_gifView == nil) {
        UIImageView *gifView = [[UIImageView alloc] init];
        _gifView = gifView;
        
        [self addSubview:_gifView];
    }
    return _gifView;
}

- (void)setHeaderImageName:(NSString *)headerImageName {
    _headerImageName = headerImageName;
    
    UIImage *img = [UIImage imageNamed:headerImageName];
    self.arrowImage.image = img;
    self.arrowImage.rf_size = img.size;
}

- (void)setRefreshingImages:(NSArray *)refreshingImages {
    _refreshingImages = refreshingImages;
    
    self.gifView.animationImages = refreshingImages;
    self.gifView.animationDuration = refreshingImages.count * 0.1;
    
    UIImage *image = [refreshingImages firstObject];
    if (image.size.height > self.rf_height) {
        self.rf_height = image.size.height;
    }
}

- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator == nil) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.bounds = self.arrowImage.bounds;
        _activityIndicator = activityIndicator;
        
        [self addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.refreshingImages count] > 0) {
        self.gifView.hidden = NO;
        self.arrowImage.hidden = YES;
        self.activityIndicator.hidden = YES;
        
        self.gifView.frame = self.bounds;
        if (self.stateHidden && self.updatedTimeHidden) {
            self.gifView.contentMode = UIViewContentModeCenter;
        }else {
            self.gifView.contentMode = UIViewContentModeRight;
            self.gifView.rf_width = self.rf_width*0.5-90;
        }
    }else {
        self.gifView.hidden = YES;
        self.arrowImage.hidden = NO;
        self.activityIndicator.hidden = NO;
        
        CGFloat arrowX = (self.stateHidden && self.updatedTimeHidden) ? self.rf_width*0.5 : (self.rf_width*0.5-100);
        self.arrowImage.center = CGPointMake(arrowX, self.rf_height*0.5);
        
        self.activityIndicator.center = self.arrowImage.center;
    }
}

- (void)setState:(DMRefreshHeaderState)state {
    if (self.state == state) {
        return;
    }
    
    DMRefreshHeaderState oldState = self.state;
    switch (state) {
        case DMRefreshHeaderStateIdle:
        {
            if ([self.refreshingImages count] > 0) {
                self.gifView.hidden = NO;
                [self.gifView startAnimating];
            }else{
                if (oldState == DMRefreshHeaderStateRefreshing) {
                    
                    self.arrowImage.transform = CGAffineTransformIdentity;
                    
                    [UIView animateWithDuration:DMRefreshSlowAnimationDuration animations:^{
                        self.activityIndicator.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        self.arrowImage.alpha = 1.0;
                        self.activityIndicator.alpha = 1.0;
                        [self.activityIndicator stopAnimating];
                    }];
                } else {
                    
                    [UIView animateWithDuration:DMRefreshFastAnimationDuration animations:^{
                        self.arrowImage.transform = CGAffineTransformIdentity;
                    }];
                }
            }
            
        }
            break;
        case DMRefreshHeaderStatePulling:
        {
            if ([self.refreshingImages count] > 0) {
                self.gifView.hidden = NO;
                [self.gifView startAnimating];
            }else {
                [UIView animateWithDuration:DMRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(0.0000001- M_PI);
                }];
            }
        }
            break;
        case DMRefreshHeaderStateRefreshing:
        {
            if ([self.refreshingImages count] == 0) {
                [self.activityIndicator startAnimating];
                self.arrowImage.alpha = 0.0;
            }
        }
            break;
        default:
            break;
    }
    
    [super setState:state];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
