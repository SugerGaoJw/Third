//
//  SXHttpLoadHandler.h
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXHttpLoadDelegate.h"
#import "SXReqBodyDelegate.h"
#import "SXRespBodyDelegate.h"

#import "SXHttpLoadManager.h"



@interface SXHttpLoadHandler : NSObject<SXHttpLoadDelegate>
/*!
 *  Block is Copy
 */
NSCopy SXHttpRequestFinishBlock finishBlock;
NSCopy SXHttpRequestFailedBlock failedBlock;
NSCopy dispatch_block_t cleanMBPblock;
NSCopy NSString* respClassName;
//request POST
- (void)sxReqBody:(id<SXReqBodyDelegate>)reqBody;

//queue
- (void)sxSetHttpLoadRequests:(NSArray * /*SXPOSTRequest Object */)reqArray;
//clean
- (void)sxForceCancel;
- (void)sxCleanResource;

//利用 runtime 生成对象
- (instancetype)initWithClassName:(NSString *)className;
@end
