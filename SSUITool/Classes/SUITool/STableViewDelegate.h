//
//  STableViewDelegate.h
//  SUITool
//
//  Created by Suger on 15/8/27.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "STableViewHeader.h"

/*!
 *  TableView delegate
 */
@protocol STableViewDelegate <NSObject>
@optional
- (void)stableView:(UITableView *)tableView didRefreshedHeader:(MJRefreshHeader *)refreshHeader;
- (void)stableView:(UITableView *)tableView didRefreshedFooter:(MJRefreshFooter *)refreshFooter;
@end
