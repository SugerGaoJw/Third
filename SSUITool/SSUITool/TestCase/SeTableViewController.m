//
//  SeTableViewController.m
//  SSUITool
//
//  Created by suger on 15/10/14.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "SeTableViewController.h"

@interface SeTableViewController ()
- (UITableView * )loadTableView ;
- (void)registerDeviceOrientationDidChange ;
- (void)unregisterDeviceOrientationDidChange;

@end

@implementation SeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [self loadTableView];
    [self registerDeviceOrientationDidChange];
    
}
- (void)dealloc {
    
}


- (UITableView * )loadTableView {
    
    UITableView* t = [UITableView new];
    t.delegate = self;
    t.dataSource = self;
    [self.view addSubview:t];
    UIView* superView = self.view;
    [t mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(superView.mas_leading);
        make.top.equalTo( @64 );
        make.bottom.equalTo ( superView.mas_bottom).offset( -44 );
        make.trailing.equalTo ( superView.mas_trailing);
        
    }];
    return t;
}
- (void)registerDeviceOrientationDidChange {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChange)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
}
- (void)unregisterDeviceOrientationDidChange {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIDeviceOrientationDidChangeNotification];
    
}
- (void)deviceOrientationDidChange {
    UIDevice *device = [UIDevice currentDevice];
    switch (device.orientation) {

        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:{
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo( @0 );
            }];
             NSLog(@"横屏");
        }
        break;
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:{
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo( @64 );
            }];
            
            NSLog(@"竖屏");
        }
        break;
        default:
        NSLog(@"未知");
        break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
@end
