//
//  TLConversation.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversation.h"

@implementation TLConversation

- (BOOL)isRead
{
    return self.unreadCount <= 0;
}

- (NSString *)badgeValue
{
    if (self.isRead) {
        return nil;
    }
    if (self.convType == TLConversationTypePersonal || self.convType == TLConversationTypeGroup) {
        return self.unreadCount <= 99 ? @(self.unreadCount).stringValue : @"99+";
    }
    else {
        return @"";
    }
}

@end
