//
//  TestNetAdrEntity.h
//  SSUITool
//
//  Created by Suger on 15/8/31.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXReqBaseBody.h"
#import "SXRespBaseBody.h"

@interface TestReqAdrEntity : SXReqBaseBody
NSCopy NSString* a;
@end


@interface TestRespAdrEntity : SXRespBaseBody
NSStrong NSArray* adr_list;
NSStrong status* status;
@end


@class LoginSeesion;
@interface TestLoginSeesion : SXRespBaseBody
NSStrong LoginSeesion* loginSesion;
@end


@interface LoginSeesion : NSObject
@property (copy,nonatomic) NSString *message;
@property (copy,nonatomic) NSNumber *pass;
@property (copy,nonatomic) NSString *loginName;
@end

@interface AdrDetialInfo : NSObject
@property (copy,nonatomic) NSString *adrId;
@property (copy,nonatomic) NSString *consignee;
@property (copy,nonatomic) NSString *shi;
@property (copy,nonatomic) NSString *mobile;
@property (copy,nonatomic) NSString *def;
@property (copy,nonatomic) NSString *sheng;
@property (copy,nonatomic) NSString *user_id;
@property (copy,nonatomic) NSString *sheng_status;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *shi_status;
@property (copy,nonatomic) NSString *qu;
@property (copy,nonatomic) NSString *qu_status;
@end