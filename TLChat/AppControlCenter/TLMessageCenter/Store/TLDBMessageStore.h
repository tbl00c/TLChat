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

#pragma mark - 添加
/**
 *  添加消息记录
 */
- (BOOL)addMessage:(TLMessage *)message;

#pragma mark - 查询
/**
 *  获取与某个好友的聊天记录
 */
- (void)messagesByUserID:(NSString *)userID
               partnerID:(NSString *)partnerID
                fromDate:(NSDate *)date
                   count:(NSUInteger)count
                complete:(void (^)(NSArray *data, BOOL hasMore))complete;

/**
 *  获取与某个好友/讨论组的聊天文件
 */
- (NSArray *)chatFilesByUserID:(NSString *)userID partnerID:(NSString *)partnerID;

/**
 *  获取与某个好友/讨论组的聊天图片及视频
 */
- (NSArray *)chatImagesAndVideosByUserID:(NSString *)userID partnerID:(NSString *)partnerID;

/**
 *  最后一条聊天记录（消息页用）
 */
- (TLMessage *)lastMessageByUserID:(NSString *)userID partnerID:(NSString *)partnerID;

#pragma mark - 删除
/**
 *  删除单条消息
 */
- (BOOL)deleteMessageByMessageID:(NSString *)messageID;

/**
 *  删除与某个好友/讨论组的所有聊天记录
 */
- (BOOL)deleteMessagesByUserID:(NSString *)userID partnerID:(NSString *)partnerID;

/**
 *  删除用户的所有聊天记录
 */
- (BOOL)deleteMessagesByUserID:(NSString *)userID;

@end
