//
//  TLConversationCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationCell.h"
#import "NSDate+TLChat.h"
#import "TLMacros.h"
#import "NSFileManager+TLChat.h"
#import <TLTabBarController/TLBadge.h>

@interface TLConversationCell()

/// 头像
@property (nonatomic, strong) UIImageView *avatarView;

/// 用户名
@property (nonatomic, strong) UILabel *nameLabel;

/// 正文
@property (nonatomic, strong) UILabel *detailLabel;

/// 时间
@property (nonatomic, strong) UILabel *timeLabel;

/// 免打扰标识
@property (nonatomic, strong) UIImageView *remindImageView;

/// 气泡
@property (nonatomic, strong) TLBadge *badge;

@end

@implementation TLConversationCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return HEIGHT_CONVERSATION_CELL;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setConversation:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    self.bottomSeperatorStyle = (indexPath.row == count - 1 ? TLConversationCellSeperatorStyleFill : TLConversationCellSeperatorStyleDefault);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initViews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.bottomSeperatorStyle == TLConversationCellSeperatorStyleDefault) {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
}

- (void)setBottomSeperatorStyle:(TLConversationCellSeperatorStyle)bottomSeperatorStyle
{
    _bottomSeperatorStyle = bottomSeperatorStyle;
    [self setNeedsDisplay];
}

#pragma mark - Public Methods
- (void)setConversation:(TLConversation *)conversation
{
    _conversation = conversation;
    
    if (conversation.avatarPath.length > 0) {
        NSString *path = [NSFileManager pathUserAvatar:conversation.avatarPath];
        [self.avatarView setImage:[UIImage imageNamed:path]];
    }
    else {
        [self.avatarView tt_setImageWithURL:TLURL(conversation.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    [self.nameLabel setText:conversation.partnerName];
    [self.detailLabel setText:conversation.content];
    [self.timeLabel setText:conversation.date.conversaionTimeInfo];
    [self.remindImageView setHidden:NO];
    switch (conversation.remindType) {
        case TLMessageRemindTypeNormal:
            [self.remindImageView setHidden:YES];
            break;
        case TLMessageRemindTypeClosed:
            [self.remindImageView setImage:[UIImage imageNamed:@"conv_remind_close"]];
            break;
        case TLMessageRemindTypeNotLook:
            [self.remindImageView setImage:[UIImage imageNamed:@"conv_remind_notlock"]];
            break;
        case TLMessageRemindTypeUnlike:
            [self.remindImageView setImage:[UIImage imageNamed:@"conv_remind_unlike"]];
            break;
    }
    
    // 更新气泡
    [self updateBadge];
}

/// 标记为未读
- (void)markAsUnread
{
    self.conversation.unreadCount = 1;
    [self updateBadge];
}

/// 标记为已读
- (void)markAsRead
{
    self.conversation.unreadCount = 0;
    [self updateBadge];
}

- (void)updateBadge
{
    CGSize size = [TLBadge badgeSizeWithValue:self.conversation.badgeValue];
    [self.badge setBadgeValue:self.conversation.badgeValue];
    [self.badge mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

#pragma mark - # Overide
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.badge.backgroundColor = [UIColor redColor];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.badge.backgroundColor = [UIColor redColor];
}

#pragma mark - # Private Methods
- (void)p_initViews
{
    // 头像
    self.avatarView = self.contentView.addImageView(1001)
    .cornerRadius(3.0f)
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(- 10);
    })
    .view;
    [self.avatarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.avatarView.mas_height);
    }];

    // 时间
    self.timeLabel = self.contentView.addLabel(2001)
    .font([UIFont fontConversationTime]).textColor([UIColor colorTextGray1])
    .masonry(^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarView).mas_offset(2);
        make.right.mas_equalTo(self.contentView).mas_offset(-9.5);
    })
    .view;
    [self.timeLabel setContentCompressionResistancePriority:300 forAxis:UILayoutConstraintAxisHorizontal];
    
    // 用户名
    self.nameLabel = self.contentView.addLabel(1002)
    .font([UIFont fontConversationUsername])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.avatarView).mas_offset(1.5);
        make.right.mas_lessThanOrEqualTo(self.timeLabel.mas_left).mas_offset(-5);
    })
    .view;
    [self.nameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    
    // 免打扰标识
    self.remindImageView = self.contentView.addImageView(2002)
    .alpha(0.4)
    .masonry(^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel);
        make.bottom.mas_equalTo(self.avatarView);
    })
    .view;
    [self.remindImageView setContentCompressionResistancePriority:310 forAxis:UILayoutConstraintAxisHorizontal];
    
    // 正文
    self.detailLabel = self.contentView.addLabel(3)
    .font([UIFont fontConversationDetail])
    .textColor([UIColor colorTextGray])
    .masonry(^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(self.nameLabel);
        make.right.mas_lessThanOrEqualTo(self.remindImageView.mas_left);
    })
    .view;
    [self.detailLabel setContentCompressionResistancePriority:110 forAxis:UILayoutConstraintAxisHorizontal];
    
    [self layoutIfNeeded];
    // 气泡
    self.badge = [[TLBadge alloc] init];
    [self.contentView addSubview:self.badge];
    [self.badge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.avatarView.mas_right).mas_offset(-1.5);
        make.centerY.mas_equalTo(self.avatarView.mas_top).mas_equalTo(1.5);
    }];
}

@end
