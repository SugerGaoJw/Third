//
//  TestNetworkController.m
//  SSUITool
//
//  Created by Suger on 15/8/30.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "TestNetworkController.h"
#import "TestNetAdrEntity.h"
#import "TestNetMovieEntity.h"

gblHttpRequestHeader(RequestPOSTBlock)
gblHttpRequestHeader(RequestGETBlock)

@interface TestNetworkController ()
@end

@implementation TestNetworkController

#pragma mark - POST NetRequest TEST
- (IBAction)doPOSTReqAction:(id)sender {
    gblRequestPOSTBlock block;
    //SXHttpLoadManager
    block = ^(dispatch_block_t hiddenMBPblock) {
        
        TestReqAdrEntity* req = [[TestReqAdrEntity alloc]init];
        req.onCleanMBPBlock = hiddenMBPblock;
        SXHttpLoadManager* manager =  [SXHttpLoadManager shareInstance];
        [manager requestAtBody:req onFinishBlock:^(BOOL isRespError, NSString *errDescription, id<SXRespBodyDelegate> resObject) {
            
        } onFiledBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
            
        }];
        
        
    };
    
    //MBProgressHUD
    [MBProgressHUD showInViewNonAutoClean:KMBPSelfViewController
                               forMessage:@"Request UserAddress..."
                       withHiddenHUDBlock:^(dispatch_block_t hBlock) {
                           
                           block(hBlock);
                           
                       }];
    
}

- (IBAction)doGETReqAction:(id)sender {
    
    gblRequestGETBlock block;
    
    //SXHttpLoadManager
    block = ^(dispatch_block_t hiddenMBPblock) {
        
        TestReqMovieEntity* req = [[TestReqMovieEntity alloc]init];
        req.onCleanMBPBlock = hiddenMBPblock;
        //可配置属性，亦可给出默认值
        req.wd = @"万达";
        req.location = @"北京";
        
        SXHttpLoadManager* manager =  [SXHttpLoadManager shareInstance];
        [manager requestAtBody:req onFinishBlock:^(BOOL isRespError, NSString *errDescription, id<SXRespBodyDelegate> resObject) {
            
        } onFiledBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
            
        }];
        
        
    };
    
    //MBProgressHUD
    [MBProgressHUD showInViewNonAutoClean:KMBPSelfViewController
                               forMessage:@"Request UserAddress..."
                       withHiddenHUDBlock:^(dispatch_block_t hBlock) {
                           
                           block(hBlock);
                           
                       }];
}



- (IBAction)doQueueAction:(id)sender {
    /*
     SXPOSTRequest* req1 = [[SXPOSTRequest alloc]init];
     NSURL* url1 = [NSURL URLWithString:@"http://www.baidu.com"];
     [req1 sxfetchURL:url1 withReqDictionary:nil];
     
     SXPOSTRequest* req2 = [[SXPOSTRequest alloc]init];
     NSURL* url2 = [NSURL URLWithString:@"http://www.baidu.com"];
     [req2 sxfetchURL:url2 withReqDictionary:nil];
     
     SXHttpLoadRequestQueue* queue = [[SXHttpLoadRequestQueue alloc]init];
     [queue sxSetHttpLoadRequests:@[req1,req2]];*/
}

@end
