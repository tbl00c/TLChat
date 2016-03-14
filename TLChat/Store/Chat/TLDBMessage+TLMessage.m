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
    NSData *jsonData = [self.content dataUsingEncoding:NSASCIIStringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    if (message.messageType == TLMessageTypeText) {
        message.text = [dic valueForKey:@"text"];
    }
    else if (message.messageType == TLMessageTypeImage) {
        message.imagePath = [dic valueForKey:@"path"];
        message.imageURL = [dic valueForKey:@"url"];
    }
    
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
    NSString *contentStr = @"";
    if (self.messageType == TLMessageTypeText) {
        NSDictionary *dic = @{@"text":self.text};
        contentStr = [dic mj_JSONString];
    }
    else if (self.messageType == TLMessageTypeImage) {
        NSDictionary *dic = @{@"path":self.imagePath.length > 0 ? self.imagePath : @"",
                              @"url":self.imageURL.length > 0 ? self.imageURL : @""};
        contentStr = [dic mj_JSONString];
    }
    dbMessage.content = contentStr;
    
    dbMessage.sendStatus = self.sendState;
    dbMessage.receivedStatus = self.readState;
    
    return dbMessage;
}

@end

