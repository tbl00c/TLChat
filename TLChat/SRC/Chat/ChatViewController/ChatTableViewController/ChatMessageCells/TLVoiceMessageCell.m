//
//  TLVoiceMessageCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/5/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLVoiceMessageCell.h"
#import "TLVoiceImageView.h"

@interface TLVoiceMessageCell ()

@property (nonatomic, strong) UILabel *voiceTimeLabel;

@property (nonatomic, strong) TLVoiceImageView *voiceImageView;

@end

@implementation TLVoiceMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.voiceTimeLabel];
        [self.messageBackgroundView addSubview:self.voiceImageView];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMsgBGView)];
        [self.messageBackgroundView addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)setMessage:(TLVoiceMessage *)message
{
//    if (self.message && [self.message.messageID isEqualToString:message.messageID]) {
//        return;
//    }
    TLMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    
    [self.voiceTimeLabel setText:[NSString stringWithFormat:@"%.0lf\"\n", message.time]];
    
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == TLMessageOwnerTypeSelf) {
            [self.voiceImageView setIsFromMe:YES];
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_sender_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_sender_bgHL"]];
            
            [self.voiceTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.messageBackgroundView.mas_left);
                make.top.mas_equalTo(self.messageBackgroundView.mas_centerY).mas_offset(-5);
            }];
            [self.voiceImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-13);
                make.centerY.mas_equalTo(self.avatarButton);
            }];
        }
        else if (message.ownerTyper == TLMessageOwnerTypeFriend){
            [self.voiceImageView setIsFromMe:NO];
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_receiver_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_receiver_bgHL"]];
            [self.voiceTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.messageBackgroundView.mas_right);
                make.top.mas_equalTo(self.messageBackgroundView.mas_centerY).mas_offset(-5);
            }];
            [self.voiceImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(13);
                make.centerY.mas_equalTo(self.avatarButton);
            }];
        }
    }
    [self.messageBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(message.messageFrame.contentSize);
    }];
    
    message.playStatus == TLVoicePlayStatusPlaying ? [self.voiceImageView startPlayingAnimation] : [self.voiceImageView stopPlayingAnimation];
}

#pragma mark - # Private Methods
- (void)didTapMsgBGView
{
    [self.voiceImageView startPlayingAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellTap:)]) {
        [self.delegate messageCellTap:self.message];
    }
}

#pragma mark - # Getter
- (UILabel *)voiceTimeLabel
{
    if (_voiceTimeLabel == nil) {
        _voiceTimeLabel = [[UILabel alloc] init];
        [_voiceTimeLabel setTextColor:[UIColor grayColor]];
        [_voiceTimeLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _voiceTimeLabel;
}

- (TLVoiceImageView *)voiceImageView
{
    if (_voiceImageView == nil) {
        _voiceImageView = [[TLVoiceImageView alloc] init];
    }
    return _voiceImageView;
}

@end
