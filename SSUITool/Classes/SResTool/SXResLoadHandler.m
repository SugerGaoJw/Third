//
//  SXResLoadHandler.m
//  SSUITool
//
//  Created by Suger on 15/8/29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "SXResLoadHandler.h"
static SXResLoadHandler* instance = nil;
@interface SXResLoadHandler()
NSStrong NSMutableDictionary* resDictionary;
@end

@implementation SXResLoadHandler
+(SXResLoadHandler *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SXResLoadHandler alloc]init];
    });
    
//    NSAssert(instance == nil, @"SXResLoadHandler load failed !");
    return instance;
}

-(__weak NSMutableDictionary *)getAllXResource {
    NSMutableDictionary* copyDic = [self.resDictionary copy];
    SLog(@"copy dictionary is :%@",copyDic);
    return copyDic;
}

- (__weak id<NSCopying>)getXResourceByKey:(id<NSCopying>)key {
    id obj = [self.resDictionary objectForKey:key];
    if (obj == nil) {
        SLog(@"find key is :%@ not exist",key);
        return nil;
    }
    id<NSCopying> copyObj = [obj copy];
//    SLog(@"get resource :%@ for key :%@",copyObj , key);
    return copyObj;
}

- (BOOL)setXResouce:(id<NSCopying>)resource forKey:(id<NSCopying>)key {
    if (key == nil || resource == nil) {
        SLog(@"key == nil or resource == nil");
        return  NO;
    }
    [self.resDictionary setObject:resource forKey:key];
    SLog(@"set resource :%@ for key :%@",resource , key);
    return YES;
}

- (void)cleanAllXResource {
    SLog(@"clean dictionary is :%@",self.resDictionary);
    [self.resDictionary removeAllObjects];
}

- (BOOL)cleanXResourceWithKey:(id<NSCopying>)key {
    if (key == nil ) {
        SLog(@"key == nil");
        return  NO;
    }
    
    id<NSCopying> obj = [self.resDictionary objectForKey:key];
    if (obj == nil) {
        SLog(@"clean key is :%@ not exist",key);
        return NO;
    }
    
    [self.resDictionary removeObjectForKey:key];
    SLog(@"clean resource :%@ for key :%@",obj , key);
    return YES;
}

- (NSMutableDictionary *)resDictionary {
    if (_resDictionary == nil) {
        _resDictionary = [[NSMutableDictionary alloc]initWithCapacity:10];
    }
    return _resDictionary;
}
@end
