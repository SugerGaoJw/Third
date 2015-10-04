//
//  NSObject+Equal.m
//  SSUITool
//
//  Created by suger on 15/10/3.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "NSObject+Equal.h"

@implementation NSObject (Equal)

#pragma mark - 判断是否是指定类型
+ (BOOL)isEqualSrcObject:(id)srcObject EnqualClass:(Class)equalClass {
    
    if ([srcObject isKindOfClass:[NSNull class]] || srcObject == nil) {
        return NO;
    }
    
    return [srcObject isKindOfClass:equalClass];
}

#pragma mark -  判断是否实现指定方法
+ (BOOL)isDelegate:(id)delegate forImplementdSelector:(SEL)aSelector {
    
    if (delegate && [delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return NO;
}

@end
