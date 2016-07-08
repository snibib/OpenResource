//
//  DMButtonAAR.m
//  dmall
//
//  Created by 杨涵 on 15/12/10.
//  Copyright © 2015年 dmall. All rights reserved.
//

#import "DMButtonAAR.h"
#import "DMGifView.h"
#import "UIColor+DMExtension.h"

@interface DMButtonAAR()
{
    id          mtarget;
    SEL         mrightSelector;
    SEL         mleftSelector;
    
    UIView      *upLine;
    UIView      *bottomLine;
}
@property (nonatomic, strong)       DMGifView            *rightBtn;
@property (nonatomic, strong)       UIButton            *leftBtn;

@end

@implementation DMButtonAAR

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.height = 44;
        
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_leftBtn setImage:[UIImage imageNamed:@"category_ico_reduce"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftBtn.x+_leftBtn.width/2, (self.height-20)/2, 15+44, 20)];
        _numberLabel.text = @"0";
        _numberLabel.clipsToBounds = YES;
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        upLine = [[UIView alloc] initWithFrame:CGRectMake(_numberLabel.x, 8.0, _numberLabel.width, 0.5)];
        upLine.backgroundColor = [UIColor colorWithString:@"0xdddddd"];
        
        bottomLine = [[UIView alloc] initWithFrame:CGRectMake(upLine.x, 44-8.5, upLine.width, 0.5)];
        bottomLine.backgroundColor = [UIColor colorWithString:@"0xdddddd"];
        
        _rightBtn = [[DMGifView alloc] initWithFrame:CGRectMake(_numberLabel.x+_numberLabel.width-22, 0, 44, 44)];
//        [_rightBtn setImage:[UIImage imageNamed:@"category_ico_add"] forState:UIControlStateNormal];
//        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.image = [UIImage imageNamed:@"add_ico"];
        _rightBtn.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBtnAction)];
        [_rightBtn addGestureRecognizer:tap];
        
        
        [self addSubview:upLine];
        [self addSubview:bottomLine];
        [self addSubview:_numberLabel];
        [self addSubview:_leftBtn];
        [self addSubview:_rightBtn];

        
        self.width = _rightBtn.x+_rightBtn.width;
        self.isContraction = YES;
    }
    return self;
}

- (void)hideSet {
    upLine.x = _rightBtn.centerX;
    upLine.width = 0;
    bottomLine.x = upLine.x;
    bottomLine.width = 0;
    _leftBtn.x = _rightBtn.x;
    _leftBtn.alpha = 0.0;
}

- (void)showSet {
    _leftBtn.x = 0;
    upLine.x = _leftBtn.x+_leftBtn.width/2;
    upLine.width = 15+44;
    bottomLine.x = upLine.x;
    bottomLine.width = upLine.width;
    _leftBtn.alpha = 1.0;
}

- (void)addActionForTarget:(id)target rightSelector:(SEL)rightselector leftSelector:(SEL)leftselector {
    mtarget = target;
    mrightSelector = rightselector;
    mleftSelector = leftselector;
}

- (void)setGifImageWithName:(NSString *)gifName {
    _rightBtn.imageFileName = gifName;
}

- (void)rightBtnAction {
    [self extend];
    if ([mtarget respondsToSelector:mrightSelector]) {
        [mtarget performSelector:mrightSelector withObject:self];
    }
}

- (void)leftBtnAction {
    if ([mtarget respondsToSelector:mleftSelector]) {
        [mtarget performSelector:mleftSelector withObject:self];
    }
}

- (void)extend {
    if (!_isContraction) {
        return;
    }
    _isContraction = NO;
    [UIView animateWithDuration:0.4 animations:^{
        [self showSet];
    }completion:^(BOOL finished) {
        if (_isContraction == NO) {
            _numberLabel.alpha = 1.0;
        }
    }];
}

- (void)playAnimation {
    [_rightBtn playOnce];
}

- (void)contraction {
    if (_isContraction) {
        return;
    }
    _isContraction = YES;
    _numberLabel.alpha = 0.0;
    [UIView animateWithDuration:0.4 animations:^{
        [self hideSet];
    }];
}

- (void)setIsContraction:(BOOL)isContraction {
    _isContraction = isContraction;
    
    if (isContraction) {
        
        _numberLabel.alpha = 0.0;
        [self hideSet];
    }else {
        
        _numberLabel.alpha = 1.0;
        [self showSet];
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
