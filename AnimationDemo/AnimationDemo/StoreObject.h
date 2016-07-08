//
//  StoreObject.h
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/12.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreObject : NSObject <NSCoding>

@property (nonatomic, assign)       NSInteger           number;
@property (nonatomic, strong)       NSString           *name;
@property (nonatomic, strong)       NSString           *sex;

@end
