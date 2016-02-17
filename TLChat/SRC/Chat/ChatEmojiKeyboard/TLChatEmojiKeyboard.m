//
//  TLChatEmojiKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatEmojiKeyboard.h"

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

- (void) showInView:(UIView *)view withAnimation:(BOOL)animation;
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardWillShow:)]) {
        [_delegate chatKeyboardWillShow:self];
    }
    [self setFrame:CGRectMake(0, view.height, view.width, HEIGHT_CHAT_KEYBOARD)];
    [view addSubview:self];
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.y = view.height - self.height;
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
        self.y = view.height - self.height;
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
            self.y = self.superview.height;
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
