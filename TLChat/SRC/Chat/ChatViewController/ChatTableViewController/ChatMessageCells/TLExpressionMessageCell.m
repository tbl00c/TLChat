//
//  TLExpressionMessageCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionMessageCell.h"
#import <UIImage+GIF.h>

@interface TLExpressionMessageCell ()

@property (nonatomic, strong) UIImageView *msgImageView;

@end

@implementation TLExpressionMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgImageView];
    }
    return self;
}

- (void)setMessage:(TLExpressionMessage *)message
{
    [self.msgImageView setAlpha:1.0];       // 取消长按效果
    TLMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];

    [self.msgImageView setImage:[UIImage imageNamed:message.path]];
    NSData *data = [NSData dataWithContentsOfFile:message.path];
    [self.msgImageView setImage:[UIImage sd_animatedGIFWithData:data]];
    
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == TLMessageOwnerTypeSelf) {
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(5);
                make.right.mas_equalTo(self.messageBackgroundView).mas_offset(-10);
            }];
        }
        else if (message.ownerTyper == TLMessageOwnerTypeFriend){
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(5);
                make.left.mas_equalTo(self.messageBackgroundView).mas_offset(10);
            }];
        }
    }
    [self.msgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(message.messageFrame.contentSize);
    }];
}

#pragma mark - Event Response -
- (void)longPressMsgBGView
{
    [self.msgImageView setAlpha:0.7];   // 比较low的选中效果
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellLongPress:rect:)]) {
        CGRect rect = self.msgImageView.frame;
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
- (UIImageView *)msgImageView
{
    if (_msgImageView == nil) {
        _msgImageView = [[UIImageView alloc] init];
        [_msgImageView setUserInteractionEnabled:YES];
        
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMsgBGView)];
        [_msgImageView addGestureRecognizer:longPressGR];
        
        UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTabpMsgBGView)];
        [doubleTapGR setNumberOfTapsRequired:2];
        [_msgImageView addGestureRecognizer:doubleTapGR];
    }
    return _msgImageView;
}

@end
