//
//  MultiTableViewController.m
//  SSUITool
//
//  Created by suger on 15/10/13.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "MultiTableViewController.h"
#import "DoubanTop250Entity.h"



@interface MultiTableViewController ()

@end

@implementation MultiTableViewController

- (void)viewDidLoad {
    
    self.enTableViewType = ENTableViewInTabType;
    self.enRefreshType = ENRefreshAllType;
    
    [super viewDidLoad];
}

#pragma mark - Table view data source



#pragma mark - STableViewDelegate
- (void)stableView:(UITableView *)tableView didRefreshedFooter:(MJRefreshFooter *)refreshFooter {
    /* dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [refreshFooter endRefreshing];
     });*/
    
}

- (void)stableView:(UITableView *)tableView didRefreshedHeader:(MJRefreshHeader *)refreshHeader {
   
    dispatch_block_t endRefreshedBlock = ^(void) {
        [refreshHeader endRefreshing];
        
    };
    
    //config Request entity
    DoubanTop250ReqEntity* req = [[DoubanTop250ReqEntity alloc]init];
    req.onCleanMBPBlock = endRefreshedBlock;
    req.start = @"0";
    
    //start http request
    [self requestHttpBody:req];
}

- (void)requestHttpBody:(id<SXReqBodyDelegate>)reqBody {
    
    //start http loader
    SXHttpLoadManager* manager = [SXHttpLoadManager shareInstance];
    [manager requestAtBody:reqBody  onFinishBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
        
    } onFiledBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
        
    }];
}
@end
