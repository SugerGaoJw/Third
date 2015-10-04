//
//  SXMutliDoLoadRequest.h
//  SSUITool
//
//  Created by suger on 15/10/3.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//
#include "SXHttpLoadHandler.h"
#import "SXMutliStatusMachine.h"
/*!
 *  @author Suger G, 15-10-03 07:10:44
 *
 *  实现支持多个文件下载和断点续传
 */
@interface SXMutliDoLoadRequest : SXHttpLoadHandler<SXHttpLoadDelegate,ASIProgressDelegate> NSAssignReadonly CGFloat doloadPercentage;
@end
