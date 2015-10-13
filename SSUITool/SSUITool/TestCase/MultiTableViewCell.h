//
//  MultiTableViewCell.h
//  SSUITool
//
//  Created by suger on 15/10/13.
//  Copyright © 2015年 NewLandPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubanTop250Entity.h"
#import "STabelViewCell.h"

@interface MultiTableViewCell : STabelViewCell {

   __weak CALayer* _placeholderLayer;
    CGSize featureImageSizeOptional;
}
- (void)setMovieEnity:(MovieEntity *)movieEntity;
@end
