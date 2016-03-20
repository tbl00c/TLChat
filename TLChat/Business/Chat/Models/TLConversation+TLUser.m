//
//  TLConversation+TLUser.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversation+TLUser.h"

@implementation TLConversation (TLUser)

- (void)updateUserInfo:(TLUser *)user
{
    self.username = user.showName;
    self.avatarPath = user.avatarPath;
    self.avatarURL = user.avatarURL;
}

- (void)updateGroupInfo:(TLGroup *)group
{
    self.username = group.groupName;
    self.avatarPath = group.groupAvatarPath;
}

@end
