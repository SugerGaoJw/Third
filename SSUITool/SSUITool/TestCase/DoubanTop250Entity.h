//
//  DoubanTop250Entity.h
//  SSUITool
//
//  Created by suger on 15/10/13.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//
#import "SXReqBaseBody.h"
#import "SXRespBaseBody.h"
/*!
 *  豆瓣Top250请求类
 */
@interface DoubanTop250ReqEntity : SXReqBaseBody
NSCopy NSString* start;
NSCopy NSString* count;

@end

//评分
@interface MovieRating : NSObject
@property (copy,nonatomic) NSString *stars;
@property (copy,nonatomic) NSString *average;
@property (copy,nonatomic) NSString *min;
@property (copy,nonatomic) NSString *max;
@end

//封面
@interface CoverImages : NSObject
@property (copy,nonatomic) NSString *small;
@property (copy,nonatomic) NSString *large;
@property (copy,nonatomic) NSString *medium;
@end

//电影实体
@interface MovieEntity : NSObject
NSCopy NSString* title;
NSCopy NSString* year;
NSCopy NSString* name;
NSCopy NSString* movieId;
NSCopy NSString* original_title;
NSStrong NSArray* movieClassification; //电影分类
NSStrong CoverImages* coverImages; //电影封面
NSStrong MovieRating* movieRating; //电影评分
@end

/*!
 *   豆瓣Top250返回类
 */
@interface DoubanTop250RespEntity : SXRespBaseBody
NSStrong NSArray*  top250_list;

NSCopy NSString* title;
NSCopy NSString* count;
NSCopy NSString* start;
NSCopy NSString* total;


@end