//
//  TLChatFileCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatFileCell.h"
#import "NSFileManager+TLChat.h"
#import "TLMacros.h"

@interface TLChatFileCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLChatFileCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self p_addMasonry];
    }
    return self;
}

- (void)setMessage:(TLMessage *)message
{
    _message = message;
    if (message.messageType == TLMessageTypeImage) {
        if ([(TLImageMessage *)message imagePath].length > 0) {
            NSString *imagePath = [NSFileManager pathUserChatImage:[(TLImageMessage *)message imagePath]];
            [self.imageView setImage:[UIImage imageNamed:imagePath]];
        }
        else if ([(TLImageMessage *)message imageURL].length > 0) {
            [self.imageView tt_setImageWithURL:TLURL([(TLImageMessage *)message imageURL]) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
        }
        else {
            [self.imageView setImage:nil];
        }
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - Getter -
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
