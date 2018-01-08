//
//  TLAddThirdPartFriendItem.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAddThirdPartFriendItem.h"

@interface TLAddThirdPartFriendItem ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation TLAddThirdPartFriendItem

- (id)initWithImagePath:(NSString *)imagePath andTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectZero]) {
        [self.iconImageView setImage:[UIImage imageNamed:imagePath]];
        [self.textLabel setText:title];
        [self addSubview:self.iconImageView];
        [self addSubview:self.textLabel];
        [self p_addMasonry];
    }
    return self;
}

#pragma mark - Pirvate Methods -
- (void)p_addMasonry
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.centerX.mas_equalTo(self);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_equalTo(5);
        make.centerX.mas_equalTo(self.iconImageView);
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
    }
    return _textLabel;
}

@end
