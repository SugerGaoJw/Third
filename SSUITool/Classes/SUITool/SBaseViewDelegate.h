//
//  SBaseViewDelegate.h
//  SSUITool
//
//  Created by Suger on 15/8/31.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 *  此delegate 申明常见的方法
 */
@protocol SBaseViewDelegate <NSObject>
@optional
/*!
 *  请求网路数据接口
 */
- (void)gbReqNetworkInterface;
/*!
 *  检查输入值
 */
- (void)gbCheckInputValues;

@end
