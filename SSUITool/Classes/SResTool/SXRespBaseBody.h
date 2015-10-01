//
//  SXRespBaseBody.h
//  SSUITool
//
//  Created by Suger on 15/8/31.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXRespBodyDelegate.h"


@interface status : NSObject
NSAssign NSInteger succeed;
@end


@interface SXRespBaseBody : NSObject<SXRespBodyDelegate>
NSCopy NSString * errCode;      //错误码
NSCopy NSString * errDescription; //错误描述
@end
