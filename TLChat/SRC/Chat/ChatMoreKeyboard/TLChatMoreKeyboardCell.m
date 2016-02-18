//
//  TLChatMoreKeyboardCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatMoreKeyboardCell.h"

@interface TLChatMoreKeyboardCell()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLChatMoreKeyboardCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self p_addMasonry];
    }
    return self;
}

- (void)setItem:(TLChatMoreKeyboardItem *)item
{
    _item = item;
    if (item == nil) {
        [self.titleLabel setHidden:YES];
        [self.imageView setHidden:YES];
        return;
    }
    [self.titleLabel setHidden:NO];
    [self.imageView setHidden:NO];
    [self.titleLabel setText:item.title];
    [self.imageView setImage:[UIImage imageNamed:item.imagePath]];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(2.0);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark - Getter -
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView.layer setMasksToBounds:YES];
        [_imageView.layer setCornerRadius:5.0f];
        [_imageView.layer setBorderWidth:0.5f];
        [_imageView.layer setBorderColor:[UIColor grayColor].CGColor];
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

@end
