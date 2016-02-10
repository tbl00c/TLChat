//
//  TLFriendCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendCell.h"
#import <UIImageView+WebCache.h>

#define     FRIENDS_SPACE_X         9.5f

@interface TLFriendCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@end

@implementation TLFriendCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftSeparatorSpace = FRIENDS_SPACE_X;
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.usernameLabel];
        
        [self addMasonry];
    }
    return self;
}

- (void) addMasonry
{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FRIENDS_SPACE_X);
        make.top.mas_equalTo(FRIENDS_SPACE_X);
        make.bottom.mas_equalTo(- FRIENDS_SPACE_X + 0.5);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(FRIENDS_SPACE_X);
        make.centerY.mas_equalTo(self.avatarImageView);
    }];
}


#pragma mark - Public Methods
- (void) setUser:(TLUser *)user
{
    _user = user;
    if (user.avatarPath) {
        [self.avatarImageView setImage:[UIImage imageNamed:user.avatarPath]];
    }
    else {
        [self.avatarImageView sd_setImageWithURL:TLURL(user.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    
    [self.usernameLabel setText:user.remarkName ? user.remarkName : user.nikeName];
}

#pragma mark - Getter
- (UIImageView *) avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UILabel *) usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont fontFriendsUsername]];
    }
    return _usernameLabel;
}

@end
