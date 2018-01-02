//
//  TLEmojiDisplayView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/16.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiDisplayView.h"

#define     SIZE_TIPS    CGSizeMake(55, 100)

@interface TLEmojiDisplayView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *imageLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLEmojiDisplayView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SIZE_TIPS.width, SIZE_TIPS.height)]) {
        [self setImage:[UIImage imageNamed:@"emojiKB_tips"]];
        [self addSubview:self.imageLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self p_addMasonry];
    }
    return self;
}

- (void)displayEmoji:(TLExpressionModel *)emoji atRect:(CGRect)rect
{
    [self setRect:rect];
    [self setEmoji:emoji];
}

- (void)setEmoji:(TLExpressionModel *)emoji
{
    _emoji = emoji;
    if (emoji.type == TLEmojiTypeEmoji) {
        [self.imageLabel setHidden:NO];
        [self.imageView setHidden:YES];
        [self.titleLabel setHidden:YES];
        [self.imageLabel setText:emoji.name];
    }
    else if (emoji.type == TLEmojiTypeFace) {
        [self.imageLabel setHidden:YES];
        [self.imageView setHidden:NO];
        [self.titleLabel setHidden:NO];
        [self.imageView setImage:[UIImage imageNamed:emoji.name]];
        [self.titleLabel setText:[emoji.name substringWithRange:NSMakeRange(1, emoji.name.length - 2)]];
    }
}

- (void)setRect:(CGRect)rect
{
    [self setCenterX:rect.origin.x + rect.size.width / 2];
    [self setY:rect.origin.y + rect.size.height - self.height - 5];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(12);
        make.right.mas_equalTo(self).mas_equalTo(-12);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(self);
        make.width.mas_lessThanOrEqualTo(self);
    }];
    [self.imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.and.centerX.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self).mas_offset(12);
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

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_titleLabel setTextColor:[UIColor grayColor]];
    }
    return _titleLabel;
}

- (UILabel *)imageLabel
{
    if (_imageLabel == nil) {
        _imageLabel = [[UILabel alloc] init];
        [_imageLabel setTextAlignment:NSTextAlignmentCenter];
        [_imageLabel setHidden:YES];
        [_imageLabel setFont:[UIFont systemFontOfSize:30.0f]];
    }
    return _imageLabel;
}

@end
