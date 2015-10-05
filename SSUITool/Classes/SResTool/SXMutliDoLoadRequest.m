//
//  SXMutliDoLoadRequest.m
//  SSUITool
//
//  Created by suger on 15/10/3.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXMutliDoLoadRequest.h"
#import "SXMutliStatusMachine.h"

@interface SXMutliDoLoadRequest() {
    CGFloat _totalDoloadPercentage;
    CGFloat _currentDoloadPercentage;
    SXMutliStatusMachine* _machine;
}
- (void)_initProperty;
@end


@implementation SXMutliDoLoadRequest

- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(id<NSCopying>)bodyParams {
    //set req body
    if (![NSObject isEqualSrcObject:(id)url EnqualClass:[NSURL class]]) {
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
    [self _initProperty];
    
    // 生成 ASIHTTPRequest 对象
    ASIHTTPRequest* req = [ASIHTTPRequest requestWithURL:reqURL];
    [req setDelegate: self];
    //注册父类的成功方法为回调方法
    [req setDidFinishSelector:@selector(asiFetchFinish:)];
    //注册父类的失败方法为回调方法
    [req setDidFailSelector:@selector(asiFetchFailed:)];
//    //如果链接发生重定向，开启
    [req setShouldUseRFC2616RedirectBehaviour:YES];
    //开启断点续传
    [req setAllowResumeForFileDownloads:YES];
    
    //开启下载精度反馈
    [req setDownloadProgressDelegate:self];
    [req setShowAccurateProgress:YES];
    
    //设置缓存策略
    ASIDownloadCache* cache = [ASIDownloadCache sharedCache];
    // Note: we are forcing it to perform a conditional GET
    [req setCachePolicy:ASIAskServerIfModifiedCachePolicy];
    [req setDownloadCache:cache];
//    [req setSecondsToCache:1.f];

    
    //设置下载地址
    NSString *path = [cache pathToDoloadDestinationCachedForURL:url];
    if (path != nil) [req setDownloadDestinationPath:path];
    
    //设置machine 状态
    [_machine stlMachineForStatus:ENPreparedStatus];
    return req;
}
#pragma mark - 私有函数
- (void)_initProperty {
    
    _doloadPercentage = 0.f;
    _totalDoloadPercentage = 0.f;
    _currentDoloadPercentage = 0.f;
    
    _machine = [[SXMutliStatusMachine alloc]initWithDelegate:self];
}

#pragma mark - ASIHTTPRequestDelegate
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL {
    [request clearDelegatesAndCancel];
    
    
     //重新实例 ASIHTTPRequest 对象
    ASIHTTPRequest* newReq = (ASIHTTPRequest *)[self createWithURL:newURL BodyParams:nil];
    [newReq setTimeOutSeconds:60];
    [newReq startAsynchronous];
   

}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    //获取资源大小
    _totalDoloadPercentage = request.contentLength;
    
    SLog(@"Content-Length-%f",_totalDoloadPercentage);
    //获取文件
//    Content-Disposition
    NSString* fileName = [responseHeaders valueForKey:@"Content-Disposition"];
    SLog(@"Content-Disposition-%@",fileName);
}

- (void)asiFetchFailed:(ASIHTTPRequest *)theRequest {
    [super asiFetchFailed:theRequest];
    [_machine stlMachineForStatus:ENFinishedStatus];
    
}

- (void)asiFetchFinish:(ASIHTTPRequest *)theRequest {
    [super asiFetchFinish:theRequest];
    [_machine stlMachineForStatus:ENFinishedStatus];
}


- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes {
    //时时获取收到资源大小
    _currentDoloadPercentage = _currentDoloadPercentage + bytes;
    _doloadPercentage = _currentDoloadPercentage / _totalDoloadPercentage;
    SLog(@"didReceivePercentage is %.2f", _doloadPercentage);
    
    //判断下载状态
    if (_doloadProgressBlock) {
        BOOL isDoloadStop =  _doloadProgressBlock(_doloadPercentage,_totalDoloadPercentage);
        if (isDoloadStop) {
            [_machine stlMachineForStatus:ENStopedStatus];
        }else{
            [_machine stlMachineForStatus:ENDoloadingStatus];
        }
    }
}

#pragma mark - SXMutliStatusMachineDelegate
- (void)callBakPreparedMutliStatus {
    
}

- (void)callBakStopedMutliStatus {
    [super sxCleanResource];
    _doloadProgressBlock = nil;
}

- (void)callBakDoloadingMutliStatus {
    
}

- (void)callBakFinishedMutliStatus {
    _doloadProgressBlock = nil;
}


@synthesize doloadPercentage = _doloadPercentage;
@synthesize doloadProgressBlock = _doloadProgressBlock;
@end
