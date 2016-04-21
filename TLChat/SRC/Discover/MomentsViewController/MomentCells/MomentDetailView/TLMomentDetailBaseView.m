//
//  TLMomentDetailBaseView.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentDetailBaseView.h"

@implementation TLMomentDetailBaseView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setDetail:(TLMomentDetail *)detail
{
    [self.titleLabel setText:detail.text];
}

#pragma mark - # Getter -
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_titleLabel setNumberOfLines:0];
    }
    return _titleLabel;
}

@end
