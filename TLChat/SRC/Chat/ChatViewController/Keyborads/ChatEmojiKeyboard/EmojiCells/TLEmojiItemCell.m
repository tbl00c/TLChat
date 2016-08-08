//
//  TLEmojiItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiItemCell.h"

@interface TLEmojiItemCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation TLEmojiItemCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.label];
        [self p_addMasonry];
    }
    return self;
}

- (void)setEmojiItem:(TLEmoji *)emojiItem
{
    [super setEmojiItem:emojiItem];
    [self.label setText:emojiItem.emojiName];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

#pragma mark - Getter -
- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        [_label setFont:[UIFont systemFontOfSize:25.0f]];
    }
    return _label;
}

@end
