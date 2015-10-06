//
//  SXQueueRequest.h
//  SSUITool
//
//  Created by suger on 15/10/5.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXHttpLoadHandler.h"
#define KQUEUE_REQUEST_METHOD_KEY @"KQUEUE_REQUEST_METHOD_KEY"


@interface SXQueueRequest : SXHttpLoadHandler<SXHttpLoadDelegate,ASIProgressDelegate>
NSAssignReadonly NSInteger reqHandlerCount;

@end
