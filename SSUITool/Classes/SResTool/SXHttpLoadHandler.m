//
//  SXHttpLoadHandler.m
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXHttpLoadHandler.h"

#import "SXPOSTRequest.h"
#import "SXGETRequest.h"
#import "SXMutliDoLoadRequest.h"
#import "SXQueueRequest.h"


@interface SXHttpLoadHandler(){
    __weak ASIHTTPRequest* _asiRquest;
    NSString* _hashKey;
}
- (void)sxfetchURL:(NSURL *)url
    withReqHeadDic:(NSDictionary *)headDic
     andReqBodyDic:(NSDictionary *)bodyDic;


- (void)sxAppendRequset:(ASIHTTPRequest *)request
            HeandParams:(NSDictionary *)headParams;

@end

@implementation SXHttpLoadHandler
#pragma mark - Life
- (void)dealloc {
    SLogNil;
}

#pragma mark - Publice
- (void)sxReqBody:(id<SXReqBodyDelegate>)reqBody {
    
    NSString* mainDomin = [[SXHttpLoadManager shareInstance]mainReqURL];

#if  !S_RELEASE_VERSRION //DEBUG
    if ([self isKindOfClass:[SXGETRequest class]]) {
        mainDomin = [reqBody getReqURLMainDomin];
    }
#endif
    //因为下载地址是可变的。所以需要获取当前的配置地址
    if ([self isKindOfClass:[SXMutliDoLoadRequest class]]) {
        
        mainDomin = [reqBody getReqURLMainDomin];
        if (NO == [NSObject isEqualSrcObject:(id)mainDomin EnqualClass:[NSString class]]) {
            NSAssert(0, @"doload path is invalid !");
        }
    }
    
    NSString* url = mainDomin;
    if ([reqBody getReqURLSuffix].length > 0) {
        url =  [NSString stringWithFormat:@"%@%@",mainDomin,[reqBody getReqURLSuffix]];
    }
    SLog(@"------------- Request Begin -------------");
    SLog(@"%@",url);
    
    //获取反射类 以及 清理MBP block 
    _respClassName = [reqBody getRespClassName];
    _cleanMBPblock = [reqBody getCleanMBPBlock];
    _hashKey = nil;
    
    //获取 请求URL 请求的头部参数 以及 请求的体信息
    NSURL* reqURL = [NSURL URLWithString:url];
    NSDictionary* reqBodyDic = [reqBody toBodyDictionary];
    NSDictionary* reqHeadDic = [reqBody toHeadDictionary];
    
    BOOL empty1 = [NSObject isEqualSrcObject:(id)_respClassName EnqualClass:[NSString class]];
    BOOL empty2 = [NSObject isEqualSrcObject:(id)reqURL EnqualClass:[NSURL class]];
    
    if (  !empty2 || !empty1) {
        SLog(@" empty3 || empty2 || empty1 check value is Failed");
        return ;
    }
    
    [self sxfetchURL:reqURL withReqHeadDic:reqHeadDic andReqBodyDic:reqBodyDic];
}

/*!
 *  @author Suger G, 15-09-27 13:09:53
 *
 *  初始请求对象，并且保存当前请求对象
 */
- (void)sxfetchURL:(NSURL *)url withReqHeadDic:(NSDictionary *)headDic
     andReqBodyDic:(NSDictionary *)bodyDic {
    
    //调用子类的 -createWithURL:BodyParams: 方法
    //传入只有 bodyDic 参数，headDic 参数在外面生成
    _asiRquest = (ASIHTTPRequest *)[self createWithURL:url BodyParams:bodyDic];
    if (_asiRquest == nil) {
        SLog(@"_asiHttpRequestObject is nil ");
        [self sxCleanResource];
    }
    
    //如果是 ASIHTTPRequest 对象 设置头部请求参数 headDic 并且启动对象
    if ([NSObject isEqualSrcObject:(id)_asiRquest EnqualClass:[ASIHTTPRequest class]]) {
       
        ASIHTTPRequest* req = _asiRquest;
        
        //设置头部信息
        [self sxAppendRequset:req HeandParams:headDic];
        //开始异部请求,设置超时时间 60.f ,设置缓存
        [req setTimeOutSeconds:60.f];
        
        //如果 cache 未设置，则设置 cache
        if ([req downloadCache] == nil) {
            [req setDownloadCache:[ASIDownloadCache sharedCache]];
            [req setCachePolicy:ASIAskServerIfModifiedCachePolicy];
        }
        
        [req startAsynchronous];
    }
   
}

/*!
 *  @author Suger G, 15-09-27 13:09:38
 *
 *  强制取消请求对象
 */
- (void)sxForceCancel {
    
    if ([_asiRquest isMemberOfClass:[ASIHTTPRequest class]]) {
        ASIHTTPRequest* req = _asiRquest;
        [req clearDelegatesAndCancel];
        
    }else if ([_asiRquest isKindOfClass:[ASINetworkQueue class]]) {
        ASINetworkQueue* queue = (ASINetworkQueue *)_asiRquest;
        [queue reset];
        
    }else{
        NSAssert(0 , @"_asiHttpRequestObject isn't ASIHTTPRequest or ASINetworkQueue");
    }
}
/*!
 *  @author Suger G, 15-09-27 13:09:06
 *
 *  清理请求完成后数据
 */
- (void)sxCleanResource {
    
    _asiRquest = nil;
    _finishBlock = nil;
    _failedBlock = nil;
    _respClassName = nil;
    if (_cleanMBPblock) {
        _cleanMBPblock();_cleanMBPblock = nil;
    }
    [[SXHttpLoadManager shareInstance]removeHttpLoadRequset:self];
}



#pragma mark - NSObject Help
- (void)sxAppendRequset:(ASIHTTPRequest *)request
            HeandParams:(NSDictionary *)headParams {
    
  [headParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
      if (![key isKindOfClass:[NSString class]] || ![obj isKindOfClass:[NSString class]]) {
          *stop = YES;
      
      }else{
          
          SLog(@"append head [key is %@ value is %@]", key ,obj);
          [request addRequestHeader:key value:obj];
      }
  }];
}

- (instancetype)initWithClassName:(NSString *)className
{
    //create class
    Class kclass = objc_getClass([className UTF8String]);
    if (!kclass) {
        
        Class classObject = [NSObject class];
        kclass = objc_allocateClassPair(classObject, [className UTF8String], 0);
    }
    
    //实例化
    return [[kclass alloc]init];
}
#pragma mark - SXHttpLoadDelegate
- (NSString *)hashKey {
    
    if (_hashKey == nil) {
        _hashKey = [NSString stringWithFormat:@"%ld",(unsigned long)self.hash];
    }
    return _hashKey;
}

/**
 *  网络请求失败执行
 */
- (void)asiFetchFailed:(ASIHTTPRequest *)theRequest{
    
    BOOL isRespError = YES;
    NSInteger code = [[theRequest error] code];
    
    /*if ( code != ASIRequestCancelledErrorType ||
        [[theRequest error] domain] != NetworkRequestErrorDomain) {
        
        isRespError = YES;
    }*/
    
    SXHttpLoadManager* manager = [SXHttpLoadManager shareInstance];
    NSString*  description = [manager getErrDescriptionByKey:code];
    SLog(@"failed code is %ld , description is %@",(long)code,description);
    if (_failedBlock) _failedBlock(isRespError,description, theRequest);
    [self sxCleanResource];
}
/**
 *  网络请求完成执行
 */
- (void)asiFetchFinish:(ASIHTTPRequest *)theRequest {
    
    __block BOOL isRespError = NO;
    __block NSString*  description = nil;
    id respObject = nil;
    SXHttpLoadManager* manager = [SXHttpLoadManager shareInstance];
    
    
    
    //定义 失败处理block
    dispatch_block_t _failedHandlerBlock = ^(void) {
        isRespError = YES;
        description = [manager getErrDescriptionByKey:ASIUnhandledExceptionError];
    };
    
    
    //parse respond object
    id obj = [ASIJSONTool toJSONData:[theRequest responseData] ];
    if (![NSObject isEqualSrcObject:obj EnqualClass:[NSObject class]]) {
        
        _failedHandlerBlock();
        
    }else {
        //根据反射对象，实例化相对应对象
        id<SXRespBodyDelegate> respBody = [self initWithClassName:_respClassName];
        if ([respBody respondsToSelector:@selector(toEntityWithValues:)]) {
            
            respObject = [respBody toEntityWithValues:obj];
            
        }else{
            //实例失败，报错
            _failedHandlerBlock();
        }

    }
    //如果断点续传
    if ([self isKindOfClass:[SXMutliDoLoadRequest class]]
        || [self isKindOfClass:[SXQueueRequest class]]) {
        
        isRespError = NO;
        description = [manager getErrDescriptionByKey:ASIDoloadCompletedType];
        respObject = theRequest;
    
    }else{
        
        SLog(@"%@",[respObject keyValues]);
    }
    
    
    if (_finishBlock) _finishBlock(isRespError,description,respObject);
    [self sxCleanResource];
}

- ( NSString *)pdtURLSuffixByParams:(id ) params  {
    
    NSDictionary* dic = nil;
    if (![NSObject isEqualSrcObject:params EnqualClass:[NSDictionary class]]) {
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

+ (SXHttpLoadHandler *)pdtHttpRequestByEnum:(EN_REQUEST_METHOD)enReqMethod {
    SXHttpLoadHandler* httpLoadHander = nil;
    switch (enReqMethod) {
        case EN_REQUEST_POST:
            SLog(@"EN_REQUEST_POST");
            httpLoadHander = [[SXPOSTRequest alloc]init]; break;
        case EN_REQUEST_GET:
            SLog(@"EN_REQUEST_GET");
            httpLoadHander = [[SXGETRequest alloc]init];break;
        case EN_REQUEST_MUTLI_DOWNLOAD:
            SLog(@"EN_REQUEST_MUTLI_DOWNLOAD");
            httpLoadHander = [SXMutliDoLoadRequest alloc]; break;
        default:
            break;
    }
    return httpLoadHander;
}

#pragma mark - SubObject Override
- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(id<NSCopying>)bodyParams {
    return nil;
}

- (id<NSCopying>)createWithRequestHandlerArray:(NSArray *)reqHandlers {
    return nil;
}
@synthesize asiRquest = _asiRquest;
@end
