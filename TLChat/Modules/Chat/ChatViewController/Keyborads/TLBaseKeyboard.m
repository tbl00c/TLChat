//
//  TLBaseKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/8/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseKeyboard.h"

@implementation TLBaseKeyboard

#pragma mark - # Public Methods
- (void)showWithAnimation:(BOOL)animation
{
    [self showInView:[UIApplication sharedApplication].keyWindow withAnimation:animation];
}

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation
{
    if (_isShow) {
        return;
    }
    _isShow = YES;
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillShow:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillShow:self animated:animation];
    }
    [view addSubview:self];
    CGFloat keyboardHeight = [self keyboardHeight];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(view);
        make.height.mas_equalTo(keyboardHeight);
        make.bottom.mas_equalTo(view).mas_offset(keyboardHeight);
    }];
    [view layoutIfNeeded];
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(view);
            }];
            [view layoutIfNeeded];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:view.height - self.y];
            }
        } completion:^(BOOL finished) {
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
            }
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(view);
        }];
        [view layoutIfNeeded];
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
            [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
        }
    }
}

- (void)dismissWithAnimation:(BOOL)animation
{
    if (!_isShow) {
        if (!animation) {
            [self removeFromSuperview];
        }
        return;
    }
    _isShow = NO;
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillDismiss:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillDismiss:self animated:animation];
    }
    if (animation) {
        CGFloat keyboardHeight = [self keyboardHeight];
        [UIView animateWithDuration:0.3 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.superview).mas_offset(keyboardHeight);
            }];
            [self.superview layoutIfNeeded];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:self.superview.height - self.y];
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
            }
        }];
    }
    else {
        [self removeFromSuperview];
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
            [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
        }
    }
}

- (void)reset
{
    
}

#pragma mark - # ZZKeyboardProtocol
- (CGFloat)keyboardHeight
{
    return HEIGHT_CHAT_KEYBOARD + SAFEAREA_INSETS_BOTTOM;
}


@end
