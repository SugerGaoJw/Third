//
//  SXGETRequest.m
//  SSUITool
//
//  Created by suger on 15/9/30.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXGETRequest.h"
@interface SXGETRequest ()
/*!
 *  @author Suger G, 15-10-01 07:10:36
 *
 *  通过 dictionary 对象生成 URL 后缀
 *
 *  @return URL 后缀
 */
- ( NSString *)pdtURLSuffixByParams:(id ) params ;
@end

@implementation SXGETRequest
- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(id<NSCopying>)bodyParams {
    //set req body
    id obj = bodyParams;
    if (url == nil || bodyParams == nil
        || ![obj isKindOfClass:[NSDictionary class]]) {
        SLog(@"url or bodyParams is nil ");
        return nil;
    }
    
    //判断 是否有参数，如果有参数，根据 GET 请求方式拼配参数

    NSURL* reqURL = url;
    NSString* urlSuffix = [self pdtURLSuffixByParams:bodyParams];
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

- (NSString *)pdtURLSuffixByParams:(id )params {
    
    NSDictionary* dic = nil;
    if (![params isKindOfClass:[NSDictionary class]]
        || [params isKindOfClass:[NSNull class]]
        || params == nil) {
        return nil;
    }
    
    dic = ( NSDictionary *)params;
    NSMutableString* str = [[NSMutableString alloc]init];
    [str appendString:@"?"];
    
    //循环迭代字典
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString* part = [NSString stringWithFormat:@"%@=%@&",key,obj];
        [str appendString:part];
    }];
    //去掉最后一个 & 符号
    NSString* urlSuffix = [str substringWithRange:NSMakeRange(0, str.length - 1)];
    if (urlSuffix.length <= 0) {
        return nil;
    }
    return urlSuffix;
    
}
@end
