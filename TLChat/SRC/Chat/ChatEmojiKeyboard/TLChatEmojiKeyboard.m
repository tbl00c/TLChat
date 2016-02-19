//
//  TLChatEmojiKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatEmojiKeyboard.h"
#import "TLChatMacros.h"

static TLChatEmojiKeyboard *emojiKB;

@implementation TLChatEmojiKeyboard

+ (TLChatEmojiKeyboard *)keyboard
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        emojiKB = [[TLChatEmojiKeyboard alloc] init];
    });
    return emojiKB;
}

- (id) init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor blueColor]];
    }
    return self;
}

#pragma mark - Public Methods -
- (void) showInView:(UIView *)view withAnimation:(BOOL)animation;
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardWillShow:)]) {
        [_delegate chatKeyboardWillShow:self];
    }
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(view);
        make.height.mas_equalTo(HEIGHT_CHAT_KEYBOARD);
        make.bottom.mas_equalTo(view).mas_offset(HEIGHT_CHAT_KEYBOARD);
    }];
    [view layoutIfNeeded];
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(view);
            }];
            [view layoutIfNeeded];
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [_delegate chatKeyboard:self didChangeHeight:view.height - self.y];
            }
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidShow:)]) {
                [_delegate chatKeyboardDidShow:self];
            }
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(view);
        }];
        [view layoutIfNeeded];
        if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidShow:)]) {
            [_delegate chatKeyboardDidShow:self];
        }
    }
}

- (void) dismissWithAnimation:(BOOL)animation
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardWillDismiss:)]) {
        [_delegate chatKeyboardWillDismiss:self];
    }
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.superview).mas_offset(HEIGHT_CHAT_KEYBOARD);
            }];
            [self.superview layoutIfNeeded];
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [_delegate chatKeyboard:self didChangeHeight:self.superview.height - self.y];
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidDismiss:)]) {
                [_delegate chatKeyboardDidDismiss:self];
            }
        }];
    }
    else {
        [self removeFromSuperview];
        if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidDismiss:)]) {
            [_delegate chatKeyboardDidDismiss:self];
        }
    }
}


@end
