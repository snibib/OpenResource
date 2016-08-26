//
//  ViewController.m
//  JSToObjectiveC
//
//  Created by 杨涵 on 16/7/28.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet    UIWebView      *webV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlPath]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if ([[url scheme] isEqualToString:@"firstclick"]) {
        NSArray *params = [url.query componentsSeparatedByString:@"&"];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (NSString *paramStr in params) {
            NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
            if (dicArray.count > 1) {
                NSString *decodeValue = [dicArray[1] stringByRemovingPercentEncoding];
                [tempDic setObject:decodeValue forKey:dicArray[0]];
            }
        }
        NSLog(@"tempDic:%@",tempDic);
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webV valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"share"] = ^() {
        NSLog(@"begin log");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@",jsVal.toString);
        }
        NSLog(@"end log");
    };
}

@end
