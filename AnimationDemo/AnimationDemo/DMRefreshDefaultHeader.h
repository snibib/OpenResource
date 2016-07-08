//
//  DMRefreshDefaultHeader.h
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/5.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "DMRefreshHeader.h"

@interface DMRefreshDefaultHeader : DMRefreshHeader

/** arrow image when pull down */
@property (nonatomic, strong) NSString   *headerImageName;
@property (nonatomic, strong) NSArray    *refreshingImages;

@end
