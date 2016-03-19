//
//  TLMessageManager.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMessage.h"

@interface TLMessageManager : NSObject

+ (TLMessageManager *)sharedInstance;

#pragma mark - 发送
- (void)sendMessage:(TLMessage *)message
           progress:(void (^)(TLMessage *, CGFloat))progress
            success:(void (^)(TLMessage *))success
            failure:(void (^)(TLMessage *))failure;


#pragma mark - 查询
/**
 *  查询聊天记录
 */
- (void)messageRecordForPartner:(NSString *)partnerID
                       fromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, BOOL))complete;

/**
 *  查询聊天文件
 */
- (void)chatFilesForPartnerID:(NSString *)partnerID
                    completed:(void (^)(NSArray *))completed;


#pragma mark - 删除
/**
 *  删除单条聊天记录
 */
- (BOOL)deleteMessageByMsgID:(NSString *)msgID;

/**
 *  删除与某好友的聊天记录
 */
- (BOOL)deleteMessagesByPartnerID:(NSString *)partnerID;

/**
 *  删除所有聊天记录
 */
- (BOOL)deleteAllMessages;

@end
