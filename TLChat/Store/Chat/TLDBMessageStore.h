//
//  TLDBMessageStore.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseStore.h"
#import "TLMessage.h"

@interface TLDBMessageStore : TLDBBaseStore

/**
 *  添加消息记录
 */
- (BOOL)addMessage:(TLMessage *)message;

/**
 *  获取与某个好友的聊天记录
 */
- (void)messagesByUserID:(NSString *)userID
               partnerID:(NSString *)partnerID
                fromDate:(NSDate *)date
                   count:(NSUInteger)count
                complete:(void (^)(NSArray *data, BOOL hasMore))complete;

/**
 *  删除单条消息
 */
- (BOOL)deleteMessageByMessageID:(NSString *)messageID;

/**
 *  删除与某个好友的所有聊天记录
 */
- (BOOL)deleteMessagesByFriendID:(NSString *)friendID;

@end
