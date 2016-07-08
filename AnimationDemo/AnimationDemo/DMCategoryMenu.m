//
//  DMCategoryMenu.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/11.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "DMCategoryMenu.h"

@interface DMCategoryMenu()
{
    UIView *circle1;
    UIView *line1;
    
    UIView *circle2;
    UIView *line2;
    
    UIView *circle3;
    UIView *line3;
}

@end

@implementation DMCategoryMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setCircles];
    }
    return self;
}

- (void)setCircles {
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 36, 36);
    
    circle1 = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 5)];
    circle1.backgroundColor = [UIColor redColor];
    [self addSubview:circle1];
    
    line1 = [[UIView alloc] initWithFrame:CGRectMake(circle1.frame.origin.x+circle1.frame.size.width+5, circle1.frame.origin.y+(circle1.frame.size.height-2)/2+0.5, 26, 2)];
    line1.backgroundColor = [UIColor redColor];
    [self addSubview:line1];
    
    circle2 = [[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-5)/2, 5, 5)];
    circle2.backgroundColor = [UIColor redColor];
    [self addSubview:circle2];
    
    line2 = [[UIView alloc] initWithFrame:CGRectMake(circle2.frame.origin.x+circle2.frame.size.width+5, (self.frame.size.height-2)/2, 26, 2)];
    line2.backgroundColor = [UIColor redColor];
    [self addSubview:line2];
    
    circle3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-10, 5, 5)];
    circle3.backgroundColor = [UIColor redColor];
    [self addSubview:circle3];
    
    line3 = [[UIView alloc] initWithFrame:CGRectMake(circle3.frame.origin.x+circle3.frame.size.width+5, circle3.frame.origin.y+(circle3.frame.size.height-2)/2+0.5, 26, 2)];
    line3.backgroundColor = [UIColor redColor];
    [self addSubview:line3];
    
    circle1.layer.masksToBounds = YES;
    circle3.layer.masksToBounds = YES;
    circle2.layer.masksToBounds = YES;
    line1.layer.masksToBounds = YES;
    line2.layer.masksToBounds = YES;
    line3.layer.masksToBounds = YES;
    [self beginState];
}

- (void)beginState {
    circle1.layer.cornerRadius = 2.5;
    line1.layer.cornerRadius = 0;
    circle2.layer.cornerRadius = 2.5;
    line2.layer.cornerRadius = 0;
    circle3.layer.cornerRadius = 2.5;
    line3.layer.cornerRadius = 0;
}

- (void)endState {
    circle1.layer.cornerRadius = 2.5;
    line1.layer.cornerRadius = 0;
    circle2.layer.cornerRadius = 0;
    line2.layer.cornerRadius = 2.5;
    circle3.layer.cornerRadius = 0;
    line3.layer.cornerRadius = 2.5;
}

- (void)beginFrame {
    circle2.frame = CGRectMake(0, (self.frame.size.height-5)/2, 5, 5);
    line2.frame = CGRectMake(circle2.frame.origin.x+circle2.frame.size.width+5, (self.frame.size.height-2)/2, 26, 2);
    line2.center = CGPointMake(line2.center.x, circle2.center.y);
    
    circle3.frame = CGRectMake(0, self.frame.size.height-10, 5, 5);
    line3.frame = CGRectMake(circle3.frame.origin.x+circle3.frame.size.width+5, circle3.frame.origin.y+(circle3.frame.size.height-2)/2+0.5, 26, 2);
    line3.center = CGPointMake(line3.center.x, circle3.center.y);
}

- (void)endFrame {
    circle2.frame = CGRectMake(0, (self.frame.size.height-2)/2, 26, 2);
    line2.frame = CGRectMake(circle2.frame.origin.x+circle2.frame.size.width+5, (self.frame.size.height-5)/2, 5, 5);
    line2.center = CGPointMake(line2.center.x, circle2.center.y);
    
    circle3.frame = CGRectMake(0, self.frame.size.height-10+(5-2)/2, 26, 2);
    line3.frame = CGRectMake(circle3.frame.origin.x+circle3.frame.size.width+5, self.frame.size.height-10, 5, 5);
    line3.center = CGPointMake(line3.center.x, circle3.center.y);
}

- (void)endAnimation {
    
    [UIView animateWithDuration:0.4 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self beginFrame];
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [self beginState];
        }];
    }];
}

- (void)beginAnimation {
    [UIView animateWithDuration:0.4 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [self endFrame];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [self endState];
        }];
    }];
}

- (void)animationWithRate:(CGFloat)rate {
    if (rate>1 || rate<0) {
        return;
    }
    
    CGFloat widthAdjust = (5.0 - 26.0) * rate;
    CGFloat heightAdjust = (5.0 - 2.0) * rate;
    CGFloat cwidth = 5.0 - widthAdjust;
    CGFloat cheight = 5.0 - heightAdjust;
    CGFloat lwidth = 26.0 + widthAdjust;
    CGFloat lheight = 2.0 + heightAdjust;
    
    circle2.frame = CGRectMake(0, (self.frame.size.height-cheight)/2, cwidth, cheight);
    line2.frame = CGRectMake(circle2.frame.origin.x+circle2.frame.size.width+5, 0, lwidth, lheight);
    line2.center = CGPointMake(line2.center.x, circle2.center.y);
    
    circle3.frame = CGRectMake(0, self.frame.size.height-10+rate*((5-2)/2), cwidth, cheight);
    line3.frame = CGRectMake(circle3.frame.origin.x+circle3.frame.size.width+5, 0, lwidth, lheight);
    line3.center = CGPointMake(line3.center.x, circle3.center.y);
    
    circle2.layer.cornerRadius = 2.5*(1-rate);
    line2.layer.cornerRadius = 2.5*rate;
    circle3.layer.cornerRadius = 2.5*(1-rate);
    line3.layer.cornerRadius = 2.5*rate;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    circle1.backgroundColor = backgroundColor;
    line1.backgroundColor = backgroundColor;
    circle2.backgroundColor = backgroundColor;
    line2.backgroundColor = backgroundColor;
    circle3.backgroundColor = backgroundColor;
    line3.backgroundColor = backgroundColor;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self beginAnimation];
    }else {
        [self endAnimation];
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
