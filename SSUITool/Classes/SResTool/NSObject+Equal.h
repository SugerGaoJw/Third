//
//  NSObject+Equal.h
//  SSUITool
//
//  Created by suger on 15/10/3.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Equal)
#pragma mark - 判断是否是指定类型
/*!
 *  @author Suger G, 15-10-03 07:10:58
 *
 *  判断对象是否存在 并是否是指定对象，
 *
 *  @param srcObject  <#srcObject description#>
 *  @param equalClass <#equalClass description#>
 *
 *  @return 判断是否成功
 */
+ (BOOL)isEqualSrcObject:(id)srcObject EnqualClass:(Class)equalClass;
@end
