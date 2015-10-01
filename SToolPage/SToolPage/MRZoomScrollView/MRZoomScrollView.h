//
//  MRZoomScrollView.h
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MRZoomScrollView : UIScrollView <UIScrollViewDelegate>{
    float minimumScale;
    __weak UIImageView* _scaledImageView;
}
/**
 *  @author suger, 15-09-13 11:09:06
 *
 *  初始化 MRZoomScrollView 对象
 *
 *  @param frame 指定大小
 *  @param image 指定缩放image
 *
 *  @return  MRZoomScrollView 对象
 */
- (instancetype)initWithFrame:(CGRect)frame forScaledImage:(UIImage *)image;

/**
 *  @author suger, 15-09-13 11:09:21
 *
 *  图片缩放至最小倍数
 */

- (void)zoomInMiniumumSacle;
@end
