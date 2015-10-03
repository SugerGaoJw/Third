//
//  SXHttpLoadHandler.m
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXHttpLoadHandler.h"
#if  !S_RELEASE_VERSRION //DEBUG
#import "SXGETRequest.h"
#endif

@interface SXHttpLoadHandler(){
    __weak id _asiHttpRequestObject;
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
        mainDomin = @"http://apis.baidu.com/apistore/movie/cinema";
    }
#endif
    
    
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
    BOOL empty3 = [NSObject isEqualSrcObject:(id)reqBodyDic EnqualClass:[NSDictionary class]];
    
    if (  !empty3 || !empty2 || !empty1) {
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
    _asiHttpRequestObject = [self createWithURL:url BodyParams:bodyDic];
    if (_asiHttpRequestObject == nil) {
        SLog(@"_asiHttpRequestObject is nil ");
        [self sxCleanResource];
    }
    
    //如果是 ASIHTTPRequest 对象 设置头部请求参数 headDic 并且启动对象
    if ([_asiHttpRequestObject isKindOfClass:[ASIHTTPRequest class]]) {
        [self sxAppendRequset:_asiHttpRequestObject HeandParams:headDic];
        //开始异部请求
        [_asiHttpRequestObject setTimeOutSeconds:60.f];
        [_asiHttpRequestObject startAsynchronous];
    }
   
}

- (void)sxSetHttpLoadRequests:(NSArray *)reqArray {
    
    _asiHttpRequestObject = [self createWithURL:nil BodyParams:reqArray];
    if (_asiHttpRequestObject == nil) {
        [self sxCleanResource];
    }
    
}
/*!
 *  @author Suger G, 15-09-27 13:09:38
 *
 *  强制取消请求对象
 */
- (void)sxForceCancel {
    if ([_asiHttpRequestObject isMemberOfClass:[ASIHTTPRequest class]]) {
        ASIHTTPRequest* req = _asiHttpRequestObject;
        [req clearDelegatesAndCancel];
        
    }else if ([_asiHttpRequestObject isKindOfClass:[ASINetworkQueue class]]) {
        ASINetworkQueue* queue = _asiHttpRequestObject;
        [queue reset];
        
    }else{
        NSAssert(1 , @"_asiHttpRequestObject isn't ASIHTTPRequest or ASINetworkQueue");
    }
}
/*!
 *  @author Suger G, 15-09-27 13:09:06
 *
 *  清理请求完成后数据
 */
- (void)sxCleanResource {
    
    _asiHttpRequestObject = nil;
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
 *  网络请求失败之行
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
    SLog(@"%@",[respObject keyValues]);
    if (_finishBlock) _finishBlock(isRespError,description,respObject);
    [self sxCleanResource];
}


#pragma mark - SubObject Override
- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(id<NSCopying>)bodyParams {
    return nil;
}

- (id<NSCopying>)createMutliURL:(id<NSCopying>/* NSURL* */)urls BodyParams:(id<NSCopying>)bodyParams {
    return nil;
}
@end
