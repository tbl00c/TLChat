//
//  TLChatBaseViewController+UIDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+UIDelegate.h"

@implementation TLChatBaseViewController (UIDelegate)

#pragma mark - Public Methods -
- (void)keyboardWillHide:(NSNotification *)notification
{
    if (curStatus == TLChatBarStatusEmoji || curStatus == TLChatBarStatusMore) {
        return;
    }
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (lastStatus == TLChatBarStatusMore || lastStatus == TLChatBarStatusEmoji) {
        if (keyboardFrame.size.height <= HEIGHT_CHAT_KEYBOARD) {
            return;
        }
    }
    else if (curStatus == TLChatBarStatusEmoji || curStatus == TLChatBarStatusMore) {
        return;
    }
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-keyboardFrame.size.height);
    }];
    [self.view layoutIfNeeded];
    [self.chatTableVC scrollToBottomWithAnimation:NO];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (lastStatus == TLChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:NO];
    }
    else if (lastStatus == TLChatBarStatusEmoji) {
        [self.emojiKeyboard dismissWithAnimation:NO];
    }
}

#pragma mark - Delegate -
//MARK: TLKeyboardDelegate
- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height
{
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-height);
    }];
    [self.view layoutIfNeeded];
    [self.chatTableVC scrollToBottomWithAnimation:NO];
}

- (void)chatKeyboardDidShow:(id)keyboard
{
    if (curStatus == TLChatBarStatusMore && lastStatus == TLChatBarStatusEmoji) {
        [self.emojiKeyboard dismissWithAnimation:NO];
    }
    else if (curStatus == TLChatBarStatusEmoji && lastStatus == TLChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:NO];
    }
}

//MARK: TLChatBarDelegate
- (void)chatBar:(TLChatBar *)chatBar changeStatusFrom:(TLChatBarStatus)fromStatus to:(TLChatBarStatus)toStatus
{
    if (curStatus == toStatus) {
        return;
    }
    lastStatus = fromStatus;
    curStatus = toStatus;
    if (toStatus == TLChatBarStatusInit) {
        if (fromStatus == TLChatBarStatusMore) {
            [self.moreKeyboard dismissWithAnimation:YES];
        }
        else if (fromStatus == TLChatBarStatusEmoji) {
            [self.emojiKeyboard dismissWithAnimation:YES];
        }
    }
    else if (toStatus == TLChatBarStatusKeyboard) {
        if (fromStatus == TLChatBarStatusMore) {
            [self.moreKeyboard mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.chatBar.mas_bottom);
                make.left.and.right.mas_equalTo(self.view);
                make.height.mas_equalTo(HEIGHT_CHAT_KEYBOARD);
            }];
        }
        else if (fromStatus == TLChatBarStatusEmoji) {
            [self.emojiKeyboard mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.chatBar.mas_bottom);
                make.left.and.right.mas_equalTo(self.view);
                make.height.mas_equalTo(HEIGHT_CHAT_KEYBOARD);
            }];
        }
    }
    else if (toStatus == TLChatBarStatusVoice) {
        if (fromStatus == TLChatBarStatusMore) {
            [self.moreKeyboard dismissWithAnimation:YES];
        }
        else if (fromStatus == TLChatBarStatusEmoji) {
            [self.emojiKeyboard dismissWithAnimation:YES];
        }
    }
    else if (toStatus == TLChatBarStatusEmoji) {
        if (fromStatus == TLChatBarStatusKeyboard) {
            [self.emojiKeyboard showInView:self.view withAnimation:YES];
        }
        else {
            [self.emojiKeyboard showInView:self.view withAnimation:YES];
        }
    }
    else if (toStatus == TLChatBarStatusMore) {
        if (fromStatus == TLChatBarStatusKeyboard) {
            [self.moreKeyboard showInView:self.view withAnimation:YES];
        }
        else {
            [self.moreKeyboard showInView:self.view withAnimation:YES];
        }
    }
}

- (void)chatBar:(TLChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height
{
    [self.chatTableVC scrollToBottomWithAnimation:NO];
}

@end
