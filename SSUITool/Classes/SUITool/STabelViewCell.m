//
//  STabelViewCell.m
//  SUITool
//
//  Created by Suger on 15/8/27.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "STabelViewCell.h"

@implementation STabelViewCell
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    tableCell 划线 补全前面的 15px
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat lineHeight = rect.size.height ;
    CGContextSetLineWidth(context, .7f);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context, 0.f, lineHeight);
    CGContextAddLineToPoint(context, 20 ,lineHeight);
    CGContextStrokePath(context);
    
}

@end
