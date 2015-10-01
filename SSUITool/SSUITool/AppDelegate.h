//
//  AppDelegate.h
//  SSUITool
//
//  Created by Suger on 15/8/28.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
NSWeak UINavigationController* navigationCtrl;
+(AppDelegate *)shareInstance;

@end

