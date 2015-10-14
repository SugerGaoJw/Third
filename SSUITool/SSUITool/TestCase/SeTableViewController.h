//
//  SeTableViewController.h
//  SSUITool
//
//  Created by suger on 15/10/14.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end
