//
//  UIViewController+Base.h
//  SSUITool
//
//  Created by Suger on 15/8/28.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  UIViewController 分类 base
 */
@interface UIViewController (Base)

//AlertView
- (__weak CXAlertView *)cxAlertViewTitle:(NSString *)title
                              forMessage:(NSString *)message
                       cancelButtonBlock:(CXAlertButtonHandler)cancelButtonBlock;

//NavigationBack Button
- (void)createNavBackButton;
- (void)setNavBackButtonHidden:(BOOL)hidden;
- (void)doNavBackButtonAction:(UIButton *)sender;


@end
