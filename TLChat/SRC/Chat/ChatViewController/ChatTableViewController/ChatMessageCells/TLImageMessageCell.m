//
//  TLImageMessageCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/14.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLImageMessageCell.h"
#import "TLMessageImageView.h"

#define     MSG_SPACE_TOP       2

@interface TLImageMessageCell ()

@property (nonatomic, strong) TLMessageImageView *msgImageView;

@end

@implementation TLImageMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgImageView];
    }
    return self;
}

- (void)setMessage:(TLImageMessage *)message
{
    [self.msgImageView setAlpha:1.0];       // 取消长按效果
    if (self.message && [self.message.messageID isEqualToString:message.messageID]) {
        return;
    }
    TLMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    
    if ([message imagePath]) {
        NSString *imagePath = [NSFileManager pathUserChatImage:[message imagePath]];
        [self.msgImageView setThumbnailPath:imagePath highDefinitionImageURL:[message imagePath]];
    }
    else {
        [self.msgImageView setThumbnailPath:nil highDefinitionImageURL:[message imagePath]];
    }

    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == TLMessageOwnerTypeSelf) {
            [self.msgImageView setBackgroundImage:[UIImage imageNamed:@"message_sender_bg"]];
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageBackgroundView);
                make.right.mas_equalTo(self.messageBackgroundView);
            }];
        }
        else if (message.ownerTyper == TLMessageOwnerTypeFriend){
            [self.msgImageView setBackgroundImage:[UIImage imageNamed:@"message_receiver_bg"]];
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageBackgroundView);
                make.left.mas_equalTo(self.messageBackgroundView);
            }];
        }
    }
    [self.msgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(message.messageFrame.contentSize);
    }];
}

#pragma mark - Event Response -
- (void)tapMessageView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellTap:)]) {
        [self.delegate messageCellTap:self.message];
    }
}

- (void)longPressMsgBGView
{
    [self.msgImageView setAlpha:0.7];   // 比较low的选中效果
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellLongPress:rect:)]) {
        CGRect rect = self.msgImageView.frame;
        rect.size.height -= 10;     // 北京图片底部空白区域
        [self.delegate messageCellLongPress:self.message rect:rect];
    }
}

- (void)doubleTabpMsgBGView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellDoubleClick:)]) {
        [self.delegate messageCellDoubleClick:self.message];
    }
}

#pragma mark - Getter -
- (TLMessageImageView *)msgImageView
{
    if (_msgImageView == nil) {
        _msgImageView = [[TLMessageImageView alloc] init];
        [_msgImageView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMessageView)];
        [_msgImageView addGestureRecognizer:tapGR];
        
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMsgBGView)];
        [_msgImageView addGestureRecognizer:longPressGR];
        
        UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTabpMsgBGView)];
        [doubleTapGR setNumberOfTapsRequired:2];
        [_msgImageView addGestureRecognizer:doubleTapGR];
    }
    return _msgImageView;
}

@end
