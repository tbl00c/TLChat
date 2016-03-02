//
//  TLMessageBaseCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessageBaseCell.h"
#import <UIButton+WebCache.h>

#define     TIMELABEL_HEIGHT    20.0f
#define     TIMELABEL_SPACE_Y   10.0f

#define     NAMELABEL_SPACE_X   12.0f
#define     NAMELABEL_SPACE_Y   1.0f

#define     AVATAR_WIDTH        40.0f
#define     AVATAR_SPACE_X      8.0f
#define     AVATAR_SPACE_Y      12.0f

#define     MSGBG_SPACE_X       3.0f
#define     MSGBG_SPACE_Y       1.0f

@interface TLMessageBaseCell ()
{
    TLMessageOwnerType curOwnerType;
}

@end

@implementation TLMessageBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.avatarButton];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.messageBackgroundView];
        [self p_addMasonry];
    }
    return self;
}

- (void)setMessage:(TLMessage *)message
{
    if (message.showTime) {
        [self.timeLabel setText:[NSString stringWithFormat:@"%@", message.date]];
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(TIMELABEL_HEIGHT);
            make.top.mas_equalTo(self.contentView).mas_offset(TIMELABEL_SPACE_Y);
        }];
    }
    else {
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(self.contentView);
        }];
    }
    
    [self.usernameLabel setText:message.fromUser.showName];
    [self.avatarButton sd_setImageWithURL:TLURL(message.fromUser.avatarURL) forState:UIControlStateNormal];
    if (curOwnerType != message.ownerTyper) {
        curOwnerType = message.ownerTyper;
        if (message.ownerTyper == TLMessageOwnerTypeSelf) {
            [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
                make.width.and.height.mas_equalTo(AVATAR_WIDTH);
                make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
            }];
            
            [self.usernameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.avatarButton).mas_equalTo(-NAMELABEL_SPACE_Y);
                make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(- NAMELABEL_SPACE_X);
            }];
    
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_sender_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_sender_bgHL"]];
            [self.messageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSGBG_SPACE_X);
                make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(message.showName ? 0 : -MSGBG_SPACE_Y);
            }];
        }
        else {
            [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).mas_offset(AVATAR_SPACE_X);
                make.width.and.height.mas_equalTo(AVATAR_WIDTH);
                make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
            }];
            
            [self.usernameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.avatarButton).mas_equalTo(-NAMELABEL_SPACE_Y);
                make.left.mas_equalTo(self.avatarButton.mas_right).mas_equalTo(NAMELABEL_SPACE_X);
            }];
            
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_receiver_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_receiver_bgHL"]];
            [self.messageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.avatarButton.mas_right).mas_offset(MSGBG_SPACE_X);
                make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(message.showName ? 0 : -MSGBG_SPACE_Y);
            }];
        }
    }
    if (!message.showName) {
        [self.usernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    curOwnerType = TLMessageOwnerTypeSelf;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(TIMELABEL_SPACE_Y);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarButton).mas_equalTo(-NAMELABEL_SPACE_Y);
        make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(- NAMELABEL_SPACE_X);
    }];
    
    // Default - self
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
        make.width.and.height.mas_equalTo(AVATAR_WIDTH);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
    }];
    
    [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_sender_bg"]];
    [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_sender_bgHL"]];
    [self.messageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSGBG_SPACE_X);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(-MSGBG_SPACE_Y);
    }];
}

#pragma mark - Getter -
- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        [_timeLabel setBackgroundColor:[UIColor grayColor]];
        [_timeLabel.layer setMasksToBounds:YES];
        [_timeLabel.layer setCornerRadius:5.0f];
    }
    return _timeLabel;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton.layer setMasksToBounds:YES];
        [_avatarButton.layer setBorderWidth:0.5f];
        [_avatarButton.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    }
    return _avatarButton;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setTextColor:[UIColor grayColor]];
        [_usernameLabel setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _usernameLabel;
}

- (UIImageView *)messageBackgroundView
{
    if (_messageBackgroundView == nil) {
        _messageBackgroundView = [[UIImageView alloc] init];
    }
    return _messageBackgroundView;
}

@end
