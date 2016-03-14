//
//  TLImageMessageCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/14.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLImageMessageCell.h"
#import <UIImageView+WebCache.h>

#define     MSG_SPACE_TOP       2

@interface TLImageMessageCell ()

@property (nonatomic, strong) UIImageView *msgImageView;

@end

@implementation TLImageMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgImageView];
    }
    return self;
}

- (void)setMessage:(TLMessage *)message
{
    if (self.message && [self.message.messageID isEqualToString:message.messageID]) {
        return;
    }
    TLMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    if (message.imagePath) {
        NSString *imagePath = [NSFileManager pathUserChatAvatar:message.imagePath forUser:message.userID];
        [self.msgImageView setImage:[UIImage imageNamed:imagePath]];
    }
    else if (message.imageURL){
        [self.msgImageView sd_setImageWithURL:TLURL(message.imageURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    else {
        [self.msgImageView setImage:nil];
    }

    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == TLMessageOwnerTypeSelf) {
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageBackgroundView).mas_offset(MSG_SPACE_TOP);
                make.right.mas_equalTo(self.messageBackgroundView);
            }];
        }
        else if (message.ownerTyper == TLMessageOwnerTypeFriend){
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageBackgroundView).mas_equalTo(MSG_SPACE_TOP);
                make.left.mas_equalTo(self.messageBackgroundView);
            }];
        }
    }
    [self.msgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(message.frame.contentSize);
    }];
}


#pragma mark - Getter -
- (UIImageView *)msgImageView
{
    if (_msgImageView == nil) {
        _msgImageView = [[UIImageView alloc] init];
    }
    return _msgImageView;
}


@end
