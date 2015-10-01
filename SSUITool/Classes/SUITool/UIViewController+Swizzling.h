//
//  UIViewController+Swizzling.h
//  SSUITool
//
//  Created by Suger on 15/8/29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Swizzling)
/*!
 *  swizzling
 *
 *  @param sMethodSel <#sMethodSel description#>
 *  @param oMethodSel <#oMethodSel description#>
 */
+(void)swizzledMethodSel:(SEL)sMethodSel OriginaledMethodSel:(SEL)oMethodSel;
@end
