//
//  TLTextMessageCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTextMessageCell.h"

#define     MSG_SPACE_TOP       12
#define     MSG_SPACE_BTM       10
#define     MSG_SPACE_LEFT      10
#define     MSG_SPACE_RIGHT     15

@interface TLTextMessageCell ()

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation TLTextMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}

- (void)setMessage:(TLMessage *)message
{
    [super setMessage:message];
    [self.messageLabel setText:message.text];
    
    if (message.ownerTyper == TLMessageOwnerTypeSelf) {
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.messageBackgroundView).mas_offset(-MSG_SPACE_RIGHT);
            make.top.mas_equalTo(self.messageBackgroundView).mas_offset(MSG_SPACE_TOP);
            make.width.mas_lessThanOrEqualTo(200);
        }];
        [self.messageBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.messageLabel).mas_offset(-MSG_SPACE_RIGHT);
            make.bottom.mas_equalTo(self.messageLabel).mas_offset(MSG_SPACE_BTM);
        }];
    }
    else if (message.ownerTyper == TLMessageOwnerTypeOther){
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.messageBackgroundView).mas_offset(MSG_SPACE_RIGHT);
            make.top.mas_equalTo(self.messageBackgroundView).mas_offset(MSG_SPACE_TOP);
            make.width.mas_lessThanOrEqualTo(200);
        }];
        [self.messageBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.messageLabel).mas_offset(MSG_SPACE_LEFT);
            make.bottom.mas_equalTo(self.messageLabel).mas_offset(MSG_SPACE_BTM);
        }];
    }
}

#pragma mark - Getter -
- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        [_messageLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_messageLabel setNumberOfLines:0];
    }
    return _messageLabel;
}

@end
