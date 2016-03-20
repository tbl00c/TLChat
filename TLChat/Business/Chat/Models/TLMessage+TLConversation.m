//
//  TLMessage+TLConversation.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage+TLConversation.h"

@implementation TLMessage (TLConversation)

- (NSString *)conversationContent
{
    if (self.messageType == TLMessageTypeText) {
        return self.text;
    }
    else if (self.messageType == TLMessageTypeImage) {
        return @"[图片]";
    }
    else if (self.messageType == TLMessageTypeExpression) {
        return @"[表情]";
    }
    return @"*未知消息类型*";
}

@end
