//
//  TLFriendDetailUserCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailUserCell.h"
#import <UIButton+WebCache.h>
#import "TLUser.h"

#define     MINE_SPACE_X        14.0f
#define     MINE_SPACE_Y        12.0f

@interface TLFriendDetailUserCell ()

@property (nonatomic, strong) UIButton *avatarView;

@property (nonatomic, strong) UILabel *shownameLabel;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *nikenameLabel;

@end

@implementation TLFriendDetailUserCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.leftSeparatorSpace = 15.0f;
        
        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.shownameLabel];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.nikenameLabel];
        
        [self addMasonry];
    }
    return self;
}

- (void) addMasonry
{
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MINE_SPACE_X);
        make.top.mas_equalTo(MINE_SPACE_Y);
        make.bottom.mas_equalTo(- MINE_SPACE_Y);
        make.width.mas_equalTo(self.avatarView.mas_height);
    }];
    
    [self.shownameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    [self.shownameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(MINE_SPACE_Y);
        make.top.mas_equalTo(self.avatarView.mas_top).mas_offset(3);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shownameLabel);
        make.top.mas_equalTo(self.shownameLabel.mas_bottom).mas_offset(5);
    }];
    
    [self.nikenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shownameLabel);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(3);
    }];
}

- (void) setInfo:(TLInfo *)info
{
    _info = info;
    TLUser *user = info.userInfo;
    if (user.avatarPath) {
        [self.avatarView setImage:[UIImage imageNamed:user.avatarPath] forState:UIControlStateNormal];
    }
    else{
        [self.avatarView sd_setImageWithURL:TLURL(user.avatarURL) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    [self.shownameLabel setText:user.showName];
    if (user.username.length > 0) {
        [self.usernameLabel setText:[@"微信号：" stringByAppendingString:user.username]];
        if (user.nikeName.length > 0) {
            [self.nikenameLabel setText:[@"昵称：" stringByAppendingString:user.nikeName]];
        }
    }
    else if (user.nikeName.length > 0){
        [self.nikenameLabel setText:[@"昵称：" stringByAppendingString:user.nikeName]];
    }
}

#pragma mark - # Event Response 
- (void)avatarViewButtonDown:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(friendDetailUserCellDidClickAvatar:)]) {
        [self.delegate friendDetailUserCellDidClickAvatar:self.info];
    }
}

#pragma mark - Getter
- (UIButton *)avatarView
{
    if (_avatarView == nil) {
        _avatarView = [[UIButton alloc] init];
        [_avatarView.layer setMasksToBounds:YES];
        [_avatarView.layer setCornerRadius:5.0f];
        [_avatarView addTarget:self action:@selector(avatarViewButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarView;
}

- (UILabel *)shownameLabel
{
    if (_shownameLabel == nil) {
        _shownameLabel = [[UILabel alloc] init];
        [_shownameLabel setFont:[UIFont fontMineNikename]];
    }
    return _shownameLabel;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont fontMineUsername]];
        [_usernameLabel setTextColor:[UIColor grayColor]];
    }
    return _usernameLabel;
}

- (UILabel *)nikenameLabel
{
    if (_nikenameLabel == nil) {
        _nikenameLabel = [[UILabel alloc] init];
        [_nikenameLabel setTextColor:[UIColor grayColor]];
        [_nikenameLabel setFont:[UIFont fontMineUsername]];
    }
    return _nikenameLabel;
}

@end