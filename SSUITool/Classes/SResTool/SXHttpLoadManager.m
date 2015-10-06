//
//  SXHttpLoadManager.m
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXHttpLoadManager.h"
#import "SXQueueRequest.h"
#import "SXReqBaseBody.h"

@interface SXHttpLoadManager()
NSStrong NSMutableDictionary* dictionary;

NSStrong ASINetworkQueue* networkQueue;

- (__weak SXHttpLoadHandler *)pdtRequestWithBody:(id<SXReqBodyDelegate>)reqBody
                           onDoloadProgressBlock:(MutliDoloadingProgressBlock)_doloadProgressBlock
                                   onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
                                    onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock;
+ (void)cfgASIRequestResourceCache;
@end

static SXHttpLoadManager* instance = nil;
@implementation SXHttpLoadManager
+ (SXHttpLoadManager *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SXHttpLoadManager alloc]init];
        //Config ASIHttpRequest Download Request Cache
        [SXHttpLoadManager cfgASIRequestResourceCache];
    });
    return instance;
}

- (NSMutableDictionary *)dictionary {
    if (_dictionary == nil) {
        _dictionary = [[NSMutableDictionary alloc]init];
    }
    return _dictionary;
}

- (NSString *)mainReqURL {
    /*!
     *  eg.url 请求地址切换
     */
    
    return _mainReqURL;
}

- ( ASINetworkQueue *)networkQueue {
    
    if (_networkQueue == nil) {
        _networkQueue = [[ASINetworkQueue alloc]init];
        [_networkQueue setMaxConcurrentOperationCount:5];
    }
    return _networkQueue;
}

#pragma mark -- Create
- (__weak SXHttpLoadHandler *)pdtRequestWithBody:(id<SXReqBodyDelegate>)reqBody
                           onDoloadProgressBlock:(MutliDoloadingProgressBlock)_doloadProgressBlock
                                   onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
                                    onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock {
    //根据 EN_REQUEST_METHOD 请求方法实例相对应的请求实体类
    EN_REQUEST_METHOD enReqMethod = [reqBody getReqMethod];
    SXHttpLoadHandler* reqHandler = [SXHttpLoadHandler pdtHttpRequestByEnum:enReqMethod];
    
    //配置请求实例对象的属性
    [reqHandler sxReqBody:reqBody];
    reqHandler.finishBlock = _finishBlock;
    reqHandler.failedBlock = _failedBlock;
    
    //如果有 _doloadProgressBlock 则必须是 EN_REQUEST_MUTLI_DOWNLOAD | EN_REQUEST_MUTLI_UPLOAD 枚举
    if (_doloadProgressBlock) {
        NSAssert(enReqMethod == EN_REQUEST_MUTLI_DOWNLOAD
                 || enReqMethod  == EN_REQUEST_MUTLI_UPLOAD ,
                 @"Current EN_REQUEST_METHOD is don't supported Doloading ProgressBlock ");
        reqHandler.doloadProgressBlock = _doloadProgressBlock;
    }
    
    return reqHandler;
}

- (__weak id<SXHttpLoadDelegate>)requestAtBody:(id<SXReqBodyDelegate>)reqBody
                         onDoloadProgressBlock:(MutliDoloadingProgressBlock)_doloadProgressBlock
                                 onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
                                  onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock {
    
    if (reqBody == nil || _finishBlock == nil || _failedBlock == nil) {
        SLog(@"reqNetSeverAppend Error");
        return nil;
    }
    //根据配置request body 生成 SXHttpLoadHandler 对象
    SXHttpLoadHandler* reqHandler = [self pdtRequestWithBody:reqBody
                                       onDoloadProgressBlock:_doloadProgressBlock
                                               onFinishBlock:_finishBlock
                                                onFiledBlock:_failedBlock];
    //放入请求字典内，以便管理
    [self addHttpLoadRequset:reqHandler];
    return reqHandler;
    
}
- (__weak id<SXHttpLoadDelegate> )requestAtBody:(id<SXReqBodyDelegate>)reqBody
                                  onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
                                   onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock {
    
    return [self requestAtBody:reqBody onDoloadProgressBlock:nil
                 onFinishBlock:_finishBlock
                  onFiledBlock:_failedBlock];
}

- (__weak id<SXHttpLoadDelegate>)requestAtBodyArray:(NSArray * /*SXReqBaseBody */)reqBodys
                                  withCleanMBPBlock:(dispatch_block_t)_cleanMBPblock 
                              onDoloadProgressBlock:(MutliDoloadingProgressBlock)_doloadProgressBlock
                                      onFinishBlock:(SXHttpRequestFinishBlock)_finishBlock
                                       onFiledBlock:(SXHttpRequestFailedBlock)_failedBlock {
    
    gblWselfHeader;
    __block BOOL valid = YES;
    __block SXHttpLoadHandler* reqHandler = nil;
    
    
     NSMutableArray* _reqHandlerArray =  [[NSMutableArray alloc]init];
    
    [reqBodys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //判断当前的传入参数
        if (NO == [NSObject isEqualSrcObject:obj EnqualClass:[SXReqBaseBody class]]) {
            
            *stop = YES;valid = NO; SLog(@"for SXReqBaseBody is falid") return ;
      
        }else{
            //根据 SXReqBaseBody 对象生成 SXHttpLoadHandler
            reqHandler = [wself pdtRequestWithBody:obj onDoloadProgressBlock:nil
                                     onFinishBlock:nil onFiledBlock:nil];
            
            if (reqHandler == nil) {
                
                *stop = YES; valid = NO;SLog(@"for SXHttpLoadHandler is falid");
            
            }else{
                //拷贝进度回调block
                reqHandler.doloadProgressBlock = _doloadProgressBlock;
                [_reqHandlerArray addObject:reqHandler];
            }
        }
    }];
    
    if (_reqHandlerArray.count <= 0 || valid == NO ) {
        SLog(@"requestAtBodyArray is falid");
        return nil;
    }
    
    SXQueueRequest* queueHandler = [[SXQueueRequest alloc]init];
   id rlsObject =  [queueHandler createWithRequestHandlerArray:_reqHandlerArray];
    if (rlsObject == nil) {
        SLog(@"createWithRequestHandlerArray is falid");
        return nil;
    }
    
    queueHandler.finishBlock = _finishBlock;
    queueHandler.failedBlock = _failedBlock;
    queueHandler.cleanMBPblock = _cleanMBPblock;
    
    //放入请求字典内，以便管理
    [self addHttpLoadRequset:queueHandler];
    return reqHandler;
    
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
                           @(ASICompressionError):@"网络请求不稳定，请稍后再试",
                           @(ASIDoloadCompletedType):@"亲，下载完成"};
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

#pragma mark - ASIHTTPRequest Cache
+ (void)cfgASIRequestResourceCache {
    ASIDownloadCache* cache = [ASIDownloadCache sharedCache];
    
    //设置缓存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [[paths firstObject] stringByAppendingPathComponent:@"com.asihttprequest.file.cache"];
    SLog(@"cache path is %@",documentDirectory);
    [cache setStoragePath:documentDirectory];
    [cache setDefaultCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    
}
@end
