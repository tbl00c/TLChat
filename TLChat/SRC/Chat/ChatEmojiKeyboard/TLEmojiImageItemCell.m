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
        [self p_addMasonry];
    }
    return self;
}

- (void)setEmojiItem:(TLEmoji *)emojiItem
{
    _emojiItem = emojiItem;
    [self.imageView setImage:emojiItem.iconPath == nil ? nil : [UIImage imageNamed:emojiItem.iconPath]];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
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
