//
//  CircleView.h
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/11.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView
{
    CAShapeLayer        *circlePathLayer;
    CGFloat              circleRadius;
}

- (void)reveal;
- (void)conceal;

@end
