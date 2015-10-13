//
//  DoubanTop250Entity.m
//  SSUITool
//
//  Created by suger on 15/10/13.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "DoubanTop250Entity.h"

@implementation DoubanTop250ReqEntity
- (NSString *)getRespClassName {
    return NSStringFromClass([DoubanTop250RespEntity class]);
}

- (session *)session {
    return nil;
}
- (NSString *)count {
    return @"10";
}
- (NSString *)getReqURLMainDomin {
    return @"https://api.douban.com/v2/movie/top250";
}

- (NSInteger)getReqMethod {
    //GET 请求方法
    return EN_REQUEST_GET;
}
@end



@implementation DoubanTop250RespEntity
- (id<SXRespBodyDelegate>)toEntityWithValues:(id)values {
    /*!
     * eg.生成实体策略
     */
    
    // Tell MJExtension what type model will be contained
    [MovieEntity setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"coverImages": @"images",
                 @"movieRating": @"rating",
                 @"movieId":@"id"};
    }];
    
    [DoubanTop250RespEntity setupObjectClassInArray:^NSDictionary *{
        return @{@"top250_list" : @"MovieEntity"};
    }];
    
    [DoubanTop250RespEntity setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top250_list": @"subjects"};
    }];
    
    return [DoubanTop250RespEntity objectWithKeyValues:values];
    
    
    
}
@end

@implementation MovieRating
@end

@implementation CoverImages
@end

@implementation MovieEntity
@end