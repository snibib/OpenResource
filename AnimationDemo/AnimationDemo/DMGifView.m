//
//  DMGifView.m
//  DMAppFramework
//
//  Created by chenxinxin on 15/11/5.
//  Copyright (c) 2015年 dmall. All rights reserved.
//

#import "DMGifView.h"
#import "FLAnimatedImage.h"
#import <QuartzCore/QuartzCore.h>

@interface DMGifView()
@property (strong,nonatomic) FLAnimatedImage        *animateImage;
@property (nonatomic, assign) NSTimeInterval        accumulator;
@property (nonatomic, strong) CADisplayLink         *displayLink;//用来循环播放
@property (nonatomic, assign) NSInteger             loopCount;//循环次数
@property (nonatomic, assign) BOOL                   needsDisplayWhenImageAvailable;

@property (nonatomic,strong) UIImage                *currentImage;//当前图片帧
@property (nonatomic,assign) NSUInteger              currentImageIndex;//当前图片帧下标
@property (strong,nonatomic) NSData                 *gifData;
@end

@implementation DMGifView

#pragma mark - gif图片名字设置
-(void) setImageFileName:(NSString *)imageFileName {
    _imageFileName = imageFileName;
    
    NSString *lastStr = nil;

    if (imageFileName.length > 4) {
        lastStr = [imageFileName substringFromIndex:imageFileName.length-4];
    }

    NSString* filePath = nil;
    if (lastStr.length == 4 && [lastStr isEqualToString:@".gif"]) {
        NSString *imgStr = [imageFileName substringToIndex:imageFileName.length-4];
        filePath = [[NSBundle mainBundle] pathForResource:imgStr ofType:@"gif"];
    }else{
        filePath = [[NSBundle mainBundle] pathForResource:imageFileName ofType:@"gif"];
    }
    [self loadFromData:[NSData dataWithContentsOfFile:filePath]];
}

#pragma mark - 图片数据加载
-(void) loadFromData:(NSData*)data {
    self.gifData = data;
    
    self.animateImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
    
    [self startAnimating];
}

#pragma mark - 设置进度 进度在 0-1
- (void)setRate:(float)rate {
    if (rate<0 || rate>1) {
        return;
    }
    
    self.currentImageIndex = lroundf((self.animateImage.frameCount-1)*rate);
    UIImage *image = [self.animateImage imageLazilyCachedAtIndex:self.currentImageIndex];
    self.currentImage = image;
    [self.layer setNeedsDisplay];
}

#pragma mark - 图片设置
- (void)setAnimateImage:(FLAnimatedImage *)animateImage {
    if (![_animateImage isEqual:animateImage]) {
        if (animateImage) {
            super.image = nil;
            super.highlighted = NO;
            [self invalidateIntrinsicContentSize];
        }
        
        _animateImage = animateImage;
        
        self.currentImage = animateImage.posterImage;
        self.currentImageIndex = 0;
        self.accumulator = 0.0;
        
        [self.layer setNeedsDisplay];
    }
}

#pragma mark - auto layout
- (CGSize)intrinsicContentSize {
    //使UIImageView 能够获得图片的大小
    CGSize intrinsicContentSize = [super intrinsicContentSize];
    
    if (self.animateImage) {
        intrinsicContentSize = self.image.size;
    }
    return intrinsicContentSize;
}

- (UIImage *)image {
    UIImage *image = nil;
    if (self.animateImage) {
        image = self.currentImage;
    }else {
        image = super.image;
    }
    return image;
}

-(CGSize) imageSize {
    return self.image.size;
}

- (void)setImage:(UIImage *)image {
    if (image) {
        //避免设置了gif图片和普通图片冲突
        self.animateImage = nil;
    }
    super.image = image;
}

#pragma mark - 动画一次播放
-(void) playOnce {
    self.loopCount = 1;
    self.currentImageIndex = 0;
    [self startAnimating];
}

#pragma mark - 动画循环播放
-(void) playLoop {
    self.loopCount = NSIntegerMax;
    self.currentImageIndex = 0;
    [self startAnimating];
}

#pragma mark - 动画停止播放
-(void) stop {
    [self stopAnimating];
}

-(void) setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    if (hidden) {
        [self stop];
    } else {
        [self playOnce];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    if (self.animateImage == nil) {//动态图片不支持高亮
        [super setHighlighted:highlighted];
    }
}
#pragma mark - 图片设置
- (void)displayLayer:(CALayer *)layer {
    layer.contents = (__bridge id)self.image.CGImage;
}

#pragma mark - 动画播放
- (void)startAnimating {
    [self stopAnimating];
    if (self.loopCount <= 0) {
        return;
    }
    if (self.animateImage) {
        if (self.displayLink == nil) {
            FLWeakProxy *weakProxy = [FLWeakProxy weakProxyForObject:self];
            self.displayLink = [CADisplayLink displayLinkWithTarget:weakProxy selector:@selector(displayDidRefresh:)];
            
            NSString *mode = NSDefaultRunLoopMode;
            
            if ([NSProcessInfo processInfo].activeProcessorCount > 1) {
                mode = NSRunLoopCommonModes;
            }
            [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:mode];
        }
        self.displayLink.paused = NO;
    }else {
        [super startAnimating];
    }
}

#pragma mark - 动画停止
- (void)stopAnimating {
    if (self.animateImage) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }else {
        [super stopAnimating];
    }
}

- (BOOL)isAnimating {
    BOOL isAnimating = NO;
    if (self.animateImage) {
        isAnimating = self.displayLink && !self.displayLink.paused;
    }else {
        isAnimating = [super isAnimating];
    }
    return isAnimating;
}

- (void)displayDidRefresh:(CADisplayLink *)displayLink {
    NSNumber *delayTimeNumber = [self.animateImage.delayTimesForIndexes objectForKey:@(self.currentImageIndex)];
    if (delayTimeNumber) {
        NSTimeInterval delayTime = [delayTimeNumber floatValue];
        UIImage *image = [self.animateImage imageLazilyCachedAtIndex:self.currentImageIndex];
        if (image) {
            self.currentImage = image;
            if (self.needsDisplayWhenImageAvailable) {
                [self.layer setNeedsDisplay];
                self.needsDisplayWhenImageAvailable = NO;
            }
            
            self.accumulator += displayLink.duration;
            
            while (self.accumulator >= delayTime) {
                self.accumulator -= delayTime;
                self.currentImageIndex++;
                if (self.currentImageIndex >= self.animateImage.frameCount) {
                    self.loopCount--;
                    self.currentImageIndex = 0;
                    if (self.loopCount <= 0) {
                        [self stopAnimating];
                    }
                }
                self.needsDisplayWhenImageAvailable = YES;
            }
        }
    }else {
        self.currentImageIndex++;
    }
}

- (void)dealloc {
    [_displayLink invalidate];
}
@end
