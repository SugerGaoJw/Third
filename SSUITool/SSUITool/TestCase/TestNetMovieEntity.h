//
//  TestNetMovieEntity.h
//  SSUITool
//
//  Created by suger on 15/10/1.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXReqBaseBody.h"
#import "SXRespBaseBody.h"
@interface TestReqMovieEntity : SXReqBaseBody
/*
 wd
 string	是	urlParam
 输入影院名称或影院uid，例如：华星、万达
 华星
 location
 string	是	urlParam
 输入城市名或经纬度，城市名称如:北京或者131，经纬度格式为lng,lat坐标如: location=116.305145,39.982368。
 北京
 rn
 string	否	urlParam
 单页上所获取的数据的数目，默认为10条数据，单页最多可输出20条数据。
 15
 output
 string	否	urlParam
 输出的数据格式，默认为xml格式，当output设置为’json’时，输出的为json格式的数据。
 json
 coord_type
 string	否	urlParam
 请求参数坐标类型，默认为gcj02经纬度坐标。允许的值为bd09ll、bd09mc、gcj02、wgs84。 bd09ll表示百度经纬度坐标，bd09mc表示百度墨卡托坐标，gcj02表示经过国测局加密的坐标。wgs84表示gps获取的坐标。
 bd09ll
 out_coord_type
 string	否	urlParam
 返回结果输出时的坐标类型，默认为gcj02经纬度坐标。允许的值为bd09ll、bd09mc、gcj02。bd09ll表示百度经纬度坐标，bd09mc表示百度墨卡托坐标，gcj02表示经过国测局加密的坐标。
 bd09ll
 */

NSCopy NSString* wd;
NSCopy NSString* location;
NSCopy NSString* rn;
NSCopy NSString* output;
NSCopy NSString* coord_type;
NSCopy NSString* out_coord_type;
@end

@interface TestRespMovieEntity : SXRespBaseBody

@end
