//
//  DMButtonAAR.h
//  dmall
//
//  Created by 杨涵 on 15/12/10.
//  Copyright © 2015年 dmall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+frameAdjust.h"
#import "UIView+Frame.h"

@interface DMButtonAAR : UIView

@property (nonatomic, assign)       BOOL                isContraction;//是否收缩
@property (nonatomic, strong)       UILabel             *numberLabel;

- (void)addActionForTarget:(id)target rightSelector:(SEL)rightselector leftSelector:(SEL)leftselector;

- (void)extend;
- (void)contraction;

- (void)setGifImageWithName:(NSString *)gifName;
- (void)playAnimation;//gif的时候播放动画

@end
