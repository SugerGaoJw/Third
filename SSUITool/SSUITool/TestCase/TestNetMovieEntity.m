//
//  TestNetMovieEntity.m
//  SSUITool
//
//  Created by suger on 15/10/1.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "TestNetMovieEntity.h"

@implementation TestReqMovieEntity
/*!-------------------------------------------
 *  Defualt Value
 * -------------------------------------------
 */


- (NSDictionary *)toHeadDictionary {
    return @{@"apikey":@"65b63ad80ba20a49b82d81e287fe1a1e"};
}

- (NSString *)out_coord_type {
    return @"bd09ll";
}
- (NSString *)coord_type {
    return @"bd09ll";
}
- (NSString *)output {
    return @"json";
}
- (NSString *)rn {
    return @"15";
}

- (NSString *)getRespClassName {
    return NSStringFromClass([TestRespMovieEntity class]);
}
- (session *)session {
    return nil;
}
- (NSInteger)getReqMethod {
    //GET 请求方法
    return EN_REQUEST_GET;
}

@end


@implementation TestRespMovieEntity

@end