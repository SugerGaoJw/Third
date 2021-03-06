//
//  SXHttpLoadDelegate.h
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXRespBodyDelegate.h"
#import "NSObject+Equal.h"


/*!--------------------------------------------------------------------
 *  @author Suger G, 15-10-01 16:10:52
 *
 *  定义请求类型枚举
 */
typedef NS_ENUM(NSInteger,EN_REQUEST_METHOD){
    /*!
     *  POST 请求枚举
     */
    EN_REQUEST_POST = 0,
    /*!
     *  GET 请求枚举
     */
    EN_REQUEST_GET,
    /*!
     *  PUT 请求枚举
     */
    EN_REQUEST_PUT,
    /*!
     *  DELETE 请求枚举
     */
    EN_REQUEST_DELETE,
    /*!
     *  支持多个文件上传，未知支持断点上传 ？？
     */
    EN_REQUEST_MUTLI_UPLOAD,
    /*!
     *  支持多个文件下载，支持断点续传
     */
    EN_REQUEST_MUTLI_DOWNLOAD,
    
    
    
};
/*!--------------------------------------------------------------------
 *  定义 wself
 *
 *  @param self
 */
#define gblWselfHeader \
__weak typeof(self) wself = self; \


/*!--------------------------------------------------------------------
 *  请求实体block定义
 *
 *  @param __blockName <#__blockName description#>
 */
#define gblHttpRequestHeader( __blockName )                               \
typedef void(^gbl##__blockName)(dispatch_block_t hiddenMBPblock);          \


/*!--------------------------------------------------------------------
 *  请求完成返回block
 *
 *  @param isRespError    <#isRespError description#>
 *  @param errDescription <#errDescription description#>
 *  @param resObject
 */
typedef void(^SXHttpRequestFinishBlock)(BOOL isRespError,
                                        NSString* errDescription,id resObject);


/*!--------------------------------------------------------------------
 *  请求失败返回block
 *
 *  @param isRespError    <#isRespError description#>
 *  @param errDescription <#errDescription description#>
 *  @param resObject
 */
typedef void(^SXHttpRequestFailedBlock)(BOOL isRespError,
                                        NSString* errDescription, id resObject);

/*!
 *  --------------------------------------------------------------------
 */

/*!
 *  请求过程返回block
 *
 *  @param doloadPercentage 下载百分比
 *  @param totalPercentage  总下载量
 *
 *  @return 是否停止请求过程
 */
typedef BOOL(^MutliDoloadingProgressBlock)(CGFloat doloadPercentage,CGFloat totalPercentage);
/*!
 *  --------------------------------------------------------------------
 */
@protocol SXHttpLoadDelegate <NSObject,ASIHTTPRequestDelegate>
@optional
//key
- (NSString *)hashKey;
//init
- (id<NSCopying>)createWithURL:(NSURL *)url BodyParams:(id<NSCopying>)bodyParams;
- (id<NSCopying>)createWithRequestHandlerArray:(NSArray * /*SXHttpLoadHandler*/)reqHandlers;

//callback
- (void)asiFetchFailed:(ASIHTTPRequest *)theRequest;
- (void)asiFetchFinish:(ASIHTTPRequest *)theRequest;
@end
