
//
//  TLEmojiFaceItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiFaceItemCell.h"

@interface TLEmojiFaceItemCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLEmojiFaceItemCell

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
    [super setEmojiItem:emojiItem];
    [self.imageView setImage:emojiItem.emojiName == nil ? nil : [UIImage imageNamed:emojiItem.emojiName]];
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
