//
//  TLExpressionDetailCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailCell.h"
#import <UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import "UIImage+Color.h"

@interface TLExpressionDetailCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLExpressionDetailCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setEmoji:(TLEmoji *)emoji
{
    _emoji = emoji;
    [self.imageView sd_setImageWithURL:TLURL(emoji.emojiURL)];
}

#pragma mark - # Private Methods -
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - # Getter -
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView.layer setMasksToBounds:YES];
        [_imageView.layer setCornerRadius:3.0f];
    }
    return _imageView;
}

@end
