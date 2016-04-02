//
//  TLMessage.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"

@interface TLMessage ()
{
    NSString *kMessageID;
    NSString *kUserID;
    NSString *kFriendID;
    NSString *kGroupID;
    
    NSDate *kDate;
    BOOL kShowTime;
    BOOL kShowName;
    
    TLPartnerType kPartnerType;
    TLMessageType kMessageType;
    TLMessageOwnerType kOwnerTyper;
    TLMessageReadState kReadState;
    TLMessageSendState kSendState;
    
    NSMutableDictionary *kContent;
}

@end

@implementation TLMessage

- (id)init
{
    if (self = [super init]) {
        self.messageID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
    }
    return self;
}

- (NSString *)messageID
{
    return kMessageID;
}
- (void)setMessageID:(NSString *)messageID
{
    kMessageID = messageID;
}

- (NSString *)userID
{
    return kUserID;
}
- (void)setUserID:(NSString *)userID
{
    kUserID = userID;
}

- (NSString *)friendID
{
    return kFriendID;
}
- (void)setFriendID:(NSString *)friendID
{
    kFriendID = friendID;
}

- (NSString *)groupID
{
    return kGroupID;
}
- (void)setGroupID:(NSString *)groupID
{
    kGroupID = groupID;
}

- (NSDate *)date
{
    return kDate;
}
- (void)setDate:(NSDate *)date
{
    kDate = date;
}

- (BOOL)showTime
{
    return kShowTime;
}
- (void)setShowTime:(BOOL)showTime
{
    kShowTime = showTime;
}

- (BOOL)showName
{
    return kShowName;
}
- (void)setShowName:(BOOL)showName
{
    kShowName = showName;
}

- (TLPartnerType)partnerType
{
    return kPartnerType;
}
- (void)setPartnerType:(TLPartnerType)partnerType
{
    kPartnerType = partnerType;
}

- (TLMessageType)messageType
{
    return kMessageType;
}
- (void)setMessageType:(TLMessageType)messageType
{
    kMessageType = messageType;
}

- (TLMessageOwnerType)ownerTyper
{
    return kOwnerTyper;
}
- (void)setOwnerTyper:(TLMessageOwnerType)ownerTyper
{
    kOwnerTyper = ownerTyper;
}

- (TLMessageSendState)sendState
{
    return kSendState;
}
- (void)setSendState:(TLMessageSendState)sendState
{
    kSendState = sendState;
}

- (TLMessageReadState)readState
{
    return kReadState;
}
- (void)setReadState:(TLMessageReadState)readState
{
    kReadState = readState;
}

- (NSMutableDictionary *)content
{
    if (kContent == nil) {
        kContent = [[NSMutableDictionary alloc] init];
    }
    return kContent;
}
- (void)setContent:(NSMutableDictionary *)content
{
    kContent = content;
}

- (NSString *)conversationContent
{
    return @"子类未定义";
}

- (NSString *)messageCopy
{
    return @"子类未定义";
}

- (TLMessageFrame *)messageFrame
{
    DDLogError(@"子类需实现 - (TLMessageFrame *)messageFrame 方法");
    return nil;
}
- (void)setMessageFrame:(TLMessageFrame *)messageFrame
{

}

@end
