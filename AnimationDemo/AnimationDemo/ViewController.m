//
//  ViewController.m
//  AnimationDemo
//
//  Created by 杨涵 on 15/12/3.
//  Copyright © 2015年 yanghan. All rights reserved.
//

#import "ViewController.h"
#import "DMSpringView.h"
#import "CircleView.h"
#import "DMCategoryMenu.h"
#import "UIView+CircleView.h"
//#import "AnimationDemo-Swift.h"
#import "DMButtonAAR.h"
#import "ViewController2.h"
#import "UIImage+WebP.h"

@interface ViewController ()
{
    UIView *fatherView;
    DMSpringView *myView;
    DMSpringView *myView1;
    
    NSInteger index;
    
    UIButton *circle;
    
    DMCategoryMenu *menu;
    CGFloat     progress;
    DMButtonAAR *addBtn;
    
    CGRect      beginFrame;
    CGRect      endFrame;
    
    UIView      *headerView;
    
    NSMutableDictionary    *testDic;
}
@end

static UIView *commonFather = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    
//    fatherView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.view.width, 64)];
//    fatherView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:fatherView];
//    
//    //1
//    myView = [[DMSpringView alloc] initWithFrame:fatherView.bounds];
//    myView.backgroundColor = [UIColor blueColor];
//    [fatherView addSubview:myView];
//    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
//    view1.backgroundColor = self.view.backgroundColor;
//    view1.tag = 98;
//    [fatherView addSubview:view1];
//    
//    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (view1.height-24)/2, 24, 24)];
//    image1.image = [UIImage imageNamed:@"add_ico"];
//    image1.tag = 99;
//    [view1 addSubview:image1];
//    
//    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(fatherView.width-10-35, (fatherView.height-35)/2, 35, 35)];
//    image2.tag = 100;
//    image2.image = [UIImage imageNamed:@"add_select"];
//    [fatherView addSubview:image2];
//    
//    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((self.view.width-150)/2, 100, 150, 20)];
//    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
//    slider.minimumValue = 0.0;
//    slider.maximumValue = 1.0;
//    slider.value = 0.0;
//    [self.view addSubview:slider];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
//    typeof(imageView) welkView = imageView;
//    [UIImage imageToWebP:[UIImage imageNamed:@"foodImage.jpg"] quality:70 alpha:1.0 preset:WEBP_PRESET_PICTURE completionBlock:^(NSData *result) {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *webPath = [paths[0] stringByAppendingPathComponent:@"image.webp"];
//        if (![result writeToFile:webPath atomically:YES]) {
//            NSLog(@"failed to save");
//        }else {
//            [UIImage imageFromWebP:webPath completionBlock:^(UIImage *result) {
//                imageView.image = result;
//            } failureBlock:^(NSError *error) {
//    
//            }];
//        }
//    } failureBlock:^(NSError *error) {
//    
//    }];
    NSString *webPath = [[NSBundle mainBundle] pathForResource:@"test0" ofType:@"webp"];
    [UIImage imageFromWebP:webPath completionBlock:^(UIImage *result) {
        imageView.image = result;
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)sliderChange:(UISlider *)slider {
    
    UIImageView *image1 = [self.view viewWithTag:99];
    UIImageView *image2 = [self.view viewWithTag:100];
    
    [self moveView:image2 toView:image1 withRate:slider.value];
}

- (void)moveView:(UIView *)view1 toView:(UIView *)view2 withRate:(CGFloat)rate {
    if (commonFather == nil) {
        BOOL done = NO;
        for (UIView *father1 = view1; father1; father1 = father1.superview) {
            for (UIView *father2 = view2; father2; father2 = father2.superview) {
                if (father1 == father2) {
                    done = YES;
                    commonFather = father1;
                    break;
                }
            }
            if (done) {
                break;
            }
        }
        if (commonFather == nil) {
            return;
        }
        beginFrame = [commonFather convertRect:view1.frame fromView:view1.superview];
        endFrame = [commonFather convertRect:view2.frame fromView:view2.superview];
    }
    CGFloat xAdjust = (beginFrame.origin.x-endFrame.origin.x)*rate;
    CGFloat yAdjust = (beginFrame.origin.y-endFrame.origin.y)*rate;
    CGFloat widthAdjust = (beginFrame.size.width-endFrame.size.width)*rate;
    CGFloat heightAdjust = (beginFrame.size.height-endFrame.size.height)*rate;
    
    view1.frame = CGRectMake(beginFrame.origin.x-xAdjust,beginFrame.origin.y-yAdjust,beginFrame.size.width-widthAdjust,beginFrame.size.height-heightAdjust);
}

- (IBAction)changeAction:(UIBarButtonItem *)sender {
//    CATransition *animation = [CATransition animation];
//    [animation setDelegate:self];
//    [animation setDuration:2.0f];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:@"easeInEaseOut"]];
//    [animation setType:@"moveIn"];
//    [myView.layer addAnimation:animation forKey:NULL];
    [self animation1];
//    index ++;
//
//    if (index%2 == 1) {
//        [circle reveal];
//    }else {
//        [circle conceal];
//    }
//    [self animation3];
//
//    progress = 0.0;
//    [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(beginChange) userInfo:nil repeats:YES];
}

- (IBAction)nextPage:(UIBarButtonItem *)sender {
//    ViewController1 *vc1 = [[ViewController1 alloc] init];
//    vc1.myFunc = ^(void) {
////        [circle performSelector:@selector(reveal) withObject:nil afterDelay:0.5];
////        [circle reveal];
//        [addBtn playAnimation];
//    };
//    [self.navigationController pushViewController:vc1 animated:YES];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    vc2.block = ^() {
        NSLog(@"block is using");
    };
    void (^block)() = ^(){
        NSLog(@"block is usingagain");
    };
    NSDictionary *dic = @{@"block":block};
    vc2.blocks = @[dic];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)beginChange {
    [menu animationWithRate:progress];
    progress += 0.01;
}

- (void)animation2 {
    [UIView beginAnimations:nil context:nil];
    //持续时间
    [UIView setAnimationDuration:1.0];
    //在出动画的时候减缓速度
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //添加动画开始及结束的代理
    [UIView setAnimationDelegate:self];
    //动画效果
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:fatherView cache:YES];
    [fatherView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView commitAnimations];
}

- (void)animation1 {
        index ++;
        if (index%2 != 0) {
            myView.force = self.view.frame.size.height/300;
            myView.duration = 0.8;
            myView.delay = 0.0;
            myView.damping = 0.7;
            myView.velocity = 0.7;
            myView.scaleX = 1.0;
            myView.scaleY = 1.0;
            myView.springx = 0.0;
            myView.springy = 0.0;
            myView.rotate = 0.0;
            myView.animation = @"swing";
            myView.curve = @"easeOut";
        }else{
            myView.force = 1.0;
            myView.duration = 0.8;
            myView.delay = 0.0;
            myView.damping = 0.7;
            myView.velocity = 0.7;
            myView.scaleX = 1.0;
            myView.scaleY = 1.0;
            myView.springx = 0.0;
            myView.springy = 0.0;
            myView.rotate = 0.0;
            myView.animation = @"flipX";
            myView.curve = @"easeOut";
        }
        [myView animate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
