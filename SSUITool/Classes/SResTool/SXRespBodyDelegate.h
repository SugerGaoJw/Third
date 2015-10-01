//
//  SXRespBodyDelegate.h
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  网络返回实体接口
 */
@protocol SXRespBodyDelegate <NSObject>
- (id<SXRespBodyDelegate>)toEntityWithValues:(id)values;
@end
