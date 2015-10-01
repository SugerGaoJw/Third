//
//  MBProgressHUD+Custom.h
//  SSUITool
//
//  Created by Suger on 15/8/29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "MBProgressHUD.h"

typedef void(^hiddenHUDBlockDef)(dispatch_block_t hBlock);
#define KMBPMainWin            [AppDelegate shareInstance].window
#define KMBPSelfViewController self.view
#define KMBPSelf               self

@interface MBProgressHUD (Custom)

+ (void)showInViewAutoClean:(UIView   *)superView
                 forMessage:(NSString *)message
         withExecutingBlock:(dispatch_block_t /* do sync action */)eblock
         withCompletingBlock:(dispatch_block_t)cblock;

+ (void)showInViewNonAutoClean:(UIView   *)superView
                    forMessage:(NSString *)message
            withHiddenHUDBlock:(hiddenHUDBlockDef)hiddenHUDBlock;



@end
