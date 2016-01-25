//
//  TLConversationCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationCell.h"

#import <UIImageView+WebCache.h>

#define     SPACE_X         10.0f

@interface TLConversationCell()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *remindImageView;

@end

@implementation TLConversationCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.avatarImageView];
        [self addSubview:self.usernameLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.remindImageView];
        
        [self addMasonry];
    }
    return self;
}

- (void) addMasonry
{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_X);
        make.centerY.mas_equalTo(self.contentView);
        make.width.and.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.7);
    }];
    
    [self.usernameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(SPACE_X);
        make.top.mas_equalTo(self.avatarImageView).mas_offset(2.0);
        make.right.mas_lessThanOrEqualTo(self.timeLabel.mas_left).mas_offset(-5);
    }];
    
    [self.detailLabel setContentCompressionResistancePriority:110 forAxis:UILayoutConstraintAxisHorizontal];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.avatarImageView).mas_offset(-1.5);
        make.left.mas_equalTo(self.usernameLabel);
        make.right.mas_lessThanOrEqualTo(self.remindImageView.mas_left);
    }];
    
    [self.timeLabel setContentCompressionResistancePriority:300 forAxis:UILayoutConstraintAxisHorizontal];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.usernameLabel);
        make.right.mas_equalTo(self.contentView).mas_offset(-SPACE_X);
    }];
    
    [self.remindImageView setContentCompressionResistancePriority:310 forAxis:UILayoutConstraintAxisHorizontal];
    [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel);
        make.centerY.mas_equalTo(self.detailLabel);
    }];
}

- (void) setConversation:(TLConversation *)conversation
{
    _conversation = conversation;
    
    [self.avatarImageView sd_setImageWithURL:TLURL(conversation.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_AVATAR]];
    [self.usernameLabel setText:conversation.username];
    [self.detailLabel setText:conversation.messageDetail];
    [self.timeLabel setText:@"11:11"];
    switch (conversation.remindType) {
        case TLMessageRemindTypeNormal:
            [self.remindImageView setHidden:YES];
            break;
        case TLMessageRemindTypeClosed:
            [self.remindImageView setHidden:NO];
            [self.remindImageView setImage:[UIImage imageNamed:@"conv_remind_close"]];
            break;
        case TLMessageRemindTypeNotLook:
            [self.remindImageView setHidden:NO];
            [self.remindImageView setImage:[UIImage imageNamed:@"conv_remind_notlock"]];
            break;
        case TLMessageRemindTypeUnlike:
            [self.remindImageView setHidden:NO];
            [self.remindImageView setImage:[UIImage imageNamed:@"conv_remind_unlike"]];
            break;
        default:
            break;
    }
}

#pragma mark - Getter
- (UIImageView *) avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:5.0f];
    }
    return _avatarImageView;
}

- (UILabel *) usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[TLFontUtility fontConversationUsername]];
    }
    return _usernameLabel;
}

- (UILabel *) detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setFont:[TLFontUtility fontConversationDetail]];
        [_detailLabel setTextColor:[TLColorUtility colorConversationDetail]];
    }
    return _detailLabel;
}

- (UILabel *) timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[TLFontUtility fontConversationTime]];
        [_timeLabel setTextColor:[TLColorUtility colorConversationTime]];
    }
    return _timeLabel;
}

- (UIImageView *) remindImageView
{
    if (_remindImageView == nil) {
        _remindImageView = [[UIImageView alloc] init];
        [_remindImageView setAlpha:0.4];
    }
    return _remindImageView;
}

@end
