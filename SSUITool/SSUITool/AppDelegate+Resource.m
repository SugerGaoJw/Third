//
//  AppDelegate+Resource.m
//  SSUITool
//
//  Created by Suger on 15/8/29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "AppDelegate+Resource.h"
#import "SXHttpLoadManager.h"

@implementation AppDelegate (Resource)
-(void)loadAppResource {
    NSBundle* b = [self bundleHandler];
    NSString* path = [b pathForResource:KRCustomViewcontrollerList ofType:@"plist"];
    NSArray* array = [NSArray arrayWithContentsOfFile:path];
    [[SXResLoadHandler shareInstance]setXResouce:array forKey:KRCustomViewcontrollerList];
}

- (void)loadAppServerAddress {
    SLog(@"req url is %@",SERVER_URL);
    [[SXHttpLoadManager shareInstance]setMainReqURL:SERVER_URL];
}


- (NSBundle *)bundleHandler {
    return [NSBundle mainBundle];
}

@end
