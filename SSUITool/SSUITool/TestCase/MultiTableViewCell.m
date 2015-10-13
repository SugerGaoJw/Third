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

@end
