//
//  SXMutliDoLoadStatus.m
//  SSUITool
//
//  Created by suger on 15/10/4.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SXMutliStatusMachine.h"
@interface SXMutliStatusMachine () {
    
    __weak id<SXMutliStatusMachineDelegate> _sDelegate;
    ENMutliDoloadStatus _enStatus;
}
- (BOOL)_checkSDelegateMethod:(SEL)aSelector;
@end

@implementation SXMutliStatusMachine
- (instancetype)initWithDelegate:(id)sDelegate {
    if (self = [super init]) {
        // weak reference to delegate object
        _sDelegate = sDelegate;
        // seting statue ENUNKownStatus
        _enStatus = ENUNKownStatus;
    }
    return self;
}
- (void)stlMachineForStatus:(ENMutliDoloadStatus)enStatus {
    if (_enStatus == enStatus) {
        return;
    }
    _enStatus = enStatus;
    SEL aSel = nil;
    switch (_enStatus) {
        case ENPreparedStatus:{
            
            aSel = @selector(callBakPreparedMutliStatus);
            if ([self _checkSDelegateMethod:aSel]) {
                [_sDelegate callBakPreparedMutliStatus];
            }else{
                SLog(@"callBakPreparedMutliStatus isn't implementation");
            }
        }
            break;
        case ENDoloadingStatus:{
            
            aSel = @selector(callBakDoloadingMutliStatus);
            if ([self _checkSDelegateMethod:aSel]) {
                [_sDelegate callBakDoloadingMutliStatus];
            }else{
                SLog(@"callBakDoloadingMutliStatus isn't implementation");
            }
        }
            break;
        case ENPausedStatus:{
            
            aSel = @selector(callBakPausedMutliStatus);
            if ([self _checkSDelegateMethod:aSel]) {
                [_sDelegate callBakPausedMutliStatus];
            }else{
                SLog(@"callBakPausedMutliStatus isn't implementation");
            }
        }
        case ENFinishedStatus:{
            
            aSel = @selector(callBakFinishedMutliStatus);
            if ([self _checkSDelegateMethod:aSel]) {
                [_sDelegate callBakFinishedMutliStatus];
            }else{
                SLog(@"callBakFinishedMutliStatus isn't implementation");
            }
        }
            
        default:
            NSAssert(1, @"don's support %d ENUM", (int)enStatus);
            break;
    }
}

#pragma mark - 私有方法
- (BOOL)_checkSDelegateMethod:(SEL)aSelector {
    
    if (_sDelegate && [_sDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    return NO;
}
- (ENMutliDoloadStatus)getMutliDoloadStatus {
    
    return _enStatus;
}
@end
