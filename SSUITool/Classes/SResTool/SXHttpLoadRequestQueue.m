//
//  SXHttpLoadRequestQueue.m
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXHttpLoadRequestQueue.h"

@implementation SXHttpLoadRequestQueue
- (__weak id<NSCopying> )asiInitWithURL:(NSURL *)url withParams:(id<NSCopying>)params {
    ASINetworkQueue* queue = [[ASINetworkQueue alloc] init];
    return queue;
}


@end
