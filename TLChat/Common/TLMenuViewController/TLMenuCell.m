//
//  TLMenuCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMenuCell.h"
#import <UIImageView+WebCache.h>

#define     REDPOINT_WIDTH      8.0f

@interface TLMenuCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *midLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIView *redPointView;

@end

@implementation TLMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.midLabel];
        [self.contentView addSubview:self.rightImageView];
        [self.contentView addSubview:self.redPointView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setMenuItem:(TLMenuItem *)menuItem
{
    _menuItem = menuItem;
    [self.iconImageView setImage:[UIImage imageNamed:menuItem.iconPath]];
    [self.titleLabel setText:menuItem.title];
    [self.midLabel setText:menuItem.subTitle];
    if (menuItem.rightIconURL == nil) {
        [self.rightImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    else {
        [self.rightImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.rightImageView.mas_height);
        }];
        [self.rightImageView sd_setImageWithURL:TLURL(menuItem.rightIconURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    [self.redPointView setHidden:!menuItem.showRightRedPoint];
}

#pragma mark - Private Methods
- (void)p_addMasonry
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.width.and.height.mas_equalTo(25.0f);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(15.0f);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(15.0f);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.iconImageView);
        make.width.and.height.mas_equalTo(31);
    }];
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.rightImageView.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightImageView.mas_right).mas_offset(1);
        make.centerY.mas_equalTo(self.rightImageView.mas_top).mas_offset(1);
        make.width.and.height.mas_equalTo(REDPOINT_WIDTH);
    }];
}

#pragma mark - Getter
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UILabel *)midLabel
{
    if (_midLabel == nil) {
        _midLabel = [[UILabel alloc] init];
        [_midLabel setTextColor:[UIColor grayColor]];
        [_midLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _midLabel;
}

- (UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (UIView *)redPointView
{
    if (_redPointView == nil) {
        _redPointView = [[UIView alloc] init];
        [_redPointView setBackgroundColor:[UIColor redColor]];
        
        [_redPointView.layer setMasksToBounds:YES];
        [_redPointView.layer setCornerRadius:REDPOINT_WIDTH / 2.0];
        [_redPointView setHidden:YES];
    }
    return _redPointView;
}

@end
