//
//  SXHttpLoadManager.h
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXHttpLoadDelegate.h"
#import "SXReqBodyDelegate.h"

/*!
 * 网络请求管理类
 */
@interface SXHttpLoadManager : NSObject
+ (SXHttpLoadManager *)shareInstance;

//error dictionary
NSStrong NSDictionary* errDictionary;
- (NSString *)getErrDescriptionByKey:(NSInteger)key;
//url
NSCopy NSString* mainReqURL;

//Requests handler
- (BOOL)addHttpLoadRequset:(id<SXHttpLoadDelegate>)sxHttpHandler;
- (BOOL)removeHttpLoadRequset:(id<SXHttpLoadDelegate>)sxHttpHandler;
- (__weak id<SXHttpLoadDelegate>)objectHttpLoadRequsetForKey:(id<NSCopying>)key;

//
//Requests Tool
- (__weak id<SXHttpLoadDelegate>)requestAtBody:(id<SXReqBodyDelegate>)reqBody
                  onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
                   onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock;

- (__weak id<SXHttpLoadDelegate>)requestAtBody:(id<SXReqBodyDelegate>)reqBody
                         onDoloadProgressBlock:(MutliDoloadingProgressBlock)_doloadProgressBlock
                                 onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
                                  onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock;
@end
