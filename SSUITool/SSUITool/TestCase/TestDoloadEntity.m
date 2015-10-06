//
//  TestDoloadEntity.m
//  SSUITool
//
//  Created by suger on 15/10/5.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "TestDoloadEntity.h"

@implementation TestReqDoloadEntity
- ( NSInteger )getReqMethod {
    return EN_REQUEST_MUTLI_DOWNLOAD;
}

- (NSString *)getRespClassName {
    return NSStringFromClass([TestRespDoloadEntity class]);
}

- (NSString *)getReqURLMainDomin {
    if (_mainDominURL == nil) {
        
        //        mainDomin = @"http://allseeing-i.com/i/logo.png";
        return @"http://allseeing-i.com/ASIHTTPRequest/tests/cached-redirect";
    }
    return _mainDominURL;
}

- (session *)session {
    return nil;
}
@end


@implementation TestRespDoloadEntity

@end