//
//  MRZoomControllerScrollView.m
//  SZoomScrollView
//
//  Created by suger on 15/9/13.
//  Copyright (c) 2015年 suger. All rights reserved.
//
#import "MRZoomScrollView.h"
#import "MRZoomControllerScrollView.h"

@interface MRZoomControllerScrollView()

@property (nonatomic, strong) NSMutableArray *zoomViewsArray;
- (void)onCreateZoomViewWithFrame:(CGRect)frame AtIamge:(NSArray *)imagesArray;
@end

@implementation MRZoomControllerScrollView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype)initWithFrame:(CGRect)frame AtImages:(NSArray *)imageArray {
    
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self onCreateZoomViewWithFrame:frame AtIamge:imageArray];
        
    }
    return self;
}

- (void)onCreateZoomViewWithFrame:(CGRect)frame AtIamge:(NSArray *)imagesArray {
    
    _imageCount = imagesArray.count;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    [self setContentSize:CGSizeMake(w * _imageCount, h)];
    
    __weak typeof(self) wself = self;
    __block MRZoomScrollView* zoomView = nil;
    __block  UIImage* image = nil;
    [imagesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        image = (UIImage *)obj;
        if ([image isKindOfClass:[UIImage class]] == NO) {
            NSAssert(1, @"imagesArray Object suppert to UIImage-class only");
            *stop = YES;
        }
        
        CGRect zoomViewFrame = wself.frame;
        zoomViewFrame.origin.x = zoomViewFrame.size.width * idx;
        zoomViewFrame.origin.y = 0;
        
        zoomView = [[MRZoomScrollView alloc]initWithFrame:zoomViewFrame forScaledImage:image];
        if (zoomView != nil) {
            [wself addSubview:zoomView];
            [wself.zoomViewsArray addObject:zoomView];
        }
        
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //disabled sub srollView srolling !
    __block MRZoomScrollView* zoomView = nil;
    [self.zoomViewsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        zoomView = (MRZoomScrollView *)obj;
        [zoomView setScrollEnabled:NO];
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    
    //enable sub srollView srolling !
    __block MRZoomScrollView* zoomView = nil;
    [self.zoomViewsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        zoomView = (MRZoomScrollView *)obj;
        [zoomView setScrollEnabled:YES];
        [zoomView zoomInMiniumumSacle];
    }];
}

- (NSMutableArray *)zoomViewsArray {
    if (_zoomViewsArray == nil) {
        _zoomViewsArray = [NSMutableArray arrayWithCapacity:_imageCount];
    }
    return _zoomViewsArray;
}
@end
