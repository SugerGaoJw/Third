//
//  SXHttpLoadManager.m
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXHttpLoadManager.h"
#import "SXPOSTRequest.h"
#import "SXGETRequest.h"


@interface SXHttpLoadManager()
NSStrong NSMutableDictionary* dictionary;

- (__weak id<SXHttpLoadDelegate>)pdtHttpRequestByEnum:(EN_REQUEST_METHOD)enReqMethod;
@end

static SXHttpLoadManager* instance = nil;
@implementation SXHttpLoadManager
+ (SXHttpLoadManager *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SXHttpLoadManager alloc]init];
    });
    return instance;
}

- (NSMutableDictionary *)dictionary {
    if (_dictionary == nil) {
        _dictionary = [[NSMutableDictionary alloc]init];
    }
    return _dictionary;
}

#pragma mark -- Url
- (NSString *)mainReqURL {
    /*!
     *  eg.url 请求地址切换
     */
    
    return _mainReqURL;
}

#pragma mark -- Create

- (__weak id<SXHttpLoadDelegate> )requestAtBody:(id<SXReqBodyDelegate>)reqBody
        onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
         onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock {
   
    if (reqBody == nil || _finishBlock == nil || _failedBlock == nil) {
        SLog(@"reqNetSeverAppend Error");
        return nil;
    }
    //根据 EN_REQUEST_METHOD 请求方法实例相对应的请求实体类
    EN_REQUEST_METHOD enReqMethod = [reqBody getReqMethod];
    SXHttpLoadHandler* reqHandler = (SXHttpLoadHandler *)[self pdtHttpRequestByEnum:enReqMethod];
    
    //配置请求实例对象的属性
    [reqHandler sxReqBody:reqBody];
    reqHandler.finishBlock = _finishBlock;
    reqHandler.failedBlock = _failedBlock;
    
    //放入请求字典内，以便管理
    [self addHttpLoadRequset:reqHandler];
    return reqHandler;

}
- (__weak id<SXHttpLoadDelegate>)pdtHttpRequestByEnum:(EN_REQUEST_METHOD)enReqMethod {
    SXHttpLoadHandler* httpLoadHander = nil;
    switch (enReqMethod) {
        case EN_REQUEST_POST:
            SLog(@"EN_REQUEST_POST");
            httpLoadHander = [[SXPOSTRequest alloc]init]; break;
         case EN_REQUEST_GET:
            SLog(@"EN_REQUEST_GET");
            httpLoadHander = [[SXGETRequest alloc]init];break;
        default:
            break;
    }
    return httpLoadHander;
}

#pragma mark -- Response

- (NSString *)getErrDescriptionByKey:(NSInteger)key {
    return [self.errDictionary objectForKey:@(key)];
    
}

- (NSDictionary *)errDictionary {
    if (_errDictionary == nil) {
        _errDictionary = @{@(ASIConnectionFailureErrorType):@"亲网络不给力，请稍后再试",
                           @(ASIRequestTimedOutErrorType):@"亲请求超时，请稍后再试",
                           @(ASIAuthenticationErrorType):@"认证出现问题，请确认再试",
                           @(ASIRequestCancelledErrorType):@"亲，您已取消网络请求",
                           @(ASIUnableToCreateRequestErrorType):@"亲检查网络链接，请稍后再试",
                           @(ASIInternalErrorWhileBuildingRequestType):@"亲无法建立网络链接，请稍后再试",
                           @(ASIInternalErrorWhileApplyingCredentialsType):@"亲无法申请认证，请稍后再试",
                           @(ASIFileManagementError):@"亲手机本地文件出现问题，请稍后再试",
                           @(ASITooMuchRedirectionErrorType):@"亲网络不稳定，请稍后再试",
                           @(ASIUnhandledExceptionError):@"亲出现未知，请稍后再试",
                           @(ASICompressionError):@"网络请求不稳定，请稍后再试"};
    }
    return _errDictionary;
}

#pragma mark -- Requests

- (BOOL)addHttpLoadRequset:(id<SXHttpLoadDelegate>)sxHttpHandler {
    NSString* key = [sxHttpHandler hashKey];
    id<SXHttpLoadDelegate> obj = [self objectHttpLoadRequsetForKey:key];
    if (obj != nil) {
        return NO;
    }
    SLog(@"add：%@",sxHttpHandler);
    [self.dictionary setObject:sxHttpHandler forKey:key];
    SLog(@"current :%@",self.dictionary);
    return YES;
    
}

- (BOOL)removeHttpLoadRequset:(id<SXHttpLoadDelegate>)sxHttpHandler {
     NSString* key = [sxHttpHandler hashKey];
    id<SXHttpLoadDelegate> obj = [self objectHttpLoadRequsetForKey:key];
    if (obj == nil) {
        return NO;
    }
     SLog(@"remove：%@",sxHttpHandler);
    [self.dictionary removeObjectForKey:key];
     SLog(@"current :%@",self.dictionary);
    return YES;
}

- (__weak id<SXHttpLoadDelegate>)objectHttpLoadRequsetForKey:(id<NSCopying>)key {
    return [self.dictionary objectForKey:key];
}

@end
