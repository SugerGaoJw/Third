//
//  TestTableViewController.m
//  SSUITool
//
//  Created by Suger on 15/8/28.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestNetAdrEntity.h"


@implementation TestTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.navigationItem setTitle:@"TableListInTab"];
}
- (void)viewDidLoad {
//    self.enRefreshType = ENRefreshOnlyHeaderType;
    self.enTableViewType = ENTableViewInTabType;
    [super viewDidLoad];

    /*
    TestReqAdrEntity* req = [TestReqAdrEntity new];
    req.a = @"list";
    
    NSDictionary* reqDic = [req toDictionary];
    SLog(@"%@",reqDic);*/
    
   NSString* jsonStr = @"{\"loginJson\":{\"message\":\"用户名或密码错误!\",\"pass\":false,\"loginName\":null}}";
   id jsonObject  =  [jsonStr JSONObject];
    TestLoginSeesion* lgSeesion =  (TestLoginSeesion *)[[TestLoginSeesion alloc] toEntityWithValues:jsonObject];
    NSLog(@"%@",lgSeesion);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

#pragma mark - STableViewDelegate
- (void)stableView:(UITableView *)tableView didRefreshedFooter:(MJRefreshFooter *)refreshFooter {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshFooter endRefreshing];
    });
}

- (void)stableView:(UITableView *)tableView didRefreshedHeader:(MJRefreshHeader *)refreshHeader {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshHeader endRefreshing];
    });
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
}
@end
