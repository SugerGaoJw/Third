//
//  SMacro.h
//  SUITool
//
//  Created by Suger on 15/8/27.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#ifndef SUITool_SMacro_h
#define SUITool_SMacro_h



/*
#ifndef dispatch_main_sync_safe
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif*/


//判断是否是 release 版本， 如果是release 版本则宏定义为 1 ,反则为 0
#ifndef S_RELEASE_VERSRION
#define S_RELEASE_VERSRION 0
#endif

//LOG
#if S_RELEASE_VERSRION
    # define SLog(fmt, ...) ;
    # define SLogNil ;
#else
    # define SLog(fmt, ...) NSLog((@"-> %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
    # define SLogNil SLog(@"-> is NULL");
#endif


//屏幕 UIScreen 宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

//判断是否IOS .x 以上
#define SystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)

//请求网络URL
#define DOMAIN_SERVER_URL @"http://funchi.chifan580.com/"
#define SERVER_URL @"http://funchi.chifan580.com/appindex.php?m=app/"


#endif
