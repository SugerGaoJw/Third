//
//  MultiTableViewController.m
//  SSUITool
//
//  Created by suger on 15/10/13.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "MultiTableViewController.h"
#import "DoubanTop250Entity.h"



@interface MultiTableViewController (){
    NSArray* _requestTempArray;
    __block NSString* _currentPage;
}
@end

@implementation MultiTableViewController

- (void)viewDidLoad {
    
    self.enTableViewType = ENTableViewInTabType;
    
    [super viewDidLoad];
    _currentPage = @"0";
}

#pragma mark - Table view data source



#pragma mark - STableViewDelegate
- (void)stableView:(UITableView *)tableView didRefreshedFooter:(MJRefreshFooter *)refreshFooter {
    
    NSString* _tryPage = [NSString stringWithFormat:@"%d",([_currentPage intValue] + 1)];
   
    //handler respond data
    dispatch_block_t endRefreshedBlock = ^(void) {
        [refreshFooter endRefreshing];
        if ([NSObject isEqualSrcObject:_requestTempArray EnqualClass:[NSArray class]]) {
            [self.tableSourceArray addObjectsFromArray:_requestTempArray];
            _currentPage = _tryPage;
            [self.tableView reloadData];
        }
        
    };
    
    //config Request entity
    DoubanTop250ReqEntity* req = [[DoubanTop250ReqEntity alloc]init];
    req.onCleanMBPBlock = endRefreshedBlock;
    req.start = _tryPage;
    
    //start http request
    [self requestHttpBody:req];
}

- (void)stableView:(UITableView *)tableView didRefreshedHeader:(MJRefreshHeader *)refreshHeader {
   
    //config Request entity
    _currentPage = @"0";
    
    //handler respond data
    dispatch_block_t endRefreshedBlock = ^(void) {
        [refreshHeader endRefreshing];
        if ([NSObject isEqualSrcObject:_requestTempArray EnqualClass:[NSArray class]]) {
            [self.tableSourceArray removeAllObjects];
            [self.tableSourceArray addObjectsFromArray:_requestTempArray];
            [self.tableView reloadData];
        }
        
    };
    
    
   
    DoubanTop250ReqEntity* req = [[DoubanTop250ReqEntity alloc]init];
    req.onCleanMBPBlock = endRefreshedBlock;
    req.start = _currentPage;
    
    //start http request
    [self requestHttpBody:req];
}

- (void)requestHttpBody:(id<SXReqBodyDelegate>)reqBody {
    
    //clean
    _requestTempArray = nil;
    
    //start http loader
    SXHttpLoadManager* manager = [SXHttpLoadManager shareInstance];
    [manager requestAtBody:reqBody  onFinishBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
        
        //判断赋值
        if (!isRespError
            & [NSObject isEqualSrcObject:resObject EnqualClass:[DoubanTop250RespEntity class]]) {
            DoubanTop250RespEntity* resp = (DoubanTop250RespEntity *)resObject;
            _requestTempArray = resp.top250_list.copy;
            resp = nil;
        }
        
    } onFiledBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
        
    }];
}
@end
