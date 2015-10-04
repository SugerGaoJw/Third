//
//  SXMutliDoLoadRequest.m
//  SSUITool
//
//  Created by suger on 15/10/3.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXMutliDoLoadRequest.h"

@interface SXMutliDoLoadRequest() {
    CGFloat _totalDoloadPercentage;
}
@end
@interface SXMutliDoLoadRequest()

@end

@implementation SXMutliDoLoadRequest
- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(id<NSCopying>)bodyParams {
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
    //如果链接发生重定向，开启
    [req setShouldUseRFC2616RedirectBehaviour:YES];
    //开启断点续传
    [req setAllowResumeForFileDownloads:YES];
    
    //开启下载精度反馈
    [req setDownloadProgressDelegate:self];
    [req setShowAccurateProgress:YES];
    
    //设置缓存策略
    ASIHTTPRequest* cache = [ASIDownloadCache sharedCache];
    [cache setCacheStoragePolicy:ASIAskServerIfModifiedCachePolicy];
    [req setDownloadCache:cache];
    [req setSecondsToCache:1.f];
    
    //设置下载地址
    NSString *path = [cache pathToCachedResponseDataForURL:url];
    [req setDownloadDestinationPath:path];
    return req;
}
#pragma mark - ASIHTTPRequestDelegate

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    //获取资源大小
    _totalDoloadPercentage = request.contentLength;
    SLog(@"Content-Length-%f",_totalDoloadPercentage);
    //获取文件
//    Content-Disposition
    NSString* fileName = [responseHeaders valueForKey:@"Content-Disposition"];
    SLog(@"Content-Disposition-%@",fileName);
}

- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes {
    //时时获取收到资源大小
    _doloadPercentage = _totalDoloadPercentage / bytes;
    SLog(@"didReceivePercentage is %.2f", _doloadPercentage);
}
@end
