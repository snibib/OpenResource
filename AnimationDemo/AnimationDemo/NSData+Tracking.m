//
//  NSData+Tracking.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/6/6.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "NSData+Tracking.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSData (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(getBytes:);
        SEL swizzledSelector = @selector(yh_getBytes:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)yh_getBytes:(void *)buffer {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self getBytes:buffer length:[self length]];
    }else {
        [self yh_getBytes:buffer];
    }
    
}

@end
