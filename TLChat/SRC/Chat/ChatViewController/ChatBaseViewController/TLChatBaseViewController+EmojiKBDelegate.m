//
//  TLChatBaseViewController+EmojiKBDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+EmojiKBDelegate.h"
#import "TLChatBaseViewController+DataDelegate.h"

@implementation TLChatBaseViewController (EmojiKBDelegate)

//MARK: TLEmojiKeyboardDelegate
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didSelectedEmojiItem:(TLEmoji *)emoji
{
    if (emoji.type == TLEmojiTypeEmoji || emoji.type == TLEmojiTypeFace) {
        [self.chatBar addEmojiString:emoji.emojiName];
    }
    else {
        TLExpressionMessage *message = [[TLExpressionMessage alloc] init];
        message.fromUser = [TLUserHelper sharedHelper].user;
        message.messageType = TLMessageTypeExpression;
        message.ownerTyper = TLMessageOwnerTypeSelf;
        message.emoji = emoji;
        [self sendMessage:message];
        if (self.curChatType == TLChatVCTypeFriend) {
            TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
            message1.fromUser = self.user;
            message1.messageType = TLMessageTypeExpression;
            message1.ownerTyper = TLMessageOwnerTypeFriend;
            message1.emoji = emoji;;
            [self sendMessage:message1];
        }
        else {
            for (TLUser *user in self.group.users) {
                TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
                message1.friendID = user.userID;
                message1.fromUser = user;
                message1.messageType = TLMessageTypeExpression;
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
