//
//  UIViewController+Base.m
//  SSUITool
//
//  Created by Suger on 15/8/28.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "UIViewController+Base.h"
#import "UIViewController+Swizzling.h"



@implementation UIViewController (Base)
+ (void)load {
    SEL s = @selector(s_viewWillAppear:);
    SEL o = @selector(viewWillAppear:);
    [self swizzledMethodSel:s OriginaledMethodSel:o];
}

//viewWillAppear swizzle
- (void)s_viewWillAppear:(BOOL)animated {
    [self s_viewWillAppear:animated];
  
    NSArray* c = (NSArray *)[[SXResLoadHandler shareInstance]getXResourceByKey:KRCustomViewcontrollerList];
    NSString* s = NSStringFromClass([self class]);
    if ([c containsObject:s]) {
        [self createNavBackButton];
    }
}



#pragma mark -- Navigation back button

-(void)createNavBackButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 29, 35);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barItem;

    [backButton setImage:[UIImage imageNamed:@"global_back_btn"]
                forState:UIControlStateNormal];
    
    [backButton addTarget:self
                   action:@selector(doNavBackButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    if (SystemVersionGreaterOrEqualThan(7.0)) {
        [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -25.f, 0, 0)];
    }
}

-(void)setNavBackButtonHidden:(BOOL)hidden {
    self.navigationItem.leftBarButtonItem.customView.hidden = hidden;
}

-(void)doNavBackButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UI AlertView
//AlertView
- (__weak CXAlertView *)cxAlertViewTitle:(NSString *)title
                              forMessage:(NSString *)message
                       cancelButtonBlock:(CXAlertButtonHandler)cancelButtonBlock {
 
    CXAlertView* alertView = [[CXAlertView alloc]initWithTitle:title
                                                       message:message
                                             cancelButtonTitle:nil];
    //cancel buttion
    if (cancelButtonBlock) {
        [alertView addButtonWithTitle:@"取消"
                                 type:CXAlertViewButtonTypeCancel
                              handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
            cancelButtonBlock(alertView,button);
        }];
    }
    alertView.showBlurBackground = NO; //close blur background
    [alertView show];
    
    
    CXAlertView* retAlertView = alertView;
    return retAlertView;
}


@end
