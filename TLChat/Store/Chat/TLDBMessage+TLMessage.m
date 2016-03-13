//
//  TLDBMessage+TLMessage.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBMessage+TLMessage.h"

@implementation TLDBMessage (TLMessage)

- (TLMessage *)toMessage
{
    TLMessage *message = [[TLMessage alloc] init];
    message.messageID = self.msgID;
    message.userID = self.userID;
    message.friendID = self.friendID;
    message.ownerTyper = self.ownerType;
    message.date = self.date;
    message.messageType = self.msgType;
    message.text = self.content;
    message.sendState = self.sendStatus;
    message.readState= self.receivedStatus;
    return message;
}

@end


@implementation TLMessage (TLDBMessage)

- (TLDBMessage *)toDBMessage
{
    TLDBMessage *dbMessage = [[TLDBMessage alloc] init];
    dbMessage.msgID = self.messageID;
    dbMessage.userID = self.userID;
    dbMessage.friendID = self.friendID;
    dbMessage.ownerType = self.ownerTyper;
    dbMessage.date = self.date;
    
    dbMessage.msgType = self.messageType;
    dbMessage.content = self.text;
    
    dbMessage.sendStatus = self.sendState;
    dbMessage.receivedStatus = self.readState;
    
    return dbMessage;
}

@end

