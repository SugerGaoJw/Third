//
//  Table2ViewController.m
//  SSUITool
//
//  Created by Suger on 15/8/28.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "Table2ViewController.h"
@implementation Table2ViewController

- (void)viewDidLoad {
    self.enTableViewType = ENTableViewInControllerType;
    [super viewDidLoad];
    [self setTitle:@"TableListInViewcontroller"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    __weak typeof(self) wself = self;
    
     [self cxAlertViewTitle:@"SSUITool" forMessage:@"Hi,Suger."
     cancelButtonBlock:^(CXAlertView *alertView, CXAlertButtonItem *button) {
     [alertView dismiss];
     
         [wself.navigationController popViewControllerAnimated:YES];
     }];
 
    
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

@end
