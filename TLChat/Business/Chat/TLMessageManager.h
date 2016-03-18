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

- (void)sendMessage:(TLMessage *)message
           progress:(void (^)(TLMessage *, CGFloat))progress
            success:(void (^)(TLMessage *))success
            failure:(void (^)(TLMessage *))failure;

- (void)messageRecordForPartner:(NSString *)partnerID
                       fromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, BOOL))complete;

- (BOOL)deleteMessageByMsgID:(NSString *)msgID;

/**
 *  删除与某好友的聊天记录
 */
- (BOOL)deleteMessagesByPartnerID:(NSString *)partnerID;

/**
 *  聊天文件
 *
 *  @param fid       好友/讨论组id
 *  @param completed 带有聊天文件的Message
 */
- (void)chatFilesForPartnerID:(NSString *)partnerID
                    completed:(void (^)(NSArray *))completed;

@end
