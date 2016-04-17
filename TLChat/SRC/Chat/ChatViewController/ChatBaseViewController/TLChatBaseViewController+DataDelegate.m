//
//  TLChatBaseViewController+DataDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+DataDelegate.h"
#import "TLChatBaseViewController+ChatTableViewDelegate.h"

@implementation TLChatBaseViewController (DataDelegate)

- (void)sendMessage:(TLMessage *)message
{
    message.userID = [TLUserHelper sharedHelper].userID;
    if (self.curChatType == TLChatVCTypeFriend) {
        message.partnerType = TLPartnerTypeUser;
        message.friendID = self.user.userID;
    }
    else if (self.curChatType == TLChatVCTypeGroup) {
        message.partnerType = TLPartnerTypeGroup;
        message.groupID = self.group.groupID;
    }
    //    message.ownerTyper = TLMessageOwnerTypeSelf;
    //    message.fromUser = [TLUserHelper sharedHelper].user;
    message.date = [NSDate date];
    
    [self addToShowMessage:message];    // 添加到列表
    [[TLMessageManager sharedInstance] sendMessage:message progress:^(TLMessage * message, CGFloat pregress) {
        
    } success:^(TLMessage * message) {
        NSLog(@"send success");
    } failure:^(TLMessage * message) {
        NSLog(@"send failure");
    }];
}

@end
