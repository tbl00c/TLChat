//
//  TLMineInfoAvatarCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineInfoAvatarCell.h"
#import "TLMacros.h"

@interface TLMineInfoAvatarCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *avatarImageView;

@end

@implementation TLMineInfoAvatarCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 85.0f;
}

#pragma mark - # Cell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.avatarImageView];
        [self p_addMasonry];
    }
    return self;
}

- (void)setItem:(TLSettingItem *)item
{
    [super setItem:item];
    [self.titleLabel setText:item.title];
    if (item.rightImagePath) {
        [self.avatarImageView setImage: [UIImage imageNamed:item.rightImagePath]];
    }
    else if (item.rightImageURL){
        [self.avatarImageView tt_setImageWithURL:TLURL(item.rightImageURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    else {
        [self.avatarImageView setImage:nil];
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.right.mas_lessThanOrEqualTo(self.avatarImageView.mas_left).mas_offset(-15);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.contentView).mas_offset(9);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-9);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
}

#pragma mark - # Getter
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:4.0f];
    }
    return _avatarImageView;
}

@end
