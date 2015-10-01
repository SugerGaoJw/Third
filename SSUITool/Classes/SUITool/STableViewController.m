//
//  STableViewController.m
//  SUITool
//
//  Created by Suger on 15/8/27.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "STableViewController.h"

@implementation STableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mjRefreshHeader beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopCustomRefreshComponent];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/**
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 return 0;
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark -- config UITableView

- (void)configTableUI {
    self.sdelegate = self;
    [self configTableView];
    [self loadCustomRefreshComponent];
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    switch (_enTableViewType) {
        case ENTableViewInTabType:
            if (SystemVersionGreaterOrEqualThan(7.0)) {
                edgeInsets =  UIEdgeInsetsMake(0, 0, 64 , 0);
            
            }else{
                edgeInsets = UIEdgeInsetsZero;
            
            }
            break;
       case ENTableViewInControllerType:
            edgeInsets = UIEdgeInsetsZero;
            break;
    }
    
    [self.tableView setContentInset:edgeInsets];
}

#pragma mark -- load Refresh Component
- (void)stopCustomRefreshComponent {
    [_mjRefreshFooter endRefreshing];
    [_mjRefreshHeader endRefreshing];
}


- (void)loadCustomRefreshComponent {
    switch (_enRefreshType) {
        case ENRefreshAllType:{
            [self loadRefreshHeader];
            [self loadRefreshFooter];
        }
            break;
            
        case ENRefreshOnlyHeaderType:{
            [self loadRefreshHeader];
        }
            break;
            
        case ENRefreshNoneType:
            SLog(@"Warming ENRefreshNoneType");
            break;
            
    }
}

- (void)loadRefreshHeader {
    // 进入刷新状态后会自动调用这个block 下拉
    __weak typeof(self) wself = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself sdLoadRefreshHeader];
    }];
    
    _mjRefreshHeader = self.tableView.header;
}

- (void)sdLoadRefreshHeader {
    
    if (self.sdelegate &&
        [self respondsToSelector:@selector(stableView:didRefreshedHeader:)]) {
        [self.sdelegate stableView:self.tableView didRefreshedHeader:_mjRefreshHeader];
        _enRefreshStateType = ENRefreshHeaderStateType;
    }else{
        _mjRefreshHeader = nil;
        SLog(@"Warming stableView:didRefreshedHeader:");
    }
}

- (void)loadRefreshFooter {
    // 进入刷新状态后会自动调用这个block 上啦
    __weak typeof(self) wself = self;
    self.tableView.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [wself sdloadRefreshFooter];
    }];
    _mjRefreshFooter = self.tableView.footer;
}

- (void)sdloadRefreshFooter {
    
    if (self.sdelegate &&
        [self respondsToSelector:@selector(stableView:didRefreshedFooter:)]) {
        [self.sdelegate stableView:self.tableView didRefreshedFooter:_mjRefreshFooter];
        _enRefreshStateType = ENRefreshFooterStateType;
        
    }else{
        _mjRefreshFooter = nil;
        SLog(@"Warming stableView:didRefreshedHeader:");
    }
}

/**
 #pragma mark -- App Life Notification
 //DidEnterBackgroundNotification
 - (void)registerdDidEnterBackgroundNotification {
 
 [self removedDidEnterBackgroundNotification];
 NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
 [center addObserver:self
 selector:@selector(didEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
 }
 
 - (void)removedDidEnterBackgroundNotification {
 NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
 [center removeObserver:self
 name:UIApplicationDidEnterBackgroundNotification
 object:nil];
 }
 
 - (void)didEnterBackgroundNotification:(NSNotification *)aNotification {
 [self removedDidEnterBackgroundNotification];
 UIEdgeInsets insets = UIEdgeInsetsZero;
 switch (_enRefreshStateType) {
 case ENRefreshHeaderStateType:{
 if (!_mjRefreshHeader.isRefreshing ) {
 insets = UIEdgeInsetsMake(0, 0, 50 * 2, 0); //头部未刷新
 }else{
 insets = UIEdgeInsetsMake(60, 0,   50  , 0); //头部正在刷新
 }
 } break;
 case ENRefreshFooterStateType:{
 if (!_mjRefreshFooter.isRefreshing ) {
 insets = UIEdgeInsetsMake(0, 0, 0, 0); //头部未刷新
 }else{
 insets = UIEdgeInsetsMake(0, 0,  50*2 , 0); //头部正在刷新
 }
 
 } break;
 }
 
 [self.tableView setContentInset:insets];
 }
 */

/**
 
 //WillEnterForeground
 - (void)registerdWillEnterForegroundNotification {
 
 [self removedWillEnterForegroundNotification];
 NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
 [center addObserver:self
 selector:@selector(willEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
 }
 
 - (void)removedWillEnterForegroundNotification {
 
 NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
 [center removeObserver:self
 name:UIApplicationWillEnterForegroundNotification
 object:nil];
 }
 
 - (void)willEnterForegroundNotification:(NSNotification *)aNotification {
 }
 
 */
@end
