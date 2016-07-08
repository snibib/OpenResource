//
//  DMRefreshFooter.h
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "DMRefreshBaseComponent.h"

typedef enum {
    DMRefreshFooterStateIdle = 1,//nomal
    DMRefreshFooterStateRefreshing,//freshing
    DMRefreshFooterStateNoMoreData//no more data
} DMRefreshFooterState;

@interface DMRefreshFooter : DMRefreshBaseComponent

/** fresh the state of the control */
@property (nonatomic, assign)   DMRefreshFooterState    state;

/** whether hide the label */
@property (nonatomic, assign, getter=isSateHidden) BOOL stateHidden;

/** automationcallyRefresh, default is Yes */
@property (nonatomic, assign, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

//hide the bottom control by the occurrence rate,default 1.0
@property (nonatomic, assign) CGFloat   appearenceRate;

/** set the title with state */
- (void)setTitle:(NSString *)title forState:(DMRefreshFooterState)state;

@end
