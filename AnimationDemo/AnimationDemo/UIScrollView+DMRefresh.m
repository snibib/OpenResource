//
//  UIScrollView+DMRefresh.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/3.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "UIScrollView+DMRefresh.h"
#import "DMRefreshDefaultHeader.h"
#import "DMRefreshDefaultFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (DMRefresh)

- (DMRefreshDefaultHeader *)addDefaultHeaderWithRefreshingBlock:(void (^)())block {
    DMRefreshDefaultHeader *header = [[DMRefreshDefaultHeader alloc] init];
    header.refreshingBlock = block;
    self.header = header;//此位置会引起循环引用,未解决
    return header;
}

- (DMRefreshDefaultFooter *)addDefaultFooterWithRefreshingBlock:(void (^)())block {
    DMRefreshDefaultFooter *footer = [[DMRefreshDefaultFooter alloc] init];
//    self.footer = footer;//此位置会引起循环引用,未解决
    footer.refreshingBlock = block;
    return footer;
}

static char DMRefreshHeaderKey;

- (void)setHeader:(DMRefreshHeader *)header {
    if (header != self.header) {
        [self.header removeFromSuperview];
        
        [self willChangeValueForKey:@"header"];
        objc_setAssociatedObject(self, &DMRefreshHeaderKey, header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"];
        
        [self addSubview:header];
    }
}

- (DMRefreshHeader *)header {
    return objc_getAssociatedObject(self, &DMRefreshHeaderKey);
}

- (DMRefreshDefaultHeader *)defaultHeader {
    if ([self.header isKindOfClass:[DMRefreshDefaultHeader class]]) {
        return (DMRefreshDefaultHeader *)self.header;
    }
    return nil;
}

static char DMRefreshFooterKey;
- (void)setFooter:(DMRefreshFooter *)footer {
    if (footer != self.footer) {
        [self.footer removeFromSuperview];
        
        [self willChangeValueForKey:@"footer"];
        objc_setAssociatedObject(self, &DMRefreshFooterKey, footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"];
        
        [self addSubview:footer];
    }
}

- (DMRefreshFooter *)footer {
    return objc_getAssociatedObject(self, &DMRefreshFooterKey);
}

- (DMRefreshDefaultFooter *)defaultFooter {
    if ([self.footer isKindOfClass:[DMRefreshDefaultFooter class]]) {
        return (DMRefreshDefaultFooter *)self.footer;
    }
    return nil;
}

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}

- (void)deallocSwizzle {
    [self removeFooter];
    [self removeHeader];
    
    [self deallocSwizzle];
}

- (void)removeHeader {
    self.header = nil;
}

- (void)removeFooter {
    self.footer = nil;
}
@end
