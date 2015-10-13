//
//  MultiTableViewCell.m
//  SSUITool
//
//  Created by suger on 15/10/13.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import "MultiTableViewCell.h"

@implementation MultiTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self loadPlaceholderLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    SLog(@"");
}
- (CGSize)sizeThatFits:(CGSize)size {
    SLog(@"");
    return size;
}

#pragma mark - Publice
- (void)setMovieEnity:(MovieEntity *)movieEntity {
    
}

#pragma mark - private
//加载 Placeholder Layer
- (void)loadPlaceholderLayer {
    
    CALayer* l = [[CALayer alloc]init];
    l.position = CGPointMake(30, 30);

    l.bounds = (CGRect){0,0,CGSizeMake(10, 10)};
    l.contents = (__bridge id _Nullable)([UIImage imageNamed:@"image_order_placehold"].CGImage);
    l.contentsGravity = kCAGravityCenter;
    l.contentsScale = [UIScreen mainScreen].scale;
    l.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:1].CGColor;
    [self.contentView.layer addSublayer:l];
    _placeholderLayer = l;
}
@end
