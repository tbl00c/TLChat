//
//  ZZFLEXTableViewEmptyCell.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/19.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZFLEXTableViewEmptyCell.h"

@implementation ZZFLEXTableViewEmptyCell

+ (CGFloat)viewHeightByDataModel:(ZZFlexibleLayoutSeperatorModel *)dataModel
{
    return dataModel.size.height;
}

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setViewDataModel:(ZZFlexibleLayoutSeperatorModel *)dataModel
{
    if (dataModel.color) {
        [self setBackgroundColor:dataModel.color];
    }
}

@end
