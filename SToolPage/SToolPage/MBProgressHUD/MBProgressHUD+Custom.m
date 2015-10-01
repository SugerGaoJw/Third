//
//  MBProgressHUD+Custom.m
//  SSUITool
//
//  Created by Suger on 15/8/29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "MBProgressHUD+Custom.h"

@implementation MBProgressHUD (Custom)


+ (void)showInViewAutoClean:(UIView   *)superView
                 forMessage:(NSString *)message
         withExecutingBlock:(dispatch_block_t)eblock
        withCompletingBlock:(dispatch_block_t)cblock{
    
    if (message == nil || cblock == nil || superView == nil) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
    [hud setLabelText:message];
    [superView addSubview:hud];
    [hud show:YES];
    
    //config hud
    [hud showAnimated:YES whileExecutingBlock:^{
       //executing block
        eblock();
    } completionBlock:^{
           //completing block
            [hud removeFromSuperview];
            cblock();
    }];
}
+ (void)showInViewNonAutoClean:(UIView   *)superView
                    forMessage:(NSString *)message
            withHiddenHUDBlock:(hiddenHUDBlockDef)hiddenHUDBlock {
    
    if (message == nil || hiddenHUDBlock == nil || superView == nil) {
        return;
    }

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
    
    [hud setLabelText:message];
    [superView addSubview:hud];
    [hud show:YES];
    
    //config hud
    dispatch_block_t hBlock = ^{
        [hud removeFromSuperview];
    };
    
    hiddenHUDBlock(hBlock);
    
}

@end
