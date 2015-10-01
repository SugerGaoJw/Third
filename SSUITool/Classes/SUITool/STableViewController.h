//
//  STableViewController.h
//  SUITool
//
//  Created by Suger on 15/8/27.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "STableViewDelegate.h"
#define KTableCellIdentifier @"KTableCellIdentifier"
/*!
 *  所有 TableViewController 父类
 */
@interface STableViewController : UITableViewController <STableViewDelegate> {
    
    __weak      MJRefreshHeader*    _mjRefreshHeader;       //当前头部刷新控件
    __weak      MJRefreshFooter*    _mjRefreshFooter;       //当前尾部刷新控件
}

@property (nonatomic, weak   ) id<STableViewDelegate> sdelegate;
@property (nonatomic, assign ) CGFloat tableCellHeight;

@property (nonatomic, assign )            ENTableViewType     enTableViewType;        //tableView类型
@property (nonatomic, assign )            ENRefreshType       enRefreshType;         //添加刷新控件的类型
@property (nonatomic, assign, readonly )  ENRefreshStateType  enRefreshStateType;    //当前刷新控件状态


- (void)configTableUI;
@end
