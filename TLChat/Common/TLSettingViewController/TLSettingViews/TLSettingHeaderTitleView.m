//
//  TLSettingHeaderTitleView.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingHeaderTitleView.h"

@implementation TLSettingHeaderTitleView

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(15);
            make.right.mas_equalTo(self.contentView).mas_offset(-15);
            make.bottom.mas_equalTo(self.contentView).mas_offset(-5.0f);
        }];
    }
    return self;
}

- (void) setText:(NSString *)text
{
    _text = text;
    [self.titleLabel setText:text];
}

#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [_titleLabel setFont:[UIFont fontSettingHeaderAndFooterTitle]];
        [_titleLabel setNumberOfLines:0];
    }
    return _titleLabel;
}

@end
