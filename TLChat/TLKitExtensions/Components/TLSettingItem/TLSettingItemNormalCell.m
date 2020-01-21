//
//  TLSettingItemNormalCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/3/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLSettingItemNormalCell.h"

@interface TLSettingItemNormalCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation TLSettingItemNormalCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_initSettingItemSubviews];
    }
    return self;
}

- (void)setItem:(TLSettingItem *)item
{
    [super setItem:item];
    
    [self.titleLabel setText:item.title];
    [self.rightLabel setText:item.subTitle];
    if (item.rightImagePath) {
        [self.rightImageView setImage: [UIImage imageNamed:item.rightImagePath]];
    }
    else if (item.rightImageURL){
        [self.rightImageView tt_setImageWithURL:TLURL(item.rightImageURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    else {
        [self.rightImageView setImage:nil];
    }

    [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(item.showDisclosureIndicator ? -30.0f : -15.0f);
    }];
}

#pragma mark - # UI
- (void)p_initSettingItemSubviews
{
    self.titleLabel = self.contentView.addLabel(1)
    .masonry(^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
    })
    .view;

    self.rightLabel = self.contentView.addLabel(2)
    .textColor([UIColor grayColor]).font([UIFont systemFontOfSize:15.0f])
    .masonry(^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(20);
    })
    .view;
    
    self.rightImageView = self.addImageView(3)
    .masonry(^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightLabel.mas_left).mas_offset(-2);
        make.centerY.mas_equalTo(0);
    })
    .view;
    
    [self.titleLabel setContentCompressionResistancePriority:500 forAxis:UILayoutConstraintAxisHorizontal];
    [self.rightLabel setContentCompressionResistancePriority:200 forAxis:UILayoutConstraintAxisHorizontal];
}


@end
