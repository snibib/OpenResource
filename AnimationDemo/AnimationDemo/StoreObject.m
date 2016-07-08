//
//  StoreObject.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/12.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "StoreObject.h"
#import <objc/runtime.h>

@interface StoreObject()

@end

@implementation StoreObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        NSDictionary *properties = [self properties];
        
        [properties enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSDictionary *properties = [self properties];
    
    [properties enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [aCoder encodeObject:obj forKey:key];
    }];
}

- (NSDictionary *)properties {
    NSMutableDictionary *pros = [NSMutableDictionary dictionary];
    unsigned int outCount,i;
    objc_property_t *myProperties = class_copyPropertyList([self class], &outCount);
    
    for (i=0; i<outCount; i++) {
        objc_property_t property = myProperties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [pros setObject:propertyValue forKey:propertyName];
        }else {
            [pros setObject:[NSNull null] forKey:propertyName];
        }
    }
    free(myProperties);
    return pros;
}

- (NSString *)description {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self properties] options:NSJSONWritingPrettyPrinted error:nil];
    NSString *description = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return description;
}

@end
