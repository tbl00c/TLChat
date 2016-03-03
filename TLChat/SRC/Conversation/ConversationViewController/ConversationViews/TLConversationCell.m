//
//  TLConversationCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+TLChat.h"

#define     CONV_SPACE_X            10.0f
#define     REDPOINT_WIDTH          10.0f

@interface TLConversationCell()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *remindImageView;

@property (nonatomic, strong) UIView *redPointView;

@end

@implementation TLConversationCell

@synthesize isRead = _isRead;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftSeparatorSpace = CONV_SPACE_X;
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.remindImageView];
        [self.contentView addSubview:self.redPointView];
        
        [self addMasonry];
    }
    return self;
}

- (void) addMasonry
{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CONV_SPACE_X);
        make.top.mas_equalTo(CONV_SPACE_X);
        make.bottom.mas_equalTo(- CONV_SPACE_X);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.usernameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(CONV_SPACE_X);
        make.top.mas_equalTo(self.avatarImageView).mas_offset(1.5);
        make.right.mas_lessThanOrEqualTo(self.timeLabel.mas_left).mas_offset(-5);
    }];
    
    [self.detailLabel setContentCompressionResistancePriority:110 forAxis:UILayoutConstraintAxisHorizontal];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.avatarImageView).mas_offset(-1.3);
        make.left.mas_equalTo(self.usernameLabel);
        make.right.mas_lessThanOrEqualTo(self.remindImageView.mas_left);
    }];
    
    [self.timeLabel setContentCompressionResistancePriority:300 forAxis:UILayoutConstraintAxisHorizontal];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.usernameLabel);
        make.right.mas_equalTo(self.contentView).mas_offset(-CONV_SPACE_X);
    }];
    
    [self.remindImageView setContentCompressionResistancePriority:310 forAxis:UILayoutConstraintAxisHorizontal];
    [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel);
        make.centerY.mas_equalTo(self.detailLabel);
    }];
    
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.avatarImageView.mas_right).mas_offset(-2);
        make.centerY.mas_equalTo(self.avatarImageView.mas_top).mas_offset(2);
        make.width.and.height.mas_equalTo(REDPOINT_WIDTH);
    }];
}

#pragma mark - Public Methods
- (void) setConversation:(TLConversation *)conversation
{
    _conversation = conversation;
    
    if (conversation.avatarPath) {
        [self.avatarImageView setImage:[UIImage imageNamed:conversation.avatarPath]];
    }
    else {
        [self.avatarImageView sd_setImageWithURL:TLURL(conversation.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    [self.usernameLabel setText:conversation.username];
    [self.detailLabel setText:conversation.messageDetail];
    [self.timeLabel setText:conversation.date.conversaionTimeInfo];
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
    
    self.isRead ? [self markAsRead] : [self markAsUnread];
}


/**
 *  标记为未读
 */
- (void) markAsUnread
{
    self.isRead = NO;
    if (_conversation) {
        switch (_conversation.clueType) {
            case TLClueTypePointWithNumber:
                
                break;
            case TLClueTypePoint:
                [self.redPointView setHidden:NO];
                break;
            case TLClueTypeNone:
                
                break;
            default:
                break;
        }
    }
}

/**
 *  标记为已读
 */
- (void) markAsRead
{
    self.isRead = YES;
    if (_conversation) {
        switch (_conversation.clueType) {
            case TLClueTypePointWithNumber:
                
                break;
            case TLClueTypePoint:
                [self.redPointView setHidden:YES];
                break;
            case TLClueTypeNone:
                
                break;
            default:
                break;
        }
    }
}

#pragma mark - Setter
- (void) setIsRead:(BOOL)isRead
{
    self.conversation.isRead = isRead;
}

- (BOOL) isRead
{
    return self.conversation.isRead;
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
        [_usernameLabel setFont:[UIFont fontConversationUsername]];
    }
    return _usernameLabel;
}

- (UILabel *) detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setFont:[UIFont fontConversationDetail]];
        [_detailLabel setTextColor:[UIColor colorConversationDetail]];
    }
    return _detailLabel;
}

- (UILabel *) timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont fontConversationTime]];
        [_timeLabel setTextColor:[UIColor colorConversationTime]];
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

- (UIView *) redPointView
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
