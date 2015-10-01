//
//  SXReqBaseBody.h
//  SSUITool
//
//  Created by Suger on 15/8/31.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXReqBodyDelegate.h"


@class session;

@interface SXReqBaseBody : NSObject<SXReqBodyDelegate>
NSStrong  session*   session;    //保存当前的session

//保存网络返回实体类
- (NSString * )getRespClassName;
//请求网络后缀
- (NSString * )getReqURLSuffix;
//请求网络方法
- (NSInteger)getReqMethod;

//请求完成后的清理 Hub 的block,使用get／set 方法替代属性，因若使用熟悉会造成toJson崩溃
- (void)setOnCleanMBPBlock:(dispatch_block_t )onCleanMBPBlock;
- (dispatch_block_t  ) getCleanMBPBlock ;
@end

@interface session : NSObject
@property (nonatomic, copy) NSString*  uid;
@property (nonatomic, copy) NSString*  sid;
@property (nonatomic, assign) NSInteger ts_cid_state;
@property (nonatomic, assign) NSInteger user_status;
@end