//
//  SXibLoadHandler.h
//  SSUITool
//
//  Created by Suger on 15/8/28.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainNavigationController.h"
#import "SXibLoadHeader.h"

@interface SXibLoadHandler : NSObject

@property(nonatomic,strong,readonly) UIStoryboard* mainStoryboard;
+ (SXibLoadHandler *)shareInstance;


gxloaderHeader(MainNavigationController)

@end
