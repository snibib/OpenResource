//
//  DMRefreshHeader.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "DMRefreshHeader.h"
#import "DMRefreshConst.h"
#import "UIView+RefreshFrame.h"
#import "UIScrollView+RefreshFrame.h"

@interface DMRefreshHeader()

@property (nonatomic, weak) UILabel *updatedTimeLabel;
@property (nonatomic, strong) NSDate *updatedTime;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, strong) NSMutableDictionary *stateTitles;

@end

@implementation DMRefreshHeader

- (NSMutableDictionary *)stateTitles {
    if (_stateTitles == nil) {
        _stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel {
    if (_stateLabel == nil) {
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel = stateLabel;
        
        [self addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)updatedTimeLabel {
    if (_updatedTimeLabel == nil) {
        UILabel *updatedTimeLabel = [[UILabel alloc] init];
        updatedTimeLabel.backgroundColor = [UIColor clearColor];
        updatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        _updatedTimeLabel = updatedTimeLabel;
        
        [self addSubview:_updatedTimeLabel];
    }
    return _updatedTimeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dateKey = DMRefreshHeaderUpdatedTimeKey;
        self.state = DMRefreshHeaderStateIdle;
        
        [self setTitle:DMRefreshHeaderStateIdleText forState:DMRefreshHeaderStateIdle];
        [self setTitle:DMRefreshHeaderStatePullingText forState:DMRefreshHeaderStatePulling];
        [self setTitle:DMRefreshHeaderStateRefreshingText forState:DMRefreshHeaderStateRefreshing];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.rf_height = DMRefreshHeaderHeight;
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.state == DMRefreshHeaderStateWillRefresh) {
        self.state = DMRefreshHeaderStateRefreshing;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.rf_y = -self.rf_height;
    if (self.stateHidden && self.updatedTimeHidden) return;
    
    if (self.updatedTimeHidden) {
        _stateLabel.frame = self.bounds;
    } else if (self.stateHidden) {
        self.updatedTimeLabel.frame = self.bounds;
    } else {
        CGFloat stateH = self.rf_height*0.55;
        CGFloat stateW = self.rf_width;
        
        _stateLabel.frame = CGRectMake(0, 0, stateW, stateH);
        
        CGFloat updateTimeY = stateH;
        CGFloat updateTimeH = self.rf_height - stateH;
        CGFloat updateTimeW = stateW;
        self.updatedTimeLabel.frame = CGRectMake(0, updateTimeY, updateTimeW, updateTimeH);
    }
}

- (void)setDateKey:(NSString *)dateKey {
    _dateKey = dateKey ? dateKey : DMRefreshHeaderUpdatedTimeKey;
    
    self.updatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:_dateKey];
}

- (void)setUpdatedTime:(NSDate *)updatedTime {
    _updatedTime = updatedTime;
    
    if (updatedTime) {
        [[NSUserDefaults standardUserDefaults] setObject:updatedTime forKey:self.dateKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (self.updatedTimeTitle) {
        self.updatedTimeLabel.text = self.updatedTimeTitle(updatedTime);
        return;
    }
    
    if (updatedTime) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:updatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([cmp1 day] == [cmp2 day]) {
            formatter.dateFormat = @"今天 HH:mm";
        } else if ([cmp1 year] == [cmp2 year]) {
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:updatedTime];
        
        self.updatedTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@",time];
    }else {
        self.updatedTimeLabel.text = @"最后更新：无记录";
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == DMRefreshHeaderStateRefreshing) {
        return;
    }
    
    if ([keyPath isEqualToString:DMRefreshContentOffset]) {
        [self adjustStateWithContentOffset];
    }
}

- (void)adjustStateWithContentOffset {
    if (self.state != DMRefreshHeaderStateRefreshing) {
        _scrollViewOriginalInset = _scrollView.contentInset;
    }
    
    if (self.state == DMRefreshHeaderStateRefreshing) {
        if (_scrollView.contentOffset.y >= -_scrollViewOriginalInset.top) {
            _scrollView.rf_insetT = _scrollViewOriginalInset.top;
        } else {
            _scrollView.rf_insetT = MIN(_scrollViewOriginalInset.top + self.rf_height,
                                        _scrollViewOriginalInset.top - _scrollView.contentOffset.y);
        }
        return;
    }
    
    CGFloat offsetY = _scrollView.rf_offsetY;
    CGFloat appearOffsetY = - _scrollViewOriginalInset.top;
    
    if (offsetY >= appearOffsetY) {
        return;
    }
    
    CGFloat normal_pullingOffsetY = appearOffsetY - self.rf_height;
    if (_scrollView.isDragging) {
        self.pullingRate = (appearOffsetY - offsetY) / self.rf_height;
        
        if (self.state == DMRefreshHeaderStateIdle && offsetY < normal_pullingOffsetY) {
            self.state = DMRefreshHeaderStatePulling;
        } else if (self.state == DMRefreshHeaderStatePulling && offsetY >= normal_pullingOffsetY) {
            self.state = DMRefreshHeaderStateIdle;
        }
    } else if (self.state == DMRefreshHeaderStatePulling) {
        self.pullingRate = 1.0;
        
        self.state = DMRefreshHeaderStateRefreshing;
    } else {
        self.pullingRate = (appearOffsetY - offsetY) / self.rf_height;
    }
}

- (void)setTitle:(NSString *)title forState:(DMRefreshHeaderState)state {
    if (title == nil) {
        return;
    }
    
    self.stateTitles[@(state)] = title;
    
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (void)beginRefreshing {
    if (self.window) {
        self.state = DMRefreshHeaderStateRefreshing;
    } else {
        self.state = DMRefreshHeaderStateWillRefresh;
    
        [self setNeedsDisplay];
    }
}

- (void)endRefresing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = DMRefreshHeaderStateIdle;
    });
}

- (BOOL)isRefreshing {
    return self.state == DMRefreshHeaderStateRefreshing;
}

- (void)setState:(DMRefreshHeaderState)state {
    if (_state == state) {
        return;
    }
    
    DMRefreshHeaderState oldState = _state;
    
    _state = state;
    
    _stateLabel.text = _stateTitles[@(state)];
    
    switch (state) {
        case DMRefreshHeaderStateIdle:
        {
            if (oldState == DMRefreshHeaderStateRefreshing) {
                self.updatedTime = [NSDate date];
                
                [UIView animateWithDuration:DMRefreshSlowAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                    _scrollView.rf_insetT -= self.rf_height;
                } completion:nil];
            }
        }
            break;
        case DMRefreshHeaderStateRefreshing:
        {
            [UIView animateWithDuration:DMRefreshFastAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                CGFloat top = _scrollViewOriginalInset.top + self.rf_height;
                _scrollView.rf_insetT = top;
                
                _scrollView.rf_offsetY = -top;
            } completion:^(BOOL finished) {
                if (self.refreshingBlock) {
                    self.refreshingBlock();
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    
    self.updatedTimeLabel.textColor = textColor;
    self.stateLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.updatedTimeLabel.font = font;
    self.stateLabel.font = font;
}

- (void)setStateHidden:(BOOL)stateHidden {
    _stateHidden = stateHidden;
    
    self.stateLabel.hidden = stateHidden;
    [self setNeedsLayout];
}

- (void)setUpdatedTimeHidden:(BOOL)updatedTimeHidden {
    _updatedTimeHidden = updatedTimeHidden;
    
    self.updatedTimeLabel.hidden = updatedTimeHidden;
    [self setNeedsLayout];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
