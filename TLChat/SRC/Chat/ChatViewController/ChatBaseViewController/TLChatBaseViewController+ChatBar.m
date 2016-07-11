//
//  TLChatBaseViewController+ChatBar.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+ChatBar.h"
#import "TLChatBaseViewController+DataDelegate.h"
#import "TLAudioRecorder.h"

@implementation TLChatBaseViewController (ChatBar)

#pragma mark - # Public Methods
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

#pragma mark - Delegate
//MARK: TLChatBarDelegate
- (void)chatBar:(TLChatBar *)chatBar sendText:(NSString *)text
{
    TLTextMessage *message = [[TLTextMessage alloc] init];
    message.fromUser = self.user;
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.text = text;
    [self sendMessage:message];
    if ([self.partner chat_userType] == TLChatUserTypeUser) {
        TLTextMessage *message1 = [[TLTextMessage alloc] init];
        message1.fromUser = self.partner;
        message1.ownerTyper = TLMessageOwnerTypeFriend;
        message1.text = text;
        [self sendMessage:message1];
    }
    else {
        for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
            TLTextMessage *message1 = [[TLTextMessage alloc] init];
            message1.friendID = [user chat_userID];
            message1.fromUser = user;
            message1.ownerTyper = TLMessageOwnerTypeFriend;
            message1.text = text;
            [self sendMessage:message1];
        }
    }
}

- (void)chatBarStartRecording:(TLChatBar *)chatBar
{
    [[TLAudioRecorder sharedRecorder] startRecording];
}

- (void)chatBarWillCancelRecording:(TLChatBar *)chatBar cancel:(BOOL)cancel
{
    cancel ? NSLog(@"will cancel") : NSLog(@"will continue");
}

- (void)chatBarFinishedRecoding:(TLChatBar *)chatBar
{
    [[TLAudioRecorder sharedRecorder] stopRecording];
    NSString *recFilePath = [TLAudioRecorder sharedRecorder].recFilePath;
    if ([[NSFileManager defaultManager] fileExistsAtPath:recFilePath]) {
        NSString *fileName = [NSString stringWithFormat:@"%.0lf.caf", [NSDate date].timeIntervalSince1970 * 1000];
        CGFloat time = 5;
        NSString *path = [NSFileManager pathUserChatVoice:fileName];
        NSError *error;
        [[NSFileManager defaultManager] moveItemAtPath:recFilePath toPath:path error:&error];
        if (error) {
            
            return;
        }
        
        TLVoiceMessage *message = [[TLVoiceMessage alloc] init];
        message.fromUser = self.user;
        message.ownerTyper = TLMessageOwnerTypeSelf;
        message.path = path;
        message.time = time;
        [self sendMessage:message];
        if ([self.partner chat_userType] == TLChatUserTypeUser) {
            TLVoiceMessage *message1 = [[TLVoiceMessage alloc] init];
            message1.fromUser = self.partner;
            message1.ownerTyper = TLMessageOwnerTypeFriend;
            message1.path = path;
            message1.time = time;
            [self sendMessage:message1];
        }
        else {
            for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
                TLVoiceMessage *message1 = [[TLVoiceMessage alloc] init];
                message1.friendID = [user chat_userID];
                message1.fromUser = user;
                message1.ownerTyper = TLMessageOwnerTypeFriend;
                message1.path = path;
                message1.time = time;
                [self sendMessage:message1];
            }
        }
    }
}

- (void)chatBarDidCancelRecording:(TLChatBar *)chatBar
{
    [[TLAudioRecorder sharedRecorder] stopRecording];
}

//MARK: TLChatBarUIDelegate
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

//MARK: TLEmojiKeyboardDelegate
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didSelectedEmojiItem:(TLEmoji *)emoji
{
    if (emoji.type == TLEmojiTypeEmoji || emoji.type == TLEmojiTypeFace) {
        [self.chatBar addEmojiString:emoji.emojiName];
    }
    else {
        TLExpressionMessage *message = [[TLExpressionMessage alloc] init];
        message.fromUser = self.user;
        message.ownerTyper = TLMessageOwnerTypeSelf;
        message.emoji = emoji;
        [self sendMessage:message];
        if ([self.partner chat_userType] == TLChatUserTypeUser) {
            TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
            message1.fromUser = self.partner;
            message1.ownerTyper = TLMessageOwnerTypeFriend;
            message1.emoji = emoji;;
            [self sendMessage:message1];
        }
        else {
            for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
                TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
                message1.friendID = [user chat_userID];
                message1.fromUser = user;
                message1.ownerTyper = TLMessageOwnerTypeFriend;
                message1.emoji = emoji;
                [self sendMessage:message1];
            }
        }
    }
}

- (void)emojiKeyboardSendButtonDown
{
    [self.chatBar sendCurrentText];
}

- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didTouchEmojiItem:(TLEmoji *)emoji atRect:(CGRect)rect
{
    if (emoji.type == TLEmojiTypeEmoji || emoji.type == TLEmojiTypeFace) {
        if (self.emojiDisplayView.superview == nil) {
            [self.emojiKeyboard addSubview:self.emojiDisplayView];
        }
        [self.emojiDisplayView displayEmoji:emoji atRect:rect];
    }
    else {
        if (self.imageExpressionDisplayView.superview == nil) {
            [self.emojiKeyboard addSubview:self.imageExpressionDisplayView];
        }
        [self.imageExpressionDisplayView displayEmoji:emoji atRect:rect];
    }
}

- (void)emojiKeyboardCancelTouchEmojiItem:(TLEmojiKeyboard *)emojiKB
{
    if (self.emojiDisplayView.superview != nil) {
        [self.emojiDisplayView removeFromSuperview];
    }
    else if (self.imageExpressionDisplayView.superview != nil) {
        [self.imageExpressionDisplayView removeFromSuperview];
    }
}

- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB selectedEmojiGroupType:(TLEmojiType)type
{
    if (type == TLEmojiTypeEmoji || type == TLEmojiTypeFace) {
        [self.chatBar setActivity:YES];
    }
    else {
        [self.chatBar setActivity:NO];
    }
}

- (BOOL)chatInputViewHasText
{
    return self.chatBar.curText.length == 0 ? NO : YES;
}


@end
