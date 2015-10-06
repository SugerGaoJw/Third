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
#import "TestDoloadEntity.h"


gblHttpRequestHeader(RequestPOSTBlock)
gblHttpRequestHeader(RequestGETBlock)
gblHttpRequestHeader(SingleDoloadBlock)
gblHttpRequestHeader(MutliDoloadBlock)

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
                               forMessage:@"doPOSTReqAction..."
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
                               forMessage:@"doGETReqAction..."
                       withHiddenHUDBlock:^(dispatch_block_t hBlock) {
                           
                           block(hBlock);
                           
                       }];
}



- (IBAction)Single_Mutli_Doload:(id)sender {
    
    gblSingleDoloadBlock block;
    
    //SXHttpLoadManager
    block = ^(dispatch_block_t hiddenMBPblock) {
        
        TestReqDoloadEntity* req = [[TestReqDoloadEntity alloc]init];
        req.onCleanMBPBlock = hiddenMBPblock;
        
        SXHttpLoadManager* manager =  [SXHttpLoadManager shareInstance];
        [manager requestAtBody:req onDoloadProgressBlock:^BOOL(CGFloat doloadPercentage, CGFloat totalPercentage) {
            return NO;
            
        } onFinishBlock:^(BOOL isRespError, NSString *errDescription, id<SXRespBodyDelegate> resObject) {
            
        } onFiledBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
            
        }];
        
    };
    
    //MBProgressHUD
    [MBProgressHUD showInViewNonAutoClean:KMBPSelfViewController
                               forMessage:@"Single_Mutli_Doload..."
                       withHiddenHUDBlock:^(dispatch_block_t hBlock) {
                           
                           block(hBlock);
                           
                       }];
}
- (IBAction)MutliDoload:(id)sender {
    
    gblMutliDoloadBlock block;
    //SXHttpLoadManager
    block = ^(dispatch_block_t hiddenMBPblock) {
        TestReqDoloadEntity* req = nil;
        NSMutableArray* reqBodyArray = [[NSMutableArray alloc]init];
        
        req = [[TestReqDoloadEntity alloc]init];
        req.mainDominURL = @"http://allseeing-i.com/ASIHTTPRequest/tests/images/small-image.jpg";
        [reqBodyArray addObject:req];
        
        req = [[TestReqDoloadEntity alloc]init];
        req.mainDominURL = @"http://allseeing-i.com/ASIHTTPRequest/tests/images/medium-image.jpg";
        [reqBodyArray addObject:req];
        
        req = [[TestReqDoloadEntity alloc]init];
        req.mainDominURL = @"http://allseeing-i.com/ASIHTTPRequest/tests/images/large-image.jpg";
        [reqBodyArray addObject:req];
        
        SXHttpLoadManager* manager =  [SXHttpLoadManager shareInstance];
        
        [manager requestAtBodyArray:reqBodyArray withCleanMBPBlock:hiddenMBPblock
              onDoloadProgressBlock:^BOOL(CGFloat doloadPercentage, CGFloat totalPercentage) {
            
            return NO;
            
        } onFinishBlock:^(BOOL isRespError, NSString *errDescription, SXHttpLoadHandler* resObject) {
            
        } onFiledBlock:^(BOOL isRespError, NSString *errDescription, id resObject) {
            
        }];
    };
    
    //MBProgressHUD
    [MBProgressHUD showInViewNonAutoClean:KMBPSelfViewController
                               forMessage:@"Mutli_Doload..."
                       withHiddenHUDBlock:^(dispatch_block_t hBlock) {
                           
                           block(hBlock);
                           
                       }];
    
    
    
}

@end
