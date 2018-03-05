//
//  TLMomentBaseCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentBaseCell.h"

@implementation TLMomentBaseCell

#pragma mark - # Protocol
+ (CGSize)viewSizeByDataModel:(TLMoment *)dataModel
{
    CGFloat height = dataModel.momentFrame.height;
    return CGSizeMake(SCREEN_WIDTH, height);
}

- (void)setViewDataModel:(id)dataModel
{
    [self setMoment:dataModel];
}

- (void)setViewDelegate:(id)delegate
{
    self.delegate = delegate;
}

#pragma mark - # Protocol
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(ZZSeparatorPositionBottom);
}

@end
