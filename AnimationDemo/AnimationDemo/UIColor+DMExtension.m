//
//  UIColor+DMExtension.m
//  DMall
//
//  Created by chris on 15/5/1.
//  Copyright (c) 2015年 wintech. All rights reserved.
//

#import "UIColor+DMExtension.h"

@implementation UIColor (DMExtension)

+ (UIColor*) colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b{
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (UIColor*) colorWithString:(NSString *)string{
    if([string hasPrefix:@"#"])
        string = [string substringFromIndex:1];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]];
    unsigned hex;
    BOOL success = [scanner scanHexInt:&hex];
    
    if(!success)    return nil;
    
    CGFloat red   = ((hex & 0xFF0000) >> 16) / 255.0f;
    CGFloat green = ((hex & 0x00FF00) >>  8) / 255.0f;
    CGFloat blue  =  (hex & 0x0000FF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
