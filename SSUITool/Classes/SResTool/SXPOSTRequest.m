//
//  SXPOSTRequest.m
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXPOSTRequest.h"


@implementation SXPOSTRequest


#pragma mark - SXHttpLoadDelegate
- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(id<NSCopying>)bodyParams {
    ASIFormDataRequest* req = [ASIFormDataRequest requestWithURL:url];
    //主要是对 bodyParams 参数进行赋值
    //并且设置 delegate 和 方法
    
    //set req body
    id obj = bodyParams;
    if (url == nil || bodyParams == nil || ![obj isKindOfClass:[NSDictionary class]]) {
        SLog(@"url or bodyParams is nil ");
        return nil;
    }
    NSString* json = [ASIJSONTool toJSONString:bodyParams];
    if (json == nil) {
        SLog(@"toJSONString is failed");
        return nil;
    }
    //-----------去掉 "[
    json = [json stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
    json = [json stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
    //-----------去掉 ]"
    SLog(@"------> %@",json);
    
    
    [req setPostValue:json forKey:@"json"];
    
    [req setDelegate: self];
    //注册父类的成功方法为回调方法
    [req setDidFinishSelector:@selector(asiFetchFinish:)];
    //注册父类的失败方法为回调方法
    [req setDidFailSelector:@selector(asiFetchFailed:)];
    return req;
}




@end
