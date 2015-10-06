//
//  SXQueueRequest.m
//  SSUITool
//
//  Created by suger on 15/10/5.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXQueueRequest.h"

@interface SXQueueRequest()
NSStrong ASINetworkQueue* networkQueue;
NSStrong NSMutableArray* queueArray;
/*
- (void)_cleanRequestResource:(SXHttpLoadHandler *)handlerRequest;
- (void)_handlerASIRequest:(ASIHTTPRequest *)theRequest;*/
- (__weak SXHttpLoadHandler *)_findRequestFormQueueArray:(ASIHTTPRequest *)theRequest;
- (void)_countRequestHandlerCallbak;

@end


@implementation SXQueueRequest
- (id<NSCopying>)createWithRequestHandlerArray:(NSArray * /*SXHttpLoadHandler*/)reqHandlers {
    
    //检查数组内的合法性
    __block BOOL valid = YES;
    gblWselfHeader;
    [reqHandlers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [NSObject isEqualSrcObject:obj EnqualClass:[SXHttpLoadHandler class]]) {
            *stop = YES ;valid = NO ; return ;
        }else{
            //拷贝 asiRquest 对象，放入请求队列中，丢弃当前的SXHttpLoadHandler 对象
            SXHttpLoadHandler* reqloadHandler = (SXHttpLoadHandler*)obj;
            ASIHTTPRequest* asiRequestHandler = [[reqloadHandler asiRquest] copy];
            if (asiRequestHandler == nil) {
                
                *stop = YES ;valid = NO ; return ;
                
            }else{
                [wself.networkQueue addOperation:asiRequestHandler];
            }
        }
        
        
        
    }];
    
    if (valid == NO) {
        SLog(@"Array is inValid !");
        return nil;
    }
    
    _queueArray = reqHandlers.mutableCopy;
    [wself.networkQueue go];
    return wself.networkQueue;
}


- (ASINetworkQueue *)networkQueue {
    
    if (_networkQueue == nil) {
        _networkQueue = [[ASINetworkQueue alloc]init];
        [_networkQueue reset];
        
        [_networkQueue setDelegate:self];
        [_networkQueue setShowAccurateProgress:YES];
        [_networkQueue setDownloadProgressDelegate:self];
        
        
        [_networkQueue setRequestDidFinishSelector:@selector(asiFetchFinish:)];
        [_networkQueue setRequestDidFailSelector:@selector(asiFetchFailed:)];
        
        
    }
    return _networkQueue;
}


- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes {
    SLog(@"Receive %lld",bytes);
}

- (void)asiFetchFailed:(ASIHTTPRequest *)theRequest {
    SLog(@"%@",theRequest);
    NSInteger code = [[theRequest error] code];
    
    SXHttpLoadManager* manager = [SXHttpLoadManager shareInstance];
    NSString*  description = [manager getErrDescriptionByKey:code];
    SLog(@"failed code is %ld , description is %@",(long)code,description);

    SXHttpLoadHandler* handlerRequest = [self _findRequestFormQueueArray:theRequest];
    if (_finishBlock ) {
        _finishBlock(YES,description,handlerRequest);
    }
    
    [self _countRequestHandlerCallbak];

}

- (void)asiFetchFinish:(ASIHTTPRequest *)theRequest {
    SLog(@"%@",theRequest);
    SXHttpLoadHandler* handlerRequest = [self _findRequestFormQueueArray:theRequest];
    if (_finishBlock ) {
        _finishBlock(NO,nil,handlerRequest);
    }
    [self _countRequestHandlerCallbak];
}

/*
#pragma mark - 私有方法
- (void)_handlerASIRequest:(ASIHTTPRequest *)theRequest {
    SXHttpLoadHandler* handlerRequest = [self _findRequestFormQueueArray:theRequest];
    if (_finishBlock ) {
        _finishBlock(NO,nil,handlerRequest);
    }
}

- (void)_cleanRequestResource:(SXHttpLoadHandler *)handlerRequest {
    [handlerRequest sxCleanResource];
}
*/

- (__weak SXHttpLoadHandler *)_findRequestFormQueueArray:(ASIHTTPRequest *)theRequest {
    __block SXHttpLoadHandler* handlerRequest = nil;
    
    [_queueArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        handlerRequest = (SXHttpLoadHandler *)obj;
        if ([[[[handlerRequest asiRquest] url] absoluteString] isEqualToString:[[theRequest url] absoluteString]]) {
            handlerRequest = obj;
            *stop = YES;
        }
    }];
    
    NSAssert(handlerRequest != nil, @"_findRequestFormQueueArray is falid");
    [[handlerRequest asiRquest]clearDelegatesAndCancel];
    return handlerRequest;
}

- (void)_countRequestHandlerCallbak {
    
    _reqHandlerCount = _reqHandlerCount +  1;
    if (_reqHandlerCount >= _queueArray.count) {
        SLog(@"clean queue resource !");
        [self sxCleanResource];
        
    }
    
}

@synthesize finishBlock = _finishBlock;
@synthesize failedBlock = _failedBlock;
@synthesize doloadProgressBlock = _doloadProgressBlock;

@end
