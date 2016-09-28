//
//  TLChatBaseViewController+ChatBar.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+ChatBar.h"
#import "TLChatBaseViewController+Proxy.h"
#import "TLChatBaseViewController+MessageDisplayView.h"
#import "TLAudioRecorder.h"
#import "TLAudioPlayer.h"

@implementation TLChatBaseViewController (ChatBar)

#pragma mark - # Public Methods
- (void)loadKeyboard
{
    [self.emojiKeyboard setKeyboardDelegate:self];
    [self.emojiKeyboard setDelegate:self];
    [self.moreKeyboard setKeyboardDelegate:self];
    [self.moreKeyboard setDelegate:self];
}

- (void)dismissKeyboard
{
    if (curStatus == TLChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:YES];
        curStatus = TLChatBarStatusInit;
    }
    else if (curStatus == TLChatBarStatusEmoji) {
        [self.emojiKeyboard dismissWithAnimation:YES];
        curStatus = TLChatBarStatusInit;
    }
    [self.chatBar resignFirstResponder];
}

//MARK: 系统键盘回调
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (curStatus != TLChatBarStatusKeyboard) {
        return;
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (curStatus != TLChatBarStatusKeyboard) {
        return;
    }
    if (lastStatus == TLChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:NO];
    }
    else if (lastStatus == TLChatBarStatusEmoji) {
        [self.emojiKeyboard dismissWithAnimation:NO];
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    if (curStatus != TLChatBarStatusKeyboard && lastStatus != TLChatBarStatusKeyboard) {
        return;
    }
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
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (curStatus != TLChatBarStatusKeyboard && lastStatus != TLChatBarStatusKeyboard) {
        return;
    }
    if (curStatus == TLChatBarStatusEmoji || curStatus == TLChatBarStatusMore) {
        return;
    }
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}

#pragma mark - Delegate
//MARK: TLChatBarDelegate
// 发送文本消息
- (void)chatBar:(TLChatBar *)chatBar sendText:(NSString *)text
{
    TLTextMessage *message = [[TLTextMessage alloc] init];
    message.text = text;
    [self sendMessage:message];
    if ([self.partner chat_userType] == TLChatUserTypeUser) {
        TLTextMessage *message1 = [[TLTextMessage alloc] init];
        message1.fromUser = self.partner;
        message1.text = text;
        [self receivedMessage:message1];
    }
    else {
        for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
            TLTextMessage *message1 = [[TLTextMessage alloc] init];
            message1.friendID = [user chat_userID];
            message1.fromUser = user;
            message1.text = text;
            [self receivedMessage:message1];
        }
    }
}

//MARK: - 录音相关
- (void)chatBarStartRecording:(TLChatBar *)chatBar
{
    // 先停止播放
    if ([TLAudioPlayer sharedAudioPlayer].isPlaying) {
        [[TLAudioPlayer sharedAudioPlayer] stopPlayingAudio];
    }
    
    [self.recorderIndicatorView setStatus:TLRecorderStatusRecording];
    [self.messageDisplayView addSubview:self.recorderIndicatorView];
    [self.recorderIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    
    __block NSInteger time_count = 0;
    TLVoiceMessage *message = [[TLVoiceMessage alloc] init];
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.userID = [TLUserHelper sharedHelper].userID;
    message.fromUser = (id<TLChatUserProtocol>)[TLUserHelper sharedHelper].user;
    message.msgStatus = TLVoiceMessageStatusRecording;
    message.date = [NSDate date];
    [[TLAudioRecorder sharedRecorder] startRecordingWithVolumeChangedBlock:^(CGFloat volume) {
        time_count ++;
        if (time_count == 2) {
            [self addToShowMessage:message];
        }
        [self.recorderIndicatorView setVolume:volume];
    } completeBlock:^(NSString *filePath, CGFloat time) {
        if (time < 1.0) {
            [self.recorderIndicatorView setStatus:TLRecorderStatusTooShort];
            return;
        }
        [self.recorderIndicatorView removeFromSuperview];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSString *fileName = [NSString stringWithFormat:@"%.0lf.caf", [NSDate date].timeIntervalSince1970 * 1000];
            NSString *path = [NSFileManager pathUserChatVoice:fileName];
            NSError *error;
            [[NSFileManager defaultManager] moveItemAtPath:filePath toPath:path error:&error];
            if (error) {
                DDLogError(@"录音文件出错: %@", error);
                return;
            }
            
            message.recFileName = fileName;
            message.time = time;
            message.msgStatus = TLVoiceMessageStatusNormal;
            [message resetMessageFrame];
            [self sendMessage:message];
            if ([self.partner chat_userType] == TLChatUserTypeUser) {
                TLVoiceMessage *message1 = [[TLVoiceMessage alloc] init];
                message1.fromUser = self.partner;
                message1.recFileName = fileName;
                message1.time = time;
                [self receivedMessage:message1];
            }
            else {
                for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
                    TLVoiceMessage *message1 = [[TLVoiceMessage alloc] init];
                    message1.friendID = [user chat_userID];
                    message1.fromUser = user;
                    message1.recFileName = fileName;
                    message1.time = time;
                    [self receivedMessage:message1];
                }
            }
        }
    } cancelBlock:^{
        [self.messageDisplayView deleteMessage:message];
        [self.recorderIndicatorView removeFromSuperview];
    }];
}

- (void)chatBarWillCancelRecording:(TLChatBar *)chatBar cancel:(BOOL)cancel
{
    [self.recorderIndicatorView setStatus:cancel ? TLRecorderStatusWillCancel : TLRecorderStatusRecording];
}

- (void)chatBarFinishedRecoding:(TLChatBar *)chatBar
{
    [[TLAudioRecorder sharedRecorder] stopRecording];
}

- (void)chatBarDidCancelRecording:(TLChatBar *)chatBar
{
    [[TLAudioRecorder sharedRecorder] cancelRecording];
}

//MARK: - chatBar状态切换
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
    else if (toStatus == TLChatBarStatusVoice) {
        if (fromStatus == TLChatBarStatusMore) {
            [self.moreKeyboard dismissWithAnimation:YES];
        }
        else if (fromStatus == TLChatBarStatusEmoji) {
            [self.emojiKeyboard dismissWithAnimation:YES];
        }
    }
    else if (toStatus == TLChatBarStatusEmoji) {
        [self.emojiKeyboard showInView:self.view withAnimation:YES];
    }
    else if (toStatus == TLChatBarStatusMore) {
        [self.moreKeyboard showInView:self.view withAnimation:YES];
    }
}

- (void)chatBar:(TLChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height
{
    [self.messageDisplayView scrollToBottomWithAnimation:NO];
}

//MARK: TLKeyboardDelegate
- (void)chatKeyboardWillShow:(id)keyboard animated:(BOOL)animated
{
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)chatKeyboardDidShow:(id)keyboard animated:(BOOL)animated
{
    if (curStatus == TLChatBarStatusMore && lastStatus == TLChatBarStatusEmoji) {
        [self.emojiKeyboard dismissWithAnimation:NO];
    }
    else if (curStatus == TLChatBarStatusEmoji && lastStatus == TLChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:NO];
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height
{
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-height);
    }];
    [self.view layoutIfNeeded];
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

//MARK: TLEmojiKeyboardDelegate
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didSelectedEmojiItem:(TLEmoji *)emoji
{
    if (emoji.type == TLEmojiTypeEmoji || emoji.type == TLEmojiTypeFace) {
        [self.chatBar addEmojiString:emoji.emojiName];
    }
    else {
        TLExpressionMessage *message = [[TLExpressionMessage alloc] init];
        message.emoji = emoji;
        [self sendMessage:message];
        if ([self.partner chat_userType] == TLChatUserTypeUser) {
            TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
            message1.fromUser = self.partner;
            message1.emoji = emoji;;
            [self receivedMessage:message1];
        }
        else {
            for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
                TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
                message1.friendID = [user chat_userID];
                message1.fromUser = user;
                message1.emoji = emoji;
                [self receivedMessage:message1];
            }
        }
    }
}

- (void)emojiKeyboardSendButtonDown
{
    [self.chatBar sendCurrentText];
}

- (void)emojiKeyboardDeleteButtonDown
{
    [self.chatBar deleteLastCharacter];
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

#pragma mark - # Getter
- (TLEmojiKeyboard *)emojiKeyboard
{
    return [TLEmojiKeyboard keyboard];
}

- (TLMoreKeyboard *)moreKeyboard
{
    return [TLMoreKeyboard keyboard];
}


@end
