//
//  TLFriendDetailUserCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailUserCell.h"
#import <UIImageView+WebCache.h>
#import "TLUser.h"

#define     MINE_SPACE_X        14.0f
#define     MINE_SPACE_Y        12.0f

@interface TLFriendDetailUserCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *shownameLabel;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *nikenameLabel;

@end

@implementation TLFriendDetailUserCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        self.leftSeparatorSpace = 15.0f;
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.shownameLabel];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.nikenameLabel];
        
        [self addMasonry];
    }
    return self;
}

- (void) addMasonry
{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MINE_SPACE_X);
        make.top.mas_equalTo(MINE_SPACE_Y);
        make.bottom.mas_equalTo(- MINE_SPACE_Y);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.shownameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    [self.shownameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(MINE_SPACE_Y);
        make.top.mas_equalTo(self.avatarImageView.mas_top).mas_offset(3);
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
        [self.avatarImageView setImage:[UIImage imageNamed:user.avatarPath]];
    }
    else{
        [self.avatarImageView sd_setImageWithURL:TLURL(user.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
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

#pragma mark - Getter
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:5.0f];
    }
    return _avatarImageView;
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