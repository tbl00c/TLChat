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

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.bgView.mas_width);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self.contentView).mas_offset(3);
        make.right.mas_equalTo(self.contentView).mas_offset(-3);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.contentView);
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
