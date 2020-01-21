//
//  TLDBConversationStore.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBConversationStore.h"
#import "TLDBMessageStore.h"
#import "TLDBConversationSQL.h"
#import "TLDBManager.h"
#import "TLConversation.h"
#import "TLMacros.h"

@interface TLDBConversationStore ()

@property (nonatomic, strong) TLDBMessageStore *messageStore;

@end

@implementation TLDBConversationStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [TLDBManager sharedInstance].messageQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            DDLogError(@"DB: 聊天记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_CONV_TABLE, CONV_TABLE_NAME];
    return [self createTable:CONV_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addConversationByUid:(NSString *)uid fid:(NSString *)fid type:(NSInteger)type date:(NSDate *)date;
{
    NSInteger unreadCount = [self unreadMessageByUid:uid fid:fid] + 1;
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_CONV, CONV_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        uid,
                        fid,
                        [NSNumber numberWithInteger:type],
                        TLTimeStamp(date),
                        [NSNumber numberWithInteger:unreadCount],
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

/**
 *  更新会话状态（已读）
 */
- (void)updateConversationByUid:(NSString *)uid fid:(NSString *)fid
{

}

/**
 *  查询所有会话
 */
- (NSArray *)conversationsByUid:(NSString *)uid
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_CONVS, CONV_TABLE_NAME, uid];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            TLConversation *conversation = [[TLConversation alloc] init];
            conversation.partnerID = [retSet stringForColumn:@"fid"];
            conversation.convType = [retSet intForColumn:@"conv_type"];
            NSString *dateString = [retSet stringForColumn:@"date"];
            conversation.date = [NSDate dateWithTimeIntervalSince1970:dateString.doubleValue];
            conversation.unreadCount = @([retSet intForColumn:@"unread_count"]).stringValue;
            [data addObject:conversation];
        }
        [retSet close];
    }];
    
    // 获取conv对应的msg
    for (TLConversation *conversation in data) {
        TLMessage * message = [self.messageStore lastMessageByUserID:uid partnerID:conversation.partnerID];
        if (message) {
            conversation.content = [message conversationContent];
            conversation.date = message.date;
        }
    }
    
    return data;
}

- (NSInteger)unreadMessageByUid:(NSString *)uid fid:(NSString *)fid
{
    __block NSInteger unreadCount = 0;
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CONV_UNREAD, CONV_TABLE_NAME, uid, fid];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        if ([retSet next]) {
            unreadCount = [retSet intForColumn:@"unread_count"];
        }
        [retSet close];
    }];
    return unreadCount;
}

/**
 *  删除单条会话
 */
- (BOOL)deleteConversationByUid:(NSString *)uid fid:(NSString *)fid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_CONV, CONV_TABLE_NAME, uid, fid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

/**
 *  删除用户的所有会话
 */
- (BOOL)deleteConversationsByUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_ALL_CONVS, CONV_TABLE_NAME, uid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
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
