//
//  TLEmojiImageItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiImageItemCell.h"

@interface TLEmojiImageItemCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLEmojiImageItemCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self setHighlightImage:[UIImage imageNamed:@"emoji_hl_background"]];
        [self p_addMasonry];
    }
    return self;
}

- (CGRect)displayBaseRect
{
    CGRect rect = self.imageView.frame;
    rect.origin.x += self.x;
    rect.origin.y += self.y;
    return rect;
}

- (void)setEmojiItem:(TLEmoji *)emojiItem
{
    [super setEmojiItem:emojiItem];
    [self.imageView setImage:emojiItem.emojiPath == nil ? nil : [UIImage imageNamed:emojiItem.emojiPath]];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(52, 52));
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
