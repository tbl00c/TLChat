//
//  TLExpressionPublicCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionPublicCell.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Color.h"

@interface TLExpressionPublicCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLExpressionPublicCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self p_addMasonry];
    }
    return self;
}

- (void)setGroup:(TLEmojiGroup *)group
{
    _group = group;
    [self.titleLabel setText:group.groupName];
    UIImage *image = [UIImage imageNamed:group.groupIconPath];
    if (image) {
        [self.imageView setImage:image];
    }
    else {
        [self.imageView sd_setImageWithURL:TLURL(group.groupIconURL) placeholderImage:[UIImage imageWithColor:[UIColor colorGrayBG]]];
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(7.0f);
        make.width.mas_lessThanOrEqualTo(self.contentView);
    }];
}

#pragma mark - # Getter
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setUserInteractionEnabled:NO];
        [_imageView.layer setMasksToBounds:YES];
        [_imageView.layer setCornerRadius:5.0f];
        [_imageView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_imageView.layer setBorderColor:[UIColor colorGrayLine].CGColor];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _titleLabel;
}

@end
