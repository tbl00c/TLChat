//
//  TLMessageManager.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessageManager.h"
#import "TLDBMessageStore.h"
#import "TLDBMessage+TLMessage.h"

@interface TLMessageManager ()

@property (nonatomic, strong) TLDBMessageStore *messageStore;

@end

@implementation TLMessageManager

- (void)sendMessage:(TLMessage *)message
           progress:(void (^)(TLMessage *, CGFloat))progress
            success:(void (^)(TLMessage *))success
            failure:(void (^)(TLMessage *))failure
{
    BOOL ok = [self.messageStore addMessage:message];
    if (!ok) {
        DDLogError(@"存储Message到DB失败");
    }
}

- (void)messageRecordForUser:(NSString *)userID
                  andPartner:(NSString *)partnerID
                    fromDate:(NSDate *)date
                       count:(NSUInteger)count
                    complete:(void (^)(NSArray *, BOOL))complete
{
    [self.messageStore messagesByUserID:userID partnerID:partnerID fromDate:date count:count complete:^(NSArray *data, BOOL hasMore) {
        complete(data, hasMore);
    }];
}

- (BOOL)deleteMessageByMsgID:(NSString *)msgID
{
    return [self.messageStore deleteMessageByMessageID:msgID];
}

- (BOOL)deleteMessagesByFriendID:(NSString *)friendID
{
    return [self.messageStore deleteMessagesByFriendID:friendID];
}

#pragma mark - Getter -
- (TLDBMessageStore *)messageStore
{
    if (_messageStore == nil) {
        _messageStore = [[TLDBMessageStore alloc] init];
    }
    return _messageStore;
}

@end
