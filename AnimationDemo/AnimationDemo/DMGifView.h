//
//  DMGifView.h
//  DMAppFramework
//
//  Created by chenxinxin on 15/11/5.
//  Copyright (c) 2015年 dmall. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DMGifView : UIImageView

@property (strong,nonatomic) IBInspectable NSString* imageFileName;
@property (assign,nonatomic,readonly) CGSize imageSize;
@property (assign,nonatomic) float rate;

//!@brief 数据加载
-(void) loadFromData:(NSData*)data;

//!@brief 一次播放
-(void) playOnce;

//!@brief 循环播放
-(void) playLoop;

//!@brief 停止播放
-(void) stop;

@end
