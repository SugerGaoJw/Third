//
//  SXibLoadHandler.m
//  SSUITool
//
//  Created by Suger on 15/8/28.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXibLoadHandler.h"
static SXibLoadHandler* instance = nil;
@implementation SXibLoadHandler
- (UIStoryboard *)mainStoryboard {
    if (_mainStoryboard == nil) {
        _mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    return _mainStoryboard;
}
@synthesize mainStoryboard = _mainStoryboard;


+ (id)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SXibLoadHandler alloc]init];
    });
    
//    NSAssert(instance == nil, @"SXibLoadHandler load failed !");
    return instance;
}

gxloaderMethod(MainNavigationController)

@end
