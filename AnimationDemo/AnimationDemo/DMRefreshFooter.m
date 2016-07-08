//
//  DMRefreshFooter.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "DMRefreshFooter.h"
#import "DMRefreshConst.h"
#import "UIView+RefreshFrame.h"
#import "UIScrollView+RefreshFrame.h"

@interface DMRefreshFooter()

/** the label of state */
@property (nonatomic, weak) UILabel *stateLabel;

/** the button of load more,which can click */
@property (nonatomic, weak) UIButton *loadMoreButton;

/** the label of no-more data */
@property (nonatomic, weak) UILabel *noMoreLabel;

/** the actions that will do */
@property (nonatomic, strong) NSMutableArray *willExecuteBlocks;

@end

@implementation DMRefreshFooter

- (NSMutableArray *)willExecuteBlocks {
    if (_willExecuteBlocks == nil) {
        _willExecuteBlocks = [NSMutableArray array];
    }
    return _willExecuteBlocks;
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

- (UIButton *)loadMoreButton {
    if (_loadMoreButton == nil) {
        UIButton *loadMoreButton = [[UIButton alloc] init];
        loadMoreButton.backgroundColor = [UIColor clearColor];
        [loadMoreButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _loadMoreButton = loadMoreButton;
        
        [self addSubview:_loadMoreButton];
    }
    return _loadMoreButton;
}

- (UILabel *)noMoreLabel {
    if (_noMoreLabel == nil) {
        UILabel *noMoreLabel = [[UILabel alloc] init];
        noMoreLabel.backgroundColor = [UIColor clearColor];
        noMoreLabel.textAlignment = NSTextAlignmentCenter;
        _noMoreLabel = noMoreLabel;
        
        [self addSubview:_noMoreLabel];
    }
    return _noMoreLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.appearenceRate = 1.0;
        
        self.automaticallyRefresh = YES;
        self.state = DMRefreshFooterStateIdle;
        
        [self setTitle:DMRefreshFooterStateIdleText forState:DMRefreshFooterStateIdle];
        [self setTitle:DMRefreshFooterStateRefreshingText forState:DMRefreshFooterStateRefreshing];
        [self setTitle:DMRefreshFooterStateNoMoreDataText forState:DMRefreshFooterStateNoMoreData];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:DMRefreshContentSize context:nil];
    [self.superview removeObserver:self forKeyPath:DMRefreshPanState context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:DMRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:DMRefreshPanState options:NSKeyValueObservingOptionNew context:nil];
        
        self.rf_height = DMRefreshFooterHeight;
        _scrollView.rf_insetB += self.rf_height;
        
        [self adjustFrameWithContentSize];
    } else {
        _scrollView.rf_insetB -= self.rf_height;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.loadMoreButton.frame = self.bounds;
    self.stateLabel.frame = self.bounds;
    self.noMoreLabel.frame = self.bounds;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) {
        return;
    }
    
    if (self.state == DMRefreshFooterStateIdle) {
        if ([keyPath isEqualToString:DMRefreshPanState]) {
            if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
                if (_scrollView.rf_insetT + _scrollView.rf_contentSizeH <= _scrollView.rf_height) {//不足一个屏幕
                    if (_scrollView.rf_offsetY > - _scrollView.rf_insetT) {
                        [self beginRefreshing];
                    }
                } else {//超过一个屏幕
                    if (_scrollView.rf_offsetY > _scrollView.rf_contentSizeH + _scrollView.rf_insetB - _scrollView.rf_height) {//偏移量超过最后一页的顶部偏移
                        [self beginRefreshing];
                    }
                }
            }
        } else if ([keyPath isEqualToString:DMRefreshContentOffset]) {
            if (self.state != DMRefreshFooterStateRefreshing && self.automaticallyRefresh) {
                [self adjustStateWithContentOffset];
            }
        }
    }
    
    if ([keyPath isEqualToString:DMRefreshContentSize]) {
        [self adjustFrameWithContentSize];
    }
}

- (void)adjustFrameWithContentSize {
    self.rf_y = _scrollView.rf_contentSizeH;
}

- (void)adjustStateWithContentOffset {
    if (self.rf_y == 0) {
        return;
    }
    
    if (_scrollView.rf_insetT + _scrollView.rf_contentSizeH > _scrollView.rf_height) {
        if (_scrollView.rf_offsetY > _scrollView.rf_contentSizeH - _scrollView.rf_height + self.rf_height * self.appearenceRate + _scrollView.rf_insetB - self.rf_height) {//顶部刷新控件完全出现
            [self beginRefreshing];
        }
    }
}

- (void)buttonClick {
    [self beginRefreshing];
}

- (void)setHidden:(BOOL)hidden {
    __weak typeof(self) weakSelf = self;
    BOOL lastHidden = weakSelf.isHidden;
    CGFloat h = weakSelf.rf_height;
    [weakSelf.willExecuteBlocks addObject:^{
        if (!lastHidden && hidden) {
            weakSelf.state = DMRefreshFooterStateIdle;
            _scrollView.rf_insetB -= h;
        } else if (lastHidden && !hidden) {
            _scrollView.rf_insetB += h;
            
            [weakSelf adjustFrameWithContentSize];
        }
    }];
    [weakSelf setNeedsDisplay];
    
    [super setHidden:hidden];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    for (void (^block)() in self.willExecuteBlocks) {
        block();
    }
    [self.willExecuteBlocks removeAllObjects];
}

- (void)beginRefreshing {
    self.state = DMRefreshFooterStateRefreshing;
}

- (void)endRefresing {
    self.state = DMRefreshFooterStateIdle;
}

- (BOOL)isRefreshing {
    return self.state == DMRefreshFooterStateRefreshing;
}

- (void)setTitle:(NSString *)title forState:(DMRefreshFooterState)state {
    if (title == nil) {
        return;
    }
    
    switch (state) {
        case DMRefreshFooterStateIdle:
            [self.loadMoreButton setTitle:title forState:UIControlStateNormal];
            break;
        case DMRefreshFooterStateRefreshing:
            self.stateLabel.text = title;
            break;
        case DMRefreshFooterStateNoMoreData:
            self.noMoreLabel.text = title;
            break;
        default:
            break;
    }
}

- (void)setState:(DMRefreshFooterState)state {
    if (_state == state) {
        return;
    }
    
    _state = state;
    switch (state) {
        case DMRefreshFooterStateIdle:
            self.noMoreLabel.hidden = YES;
            self.stateLabel.hidden = YES;
            self.loadMoreButton.hidden = NO;
            break;
        case DMRefreshFooterStateRefreshing:
        {
            self.loadMoreButton.hidden = YES;
            self.noMoreLabel.hidden = YES;
            if (!self.stateHidden) {
                self.stateLabel.hidden = NO;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.refreshingBlock) {
                    self.refreshingBlock();
                }
            });
        }
            break;
        case DMRefreshFooterStateNoMoreData:
            self.loadMoreButton.hidden = YES;
            self.noMoreLabel.hidden = NO;
            self.stateLabel.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    
    self.stateLabel.textColor = textColor;
    [self.loadMoreButton setTitleColor:textColor forState:UIControlStateNormal];
    self.noMoreLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.loadMoreButton.titleLabel.font = font;
    self.noMoreLabel.font = font;
    self.stateLabel.font = font;
}

- (void)setStateHidden:(BOOL)stateHidden {
    _stateHidden = stateHidden;
    
    self.stateLabel.hidden = stateHidden;
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
