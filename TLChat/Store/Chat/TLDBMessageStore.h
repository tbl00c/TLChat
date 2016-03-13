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
- (NSArray *)messagesByUserID:(NSString *)userID friendID:(NSString *)friendID fromDate:(NSDate *)date count:(NSUInteger)count;

@end
