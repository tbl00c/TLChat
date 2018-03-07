//
//  TLSettingItemButtonCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/3/6.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLSettingItemButtonCell.h"

@interface TLSettingItemButtonCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLSettingItemButtonCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.arrowView setHidden:YES];
        
        self.titleLabel = self.contentView.addLabel(1)
        .masonry(^ (MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(self.contentView);
        })
        .view;
    }
    return self;
}

- (void)setItem:(TLSettingItem *)item
{
    item.showDisclosureIndicator = NO;
    [super setItem:item];
    
    [self.titleLabel setText:item.title];
}

@end
