
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

@property (nonatomic, strong) UILabel *label;

@end

@implementation TLEmojiFaceItemCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.imageView);
        }];
    }
    return self;
}

- (void)setEmojiItem:(TLExpressionModel *)emojiItem
{
    [super setEmojiItem:emojiItem];
    if ([emojiItem.eId isEqualToString:@"-1"]) {
        [self.imageView setHidden:NO];
        [self.label setHidden:YES];
        [self.imageView setImage:[UIImage imageNamed:@"emojiKB_emoji_delete"]];
    }
    else {
        if (emojiItem.type == TLEmojiTypeFace) {
            [self.imageView setHidden:NO];
            [self.label setHidden:YES];
            [self.imageView setImage:emojiItem.name == nil ? nil : [UIImage imageNamed:emojiItem.name]];
        }
        else {
            [self.imageView setHidden:YES];
            [self.label setHidden:NO];
            [self.label setText:emojiItem.name];
        }
    }
}

#pragma mark - # Getter
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        [_label setFont:[UIFont systemFontOfSize:28.0f]];
        [_label setTextAlignment:NSTextAlignmentCenter];
    }
    return _label;
}

@end
