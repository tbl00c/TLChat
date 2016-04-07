//
//  TLMomentBaseCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentBaseCell.h"
#import <UIButton+WebCache.h>

#define         EDGE_LEFT       8.0f
#define         EDGE_TOP        10.0f
#define         WIDTH_AVATAR    40.0f
#define         SPACE_ROW       6.0f

@interface TLMomentBaseCell ()

@property (nonatomic, strong) UIButton *avatarView;

@property (nonatomic, strong) UIButton *usernameView;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *originLabel;

@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation TLMomentBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBottomLineStyle:TLCellLineStyleFill];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.usernameView];
        [self.contentView addSubview:self.detailContainerView];
        [self.contentView addSubview:self.commentContainerView];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.originLabel];
        [self.contentView addSubview:self.moreButton];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setMoment:(TLMoment *)moment
{
    _moment = moment;
    [self.avatarView sd_setImageWithURL:TLURL(moment.avatarURL) forState:UIControlStateNormal];
    [self.usernameView setTitle:moment.username forState:UIControlStateNormal];
    [self.dateLabel setText:@"1小时前"];
    [self.originLabel setText:@"微博"];
}

#pragma mark - # Private Methods -
- (void)p_addMasonry
{
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(EDGE_TOP);
        make.left.mas_equalTo(self.contentView).mas_offset(EDGE_LEFT);
        make.size.mas_equalTo(CGSizeMake(WIDTH_AVATAR, WIDTH_AVATAR));
    }];
    [self.usernameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(EDGE_LEFT);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-EDGE_LEFT);
        make.height.mas_equalTo(15.0f);
    }];
    [self.detailContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.usernameView);
        make.top.mas_equalTo(self.usernameView.mas_bottom).mas_offset(SPACE_ROW);
        make.right.mas_equalTo(self.contentView).mas_offset(-EDGE_LEFT);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailContainerView.mas_bottom).mas_offset(SPACE_ROW);
        make.left.mas_equalTo(self.usernameView);
    }];
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateLabel);
        make.left.mas_equalTo(self.dateLabel.mas_right).mas_offset(EDGE_LEFT);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dateLabel);
        make.right.mas_equalTo(self.detailContainerView);
    }];
    [self.commentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dateLabel.mas_bottom).mas_offset(SPACE_ROW);
        make.left.and.right.mas_equalTo(self.detailContainerView);
    }];
}

#pragma mark - # Getter -
- (UIButton *)avatarView
{
    if (_avatarView == nil) {
        _avatarView = [[UIButton alloc] init];
    }
    return _avatarView;
}

- (UIButton *)usernameView
{
    if (_usernameView == nil) {
        _usernameView = [[UIButton alloc] init];
        [_usernameView.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_usernameView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _usernameView;
}

- (UIView *)detailContainerView
{
    if (_detailContainerView == nil) {
        _detailContainerView = [[UIView alloc] init];
        [_detailContainerView setBackgroundColor:[UIColor orangeColor]];
    }
    return _detailContainerView;
}

- (UIView *)commentContainerView
{
    if (_commentContainerView == nil) {
        _commentContainerView = [[UIView alloc] init];
        [_commentContainerView setBackgroundColor:[UIColor purpleColor]];
    }
    return _commentContainerView;
}

- (UILabel *)dateLabel
{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] init];
        [_dateLabel setTextColor:[UIColor grayColor]];
        [_dateLabel setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _dateLabel;
}

- (UILabel *)originLabel
{
    if (_originLabel == nil) {
        _originLabel = [[UILabel alloc] init];
        [_originLabel setTextColor:[UIColor grayColor]];
        [_originLabel setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _originLabel;
}

- (UIButton *)moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc] init];
    }
    return _moreButton;
}

@end
