//
//  TLMobileContactsItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMobileContactsItemCell.h"
#import "NSFileManager+TLChat.h"
#import "TLMacros.h"

#define     FRIENDS_SPACE_X         10.0f
#define     FRIENDS_SPACE_Y         9.5f

@interface TLMobileContactsItemCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation TLMobileContactsItemCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 55.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setContact:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == count - 1) {
        self.removeSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(10);
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.rightButton];
        
        [self p_addMasonry];
    }
    return self;
}

#pragma mark - # Public Methods
- (void)setContact:(TLMobileContactModel *)contact
{
    _contact = contact;
    if (contact.avatarPath) {
        NSString *path = [NSFileManager pathContactsAvatar:contact.avatarPath];
        [self.avatarImageView setImage:[UIImage imageNamed:path]];
    }
    else {
        [self.avatarImageView tt_setImageWithURL:TLURL(contact.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    
    [self.usernameLabel setText:contact.name];
    [self.subTitleLabel setText:contact.tel];
    if (contact.status == TLMobileContactStatusStranger) {
        [self.rightButton setBackgroundColor:[UIColor colorGreenDefault]];
        [self.rightButton setTitle:LOCSTR(@"添加") forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightButton.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    }
    else {
        [self.rightButton setBackgroundColor:[UIColor clearColor]];
        [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.rightButton.layer setBorderColor:[UIColor clearColor].CGColor];
        if (contact.status == TLMobileContactStatusFriend) {
            [self.rightButton setTitle:LOCSTR(@"已添加") forState:UIControlStateNormal];
        }
        else if (contact.status == TLMobileContactStatusWait) {
            [self.rightButton setTitle:LOCSTR(@"等待验证") forState:UIControlStateNormal];
        }
    }
}

#pragma mark - # Prvate Methods
- (void)p_addMasonry
{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FRIENDS_SPACE_X);
        make.top.mas_equalTo(FRIENDS_SPACE_Y);
        make.bottom.mas_equalTo(- FRIENDS_SPACE_Y + 0.5);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(FRIENDS_SPACE_X);
        make.top.mas_equalTo(self.avatarImageView).mas_offset(-1);
        make.right.mas_lessThanOrEqualTo(self.rightButton.mas_left).mas_offset(-10);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.usernameLabel);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(2);
        make.right.mas_lessThanOrEqualTo(self.rightButton.mas_left).mas_offset(-10);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-5);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(30);
        make.width.mas_greaterThanOrEqualTo(48);
    }];
}

#pragma mark - # Getters
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont fontFriendsUsername]];
    }
    return _usernameLabel;
}

- (UILabel *)subTitleLabel
{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        [_subTitleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_subTitleLabel setTextColor:[UIColor grayColor]];
    }
    return _subTitleLabel;
}

- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_rightButton.layer setMasksToBounds:YES];
        [_rightButton.layer setCornerRadius:4.0f];
        [_rightButton.layer setBorderWidth:BORDER_WIDTH_1PX];
    }
    return _rightButton;
}

@end
