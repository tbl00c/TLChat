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

- (void)sendMessage:(TLMessage *)message
           progress:(void (^)(TLMessage *, CGFloat))progress
            success:(void (^)(TLMessage *))success
            failure:(void (^)(TLMessage *))failure;

- (void)messageRecordForUser:(NSString *)userID
                  andPartner:(NSString *)partnerID
                    fromDate:(NSDate *)date
                       count:(NSUInteger)count
                    complete:(void (^)(NSArray *, BOOL))complete;

- (BOOL)deleteMessageByMsgID:(NSString *)msgID;

/**
 *  删除与某好友的聊天记录
 */
- (BOOL)deleteMessagesByFriendID:(NSString *)friendID;

@end
