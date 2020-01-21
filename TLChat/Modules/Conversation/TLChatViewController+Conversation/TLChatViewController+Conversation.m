//
//  TLChatViewController+Conversation.m
//  TLChat
//
//  Created by 李伯坤 on 2017/12/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLChatViewController+Conversation.h"

@implementation TLChatViewController (Conversation)

- (instancetype)initWithConversation:(TLConversation *)conversation
{
    if (conversation.convType == TLConversationTypePersonal) {
        return [self initWithUserId:conversation.partnerID];
    }
    else if (conversation.convType == TLConversationTypeGroup){
        return [self initWithGroupId:conversation.partnerID];
    }
    return [super init];
}

@end
