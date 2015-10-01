//
//  SXResLoadHandler.h
//  SSUITool
//
//  Created by Suger on 15/8/29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXResHeader.h"

/*!
 *  所有的资源加载句柄
 */
@interface SXResLoadHandler : NSObject
//instance
+ (SXResLoadHandler *)shareInstance;
//getter
- (__weak NSMutableDictionary *)getAllXResource;
- (__weak id<NSCopying>)getXResourceByKey:(id<NSCopying>)key;

//setter
- (BOOL)setXResouce:(id<NSCopying>)resource forKey:(id<NSCopying>)key;
//clean
- (void)cleanAllXResource;
- (BOOL)cleanXResourceWithKey:(id<NSCopying>)key;
@end
