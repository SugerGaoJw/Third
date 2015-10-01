//
//  TestNetAdrEntity.m
//  SSUITool
//
//  Created by Suger on 15/8/31.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "TestNetAdrEntity.h"

@implementation TestReqAdrEntity
/*!
 *  设置相关参数
 */


- (NSString *) a {
    //关联请求放入post 请求体内的参数
    return @"list";
}
- (NSString * )getRespClassName {
    
    //关联返回类型
    return  NSStringFromClass([TestRespAdrEntity class]);
}

- (NSString * )getReqURLSuffix {
    //关联请求后缀 URI
    return @"user_address";
}


@end

@implementation TestRespAdrEntity
- (id<SXRespBodyDelegate>)toEntityWithValues:(id)values {
    /*!
     * eg.生成实体策略
     */
    
    // Tell MJExtension what type model will be contained
    [AdrDetialInfo setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"adrId" : @"id"};
    }];
    
    [TestRespAdrEntity setupObjectClassInArray:^NSDictionary *{
        return @{@"adr_list" : @"AdrDetialInfo"};
    }];
    
    [TestRespAdrEntity setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"adr_list": @"data"};
    }];
    
    return [TestRespAdrEntity objectWithKeyValues:values];
}

@end

@implementation TestLoginSeesion

- (id<SXRespBodyDelegate>)toEntityWithValues:(id)values {
    /*!
     * eg.生成实体策略
     */
    [TestLoginSeesion setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"loginSesion": @"loginJson"};
    }];
    
    return [TestLoginSeesion objectWithKeyValues:values];
}

@end

@implementation LoginSeesion
@end



@implementation AdrDetialInfo

@end