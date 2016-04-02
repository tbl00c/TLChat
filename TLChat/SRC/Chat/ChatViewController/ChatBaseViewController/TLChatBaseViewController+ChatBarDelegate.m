//
//  TLChatBaseViewController+ChatBarDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+ChatBarDelegate.h"
#import "TLChatBaseViewController+DataDelegate.h"

@implementation TLChatBaseViewController (ChatBarDelegate)

#pragma mark - Delegate

//MARK: TLChatBarDataDelegate
- (void)chatBar:(TLChatBar *)chatBar sendText:(NSString *)text
{
    TLTextMessage *message = [[TLTextMessage alloc] init];
    message.fromUser = [TLUserHelper sharedHelper].user;
    message.messageType = TLMessageTypeText;
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.text = text;
    [self sendMessage:message];
    if (self.curChatType == TLChatVCTypeFriend) {
        TLTextMessage *message1 = [[TLTextMessage alloc] init];
        message1.fromUser = self.user;
        message1.messageType = TLMessageTypeText;
        message1.ownerTyper = TLMessageOwnerTypeFriend;
        message1.text = text;
        [self sendMessage:message1];
    }
    else {
        for (TLUser *user in self.group.users) {
            TLTextMessage *message1 = [[TLTextMessage alloc] init];
            message1.friendID = user.userID;
            message1.fromUser = user;
            message1.messageType = TLMessageTypeText;
            message1.ownerTyper = TLMessageOwnerTypeFriend;
            message1.text = text;
            [self sendMessage:message1];
        }
    }
}

- (void)chatBarRecording:(TLChatBar *)chatBar
{
    NSLog(@"rec...");
}

- (void)chatBarWillCancelRecording:(TLChatBar *)chatBar
{
    NSLog(@"will cancel");
}

- (void)chatBarDidCancelRecording:(TLChatBar *)chatBar
{
    NSLog(@"cancel");
}

- (void)chatBarFinishedRecoding:(TLChatBar *)chatBar
{
    NSLog(@"finished");
}

@end
