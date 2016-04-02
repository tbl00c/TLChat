//
//  TLDBMessage+TLMessage.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBMessage+TLMessage.h"

@implementation TLDBMessage (TLMessage)

- (id<TLMessageProtocol>)toMessage
{
    id<TLMessageProtocol> message = [TLMessage createMessageByType:self.msgType];
    message.messageID = self.mid;
    message.userID = self.uid;
    message.partnerType = self.partnerType;
    if (message.partnerType == TLPartnerTypeGroup) {
        message.groupID = self.fid;
        message.friendID = self.subfid;
    }
    else {
        message.friendID = self.fid;
    }
    message.ownerTyper = self.ownerType;
    message.date = [NSDate dateWithTimeIntervalSince1970:self.date.doubleValue];
    
    message.messageType = self.msgType;
    NSData *jsonData = [self.content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    message.content = [NSMutableDictionary dictionaryWithDictionary:dic];
    message.sendState = self.sendStatus;
    message.readState= self.receivedStatus;
    return message;
}

@end


@implementation TLMessage (TLDBMessage)

- (TLDBMessage *)toDBMessage
{
    TLDBMessage *dbMessage = [[TLDBMessage alloc] init];
    dbMessage.mid = self.messageID;
    dbMessage.uid = self.userID;
    dbMessage.partnerType = self.partnerType;
    if (self.partnerType == TLPartnerTypeGroup) {
        dbMessage.fid = self.groupID;
        dbMessage.subfid = self.friendID;
    }
    else {
        dbMessage.fid = self.friendID;
        dbMessage.subfid = @"";
    }
    dbMessage.ownerType = self.ownerTyper;
    dbMessage.date = [NSString stringWithFormat:@"%lf", self.date.timeIntervalSince1970];
    
    dbMessage.msgType = self.messageType;
    dbMessage.content = [self.content mj_JSONString];
    
    dbMessage.sendStatus = self.sendState;
    dbMessage.receivedStatus = self.readState;
    
    return dbMessage;
}

@end

