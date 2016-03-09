//
//  TLEmojiBaseCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiBaseCell.h"

@implementation TLEmojiBaseCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark - Event Response -
- (void)bgButtonTouchDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchInEmojiItem:point:)]) {
        CGPoint point = CGPointMake(self.x + self.width / 2, self.y + self.height / 2);
        [_delegate touchInEmojiItem:self.emojiItem point:point];
    }
}

- (void)bgButtonTouchUpInside
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectedEmojiItem:)]) {
        [_delegate selectedEmojiItem:self.emojiItem];
    }
}

- (void)bgButtonTouchCancel
{
    if (_delegate && [_delegate respondsToSelector:@selector(cancelTouchEmojiItem:)]) {
        [_delegate cancelTouchEmojiItem:self.emojiItem];
    }
}

#pragma mark - Getter -
- (UIButton *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIButton alloc] init];
        [_bgView.layer setMasksToBounds:YES];
        [_bgView.layer setCornerRadius:5.0f];
        [_bgView addTarget:self action:@selector(bgButtonTouchDown) forControlEvents:UIControlEventTouchDown];
        [_bgView addTarget:self action:@selector(bgButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addTarget:self action:@selector(bgButtonTouchCancel) forControlEvents:UIControlEventTouchUpOutside];
        [_bgView addTarget:self action:@selector(bgButtonTouchCancel) forControlEvents:UIControlEventTouchCancel];
    }
    return _bgView;
}

@end
