//
//  TLEmojiImageTitleItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiImageTitleItemCell.h"
#import "UIImage+Color.h"

@interface TLEmojiImageTitleItemCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *label;

@end

@implementation TLEmojiImageTitleItemCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setHighlightImage:[UIImage imageNamed:@"emoji_hl_background"]];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label];
        [self p_addMasonry];
    }
    return self;
}

- (void)setEmojiItem:(TLEmoji *)emojiItem
{
    [super setEmojiItem:emojiItem];
    [self.imageView setImage:emojiItem.emojiPath == nil ? nil : [UIImage imageNamed:emojiItem.emojiPath]];
    [self.label setText:emojiItem.emojiName];
}

- (CGRect)displayBaseRect
{
    CGRect rect = self.imageView.frame;
    rect.origin.x += self.x;
    rect.origin.y += self.y;
    return rect;
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.imageView).mas_offset(UIEdgeInsetsMake(-3, -3, -3, -3));
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(self).mas_offset(-8);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(4);
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

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        [_label setFont:[UIFont systemFontOfSize:12.0f]];
        [_label setTextColor:[UIColor grayColor]];
        [_label setTextAlignment:NSTextAlignmentCenter];
    }
    return _label;
}

@end
