//
//  DMRefreshHeader.h
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "DMRefreshBaseComponent.h"

typedef enum {
    DMRefreshHeaderStateIdle = 1,
    DMRefreshHeaderStatePulling,
    DMRefreshHeaderStateRefreshing,
    DMRefreshHeaderStateWillRefresh
} DMRefreshHeaderState;

@interface DMRefreshHeader : DMRefreshBaseComponent

@property (nonatomic, copy) NSString    *dateKey;
@property (nonatomic, copy) NSString    *(^updatedTimeTitle)(NSDate *updatedTime);

@property (nonatomic, assign, getter=isStateHidden) BOOL stateHidden;
@property (nonatomic, assign, getter=isUpdatedTimeHidden) BOOL updatedTimeHidden;

@property (nonatomic, assign) DMRefreshHeaderState state;
@property (nonatomic, assign) CGFloat   pullingRate;

- (void)setTitle:(NSString *)title forState:(DMRefreshHeaderState)state;

@end
