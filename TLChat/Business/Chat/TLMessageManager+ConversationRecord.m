//
//  TLMessageManager+ConversationRecord.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessageManager+ConversationRecord.h"

@implementation TLMessageManager (ConversationRecord)

- (void)conversationRecord:(void (^)(NSArray *))complete
{
    NSArray *data = [self.conversationStore conversationsByUid:[TLUserHelper sharedHelper].userID];
    complete(data);
}

@end
