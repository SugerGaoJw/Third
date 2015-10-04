//
//  SXMutliDoLoadStatus.h
//  SSUITool
//
//  Created by suger on 15/10/4.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 *  状态回调状态方法
 */
@protocol SXMutliStatusMachineDelegate <NSObject>
- (void)callBakPreparedMutliStatus;
- (void)callBakDoloadingMutliStatus;
- (void)callBakPausedMutliStatus;
- (void)callBakFinishedMutliStatus;

@end

/*!
 *  下载状态
 */
typedef NS_ENUM(NSInteger , ENMutliDoloadStatus){
    /*!
     *  未知状态
     */
    ENUNKownStatus = -1,
    /*!
     *  准备状态
     */
    ENPreparedStatus = 0,
    /*!
     *  下载状态
     */
    ENDoloadingStatus,
    /*!
     *  暂停状态
     */
    ENPausedStatus,
    /*!
     *  完成状态
     */
    ENFinishedStatus,
};

/*!
 *  控制状态状态机
 */
@interface SXMutliStatusMachine : NSObject

- (instancetype)initWithDelegate:(id) sDelegate ;
/*!
 *  Get current ENMutliDoloadStatus
 *
 *  @return ENMutliDoloadStatus object
 */
- (ENMutliDoloadStatus)getMutliDoloadStatus;
/*!
 *  stimulate status machine
 *
 *  @param enStatus ENMutliDoloadStatus
 */
- (void)stlMachineForStatus:(ENMutliDoloadStatus)enStatus;
@end
