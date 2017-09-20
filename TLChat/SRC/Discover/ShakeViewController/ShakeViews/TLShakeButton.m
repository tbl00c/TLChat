//
//  TLShakeButton.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLShakeButton.h"

@interface TLShakeButton ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation TLShakeButton

- (id)initWithType:(TLShakeButtonType)type title:(NSString *)title iconPath:(NSString *)iconPath iconHLPath:(NSString *)iconHLPath
{
    if (self = [super init]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.textLabel];
        [self p_addMasonry];
        self.type = type;
        self.title = title;
        self.iconPath = iconPath;
        self.iconHLPath = iconHLPath;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.textLabel setText:title];
}

- (void)setIconPath:(NSString *)iconPath
{
    _iconPath = iconPath;
    [self.iconImageView setImage:[UIImage imageNamed:iconPath]];
}

- (void)setIconHLPath:(NSString *)iconHLPath
{
    _iconHLPath = iconHLPath;
    [self.iconImageView setHighlightedImage:[UIImage imageNamed:iconHLPath]];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self.iconImageView setHighlighted:selected];
    [self.textLabel setHighlighted:selected];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.textLabel.mas_top).mas_offset(-8);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_top);
    }];
}

#pragma mark - Getter -
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [_textLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [_textLabel setTextColor:[UIColor whiteColor]];
        [_textLabel setHighlightedTextColor:[UIColor colorGreenDefault]];
    }
    return _textLabel;
}

@end
