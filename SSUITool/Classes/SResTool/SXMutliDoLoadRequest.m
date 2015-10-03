//
//  SXMutliDoLoadRequest.m
//  SSUITool
//
//  Created by suger on 15/10/3.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXMutliDoLoadRequest.h"

@implementation SXMutliDoLoadRequest
- (id<NSCopying>)createMutliURL:(NSArray *)urls BodyParams:(NSDictionary *)bodyParams {
    
    BOOL empty = [NSObject isEqualSrcObject:(id)urls EnqualClass:[NSArray class]];
    if (empty == NO) {
        return nil;
    }
    return nil;
}
@end
