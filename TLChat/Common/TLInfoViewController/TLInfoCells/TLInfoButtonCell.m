//
//  TLInfoButtonCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLInfoButtonCell.h"
#import "UIImage+Color.h"

@interface TLInfoButtonCell ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation TLInfoButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setSeparatorInset:UIEdgeInsetsMake(0, WIDTH_SCREEN / 2, 0, WIDTH_SCREEN / 2)];
        [self setLayoutMargins:UIEdgeInsetsMake(0, WIDTH_SCREEN / 2, 0, WIDTH_SCREEN / 2)];
        [self.contentView addSubview:self.button];
        [self p_addMasonry];
    }
    return self;
}

- (void)setInfo:(TLInfo *)info
{
    _info = info;
    [self.button setTitle:info.title forState:UIControlStateNormal];
    [self.button setBackgroundColor:info.buttonColor];
    [self.button setBackgroundImage:[UIImage imageWithColor:info.buttonHLColor] forState:UIControlStateHighlighted];
    [self.button setTitleColor:info.titleColor forState:UIControlStateNormal];
    [self.button.layer setBorderColor:info.buttonBorderColor.CGColor];
}

#pragma mark - Event Response -
- (void)cellButtonDown:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(infoButtonCellClicked:)]) {
        [_delegate infoButtonCellClicked:self.info];
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.top.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView).multipliedBy(0.92);
        make.height.mas_equalTo(self.contentView).multipliedBy(0.78);
    }];
}

#pragma mark - Getter -
- (UIButton *)button
{
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        [_button.layer setMasksToBounds:YES];
        [_button.layer setCornerRadius:4.0f];
        [_button.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_button addTarget:self action:@selector(cellButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
