//
//  SXReqBodyDelegate.h
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  网络请求实体接口
 */
@protocol SXReqBodyDelegate <NSObject>
- (NSDictionary *)toBodyDictionary;
- (NSDictionary *)toHeadDictionary;


- ( NSString *)getReqURLMainDomin;
- ( NSString *)getReqURLSuffix;
- ( NSString *)getRespClassName;
- ( NSInteger )getReqMethod;

- ( dispatch_block_t)getCleanMBPBlock;
@end
