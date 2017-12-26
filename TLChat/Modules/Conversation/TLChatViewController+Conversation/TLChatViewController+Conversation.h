//
//  TLChatViewController+Conversation.h
//  TLChat
//
//  Created by 李伯坤 on 2017/12/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLChatViewController.h"
#import "TLConversation.h"

@interface TLChatViewController (Conversation)

- (instancetype)initWithConversation:(TLConversation *)conversation;

@end
