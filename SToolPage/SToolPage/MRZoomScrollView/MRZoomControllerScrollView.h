//
//  MRZoomControllerScrollView.h
//  SZoomScrollView
//
//  Created by suger on 15/9/13.
//  Copyright (c) 2015年 suger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRZoomControllerScrollView : UIScrollView<UIScrollViewDelegate>{
    NSUInteger _imageCount;
}
-(instancetype)initWithFrame:(CGRect)frame AtImages:(NSArray *)imageArray;
@end
