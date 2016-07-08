//
//  ViewController2.h
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/4.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController

@property (nonatomic, strong)   NSString     *titleStr;

@property (nonatomic, copy)    void         (^block)();//block 以类型存在
@property (nonatomic, strong)   NSArray     *blocks;


@end
