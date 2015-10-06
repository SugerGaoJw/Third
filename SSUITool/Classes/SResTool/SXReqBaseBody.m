//
//  SXReqBaseBody.m
//  SSUITool
//
//  Created by Suger on 15/8/31.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXReqBaseBody.h"
@interface SXReqBaseBody() {
   __weak  dispatch_block_t _onCleanMBPBlock;
}
@end
@implementation SXReqBaseBody

- (NSDictionary *)toBodyDictionary {
    return [self keyValues];
}
- (NSDictionary *)toHeadDictionary {
    return nil;
}

- (NSString *)getRespClassName{
    return nil;
}

- (NSString *)getReqURLSuffix {
    return nil;
}
- ( NSString *)getReqURLMainDomin {
    return nil;
}
- (NSInteger)getReqMethod {
    //默认是POST 请求方法
    return 0;
}

- (dispatch_block_t)getCleanMBPBlock {
    return _onCleanMBPBlock;
}

- (void)setOnCleanMBPBlock:(dispatch_block_t)onCleanMBPBlock {
    _onCleanMBPBlock = onCleanMBPBlock;
}

- (session *)session {
    if (_session == nil) {
        _session = [[session alloc]init];
    }
    return _session;
}

@end


@implementation session
- (NSString *)uid {
    return @"11073";
}
- (NSString *)sid {
    return @"11073";
}
- (NSInteger)ts_cid_state {
    return 0;
}
- (NSInteger)user_status {
    return 0;
}
@end