//
//  UIViewController+Swizzling.m
//  SSUITool
//
//  Created by Suger on 15/8/29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzling)
+(void)swizzledMethodSel:(SEL)sMethodSel OriginaledMethodSel:(SEL)oMethodSel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL swizzledSelector = sMethodSel;
        SEL originalSelector = oMethodSel;
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

@end
