//
//  SXGETRequest.m
//  SSUITool
//
//  Created by suger on 15/9/30.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXGETRequest.h"
@interface SXGETRequest ()

@end

@implementation SXGETRequest
- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(NSDictionary *)bodyParams {
    //set req body
    if (![NSObject isEqualSrcObject:(id)url EnqualClass:[NSURL class]]
        ||![NSObject isEqualSrcObject:(id)bodyParams EnqualClass:[NSDictionary class]]) {
        SLog(@"url or bodyParams is nil ");
        return nil;
    }
    
    //判断 是否有参数，如果有参数，根据 GET 请求方式拼配参数

    NSURL* reqURL = url;
    NSString* urlSuffix = [super pdtURLSuffixByParams:bodyParams];
    if (urlSuffix != nil) {
        NSString* multiStr = [NSString stringWithFormat:@"%@%@",url,urlSuffix];
        reqURL = [multiStr url];
        if (reqURL == nil) {
            NSLog(@"create request URL is falied");
            return nil;
        }
    }
    
    SLog(@"reqURL is %@",reqURL);
    // 生成 ASIHTTPRequest 对象
    ASIHTTPRequest* req = [ASIHTTPRequest requestWithURL:reqURL];
    [req setDelegate: self];
    //注册父类的成功方法为回调方法
    [req setDidFinishSelector:@selector(asiFetchFinish:)];
    //注册父类的失败方法为回调方法
    [req setDidFailSelector:@selector(asiFetchFailed:)];
    
    return req;
}


@end
