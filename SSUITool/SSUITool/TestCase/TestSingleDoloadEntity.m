//
//  TestSingleDoloadEntity.m
//  SSUITool
//
//  Created by suger on 15/10/5.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "TestSingleDoloadEntity.h"

@implementation TestReqSingleDoloadEntity
- ( NSInteger )getReqMethod {
    return EN_REQUEST_MUTLI_DOWNLOAD;
}

- (NSString *)getRespClassName {
    return NSStringFromClass([TestRespSingleDoloadEntity class]);
}

- (session *)session {
    return nil;
}
@end


@implementation TestRespSingleDoloadEntity

@end