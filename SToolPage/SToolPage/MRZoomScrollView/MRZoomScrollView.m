//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface MRZoomScrollView (Utility)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end


@implementation MRZoomScrollView
- (instancetype)initWithFrame:(CGRect)frame forScaledImage:(UIImage *)image {
    
    id retId = [self initWithFrame:frame];
    if (retId && _scaledImageView) {
        _scaledImageView.image = image;
        return retId;
    }
    return nil;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ( self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, MRScreenWidth, MRScreenHeight);
        [self initImageView];
        return self;
    }
    return nil;
}

- (void)initImageView {
    
    UIImageView* imageView = [[UIImageView alloc]init];
    
    // The imageView can be zoomed largest size
    imageView.frame = CGRectMake(0, 0, MRScreenWidth * 2.5, MRScreenHeight * 2.5);
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    _scaledImageView = imageView;
    
    // Add gesture,double tap zoom imageView.
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [imageView addGestureRecognizer:doubleTapGesture];
    
    minimumScale = self.frame.size.width / imageView.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
    [self setScrollEnabled:NO];
}

#pragma mark -- publice
- (void)zoomInMiniumumSacle {
    
    CGPoint screenCenterPoint = CGPointMake(MRScreenWidth * .5f, MRScreenWidth * .5f);
    CGRect zoomRect = [self zoomRectForScale:minimumScale withCenter:screenCenterPoint];
    [self zoomToRect:zoomRect animated:YES];
    
}

#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
    
    CGRect zoomRect;
    if (self.zoomScale >= .8f) {
        //zoom in
        NSLog(@"already is max scale 1.0");
        CGPoint screenCenterPoint = CGPointMake(MRScreenWidth * .5f, MRScreenWidth * .5f);
        zoomRect = [self zoomRectForScale:minimumScale withCenter:screenCenterPoint];
    }else{
        // zoom out
        float newScale = self.zoomScale * 1.5;
        zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
        
    }
    [self zoomToRect:zoomRect animated:YES];
    NSLog(@"cur scale is :%f",self.zoomScale);
    
    
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center{
    
    CGRect zoomRect;
    NSLog(@"zoom center : {%f, %f}",center.x, center.y);
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 1.5);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 1.5);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _scaledImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark - View cycle
@end
