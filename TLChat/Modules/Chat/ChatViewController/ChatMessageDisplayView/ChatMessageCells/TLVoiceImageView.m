//
//  TLVoiceImageView.m
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLVoiceImageView.h"

@interface TLVoiceImageView ()

@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) UIImage *normalImage;

@end

@implementation TLVoiceImageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setIsFromMe:YES];
    }
    return self;
}

- (void)setIsFromMe:(BOOL)isFromMe
{
    _isFromMe = isFromMe;
    if (isFromMe) {
        self.imagesArray = @[[UIImage imageNamed:@"message_voice_sender_playing_1"],
                             [UIImage imageNamed:@"message_voice_sender_playing_2"],
                             [UIImage imageNamed:@"message_voice_sender_playing_3"]];
        self.normalImage = [UIImage imageNamed:@"message_voice_sender_normal"];
    }
    else {
        self.imagesArray = @[[UIImage imageNamed:@"message_voice_receiver_playing_1"],
                             [UIImage imageNamed:@"message_voice_receiver_playing_2"],
                             [UIImage imageNamed:@"message_voice_receiver_playing_3"]];
        self.normalImage = [UIImage imageNamed:@"message_voice_receiver_normal"];
    }
    [self setImage:self.normalImage];
}

- (void)startPlayingAnimation
{
    self.animationImages = self.imagesArray;
    self.animationRepeatCount = 0;
    self.animationDuration = 1.0;
    [self startAnimating];
}

- (void)stopPlayingAnimation
{
    [self stopAnimating];
}

@end
