//
//  DMSpring.h
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/8.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DMSpringable <NSObject>

@property (nonatomic, assign)    BOOL               autostart;
@property (nonatomic, assign)    BOOL               autohide;
@property (nonatomic, strong)    NSString           *animation;
@property (nonatomic, assign)    CGFloat            force;
@property (nonatomic, assign)    CGFloat            delay;
@property (nonatomic, assign)    CGFloat            duration;
@property (nonatomic, assign)    CGFloat            damping;
@property (nonatomic, assign)    CGFloat            velocity;
@property (nonatomic, assign)    float              repeatCount;
@property (nonatomic, assign)    CGFloat            springx;
@property (nonatomic, assign)    CGFloat            springy;
@property (nonatomic, assign)    CGFloat            scaleX;
@property (nonatomic, assign)    CGFloat            scaleY;
@property (nonatomic, assign)    CGFloat            rotate;
@property (nonatomic, assign)    CGFloat            opacity;
@property (nonatomic, assign)    BOOL               animateFrom;
@property (nonatomic, strong)    NSString           *curve;

@optional
@property (nonatomic, strong, readonly)    CALayer      *layer;
@property (nonatomic, assign)    CGAffineTransform      transform;
@property (nonatomic)           CGFloat             alpha;

-(void)animate;
-(void)animateNext:(void (^)(void))completion;
-(void)animateTo;
-(void)animateToNext:(void (^)(void))completion;

@end

@interface DMSpring : NSObject
{
    id <DMSpringable>       view;
    BOOL                    shouldAnimateAfterActive;
}

- (instancetype)initWithView:(id<DMSpringable>)newView;

- (void)customAwakeFromNib;
- (void)customDidMoveToWindow;
- (void)animate;
- (void)animateNext:(void (^)(void))completion;
- (void)animateTo;
- (void)animateToNext:(void (^)(void))completion;

@end
