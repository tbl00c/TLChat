//
//  TLDBExpressionStore.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBExpressionStore.h"
#import "TLDBExpressionSQL.h"
#import "TLDBManager.h"
#import "TLMacros.h"

@implementation TLDBExpressionStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [TLDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            DDLogError(@"DB: 聊天记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_EXP_GROUP_TABLE, EXP_GROUP_TABLE_NAME];
    BOOL ok = [self createTable:EXP_GROUP_TABLE_NAME withSQL:sqlString];
    if (!ok) {
        return NO;
    }
    sqlString = [NSString stringWithFormat:SQL_CREATE_EXPS_TABLE, EXPS_TABLE_NAME];
    ok = [self createTable:EXPS_TABLE_NAME withSQL:sqlString];
    return ok;
}

#pragma mark - # 表情组
- (BOOL)addExpressionGroup:(TLExpressionGroupModel *)group forUid:(NSString *)uid
{
    // 添加表情包
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_EXP_GROUP, EXP_GROUP_TABLE_NAME];
    NSArray *arr = [NSArray arrayWithObjects:
                    uid,
                    group.gId,
                    [NSNumber numberWithInteger:group.type],
                    TLNoNilString(group.name),
                    TLNoNilString(group.groupInfo),
                    TLNoNilString(group.detail),
                    [NSNumber numberWithInteger:group.count],
                    TLNoNilString(group.authID),
                    TLNoNilString(group.authName),
                    TLTimeStamp(group.date),
                    @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arr];
    if (!ok) {
        return NO;
    }
    // 添加表情包里的所有表情
    ok = [self addExpressions:group.data toGroupID:group.gId];
    return ok;
}

- (NSArray *)expressionGroupsByUid:(NSString *)uid
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_EXP_GROUP, EXP_GROUP_TABLE_NAME, uid];
    
    // 读取表情包信息
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            TLExpressionGroupModel *group = [[TLExpressionGroupModel alloc] init];
            group.gId = [retSet stringForColumn:@"gid"];
            group.type = [retSet intForColumn:@"type"];
            group.name = [retSet stringForColumn:@"name"];
            group.groupInfo = [retSet stringForColumn:@"desc"];
            group.detail = [retSet stringForColumn:@"detail"];
            group.count = [retSet intForColumn:@"count"];
            group.authID = [retSet stringForColumn:@"auth_id"];
            group.authName = [retSet stringForColumn:@"auth_name"];
            group.status = TLExpressionGroupStatusLocal;
            [data addObject:group];
        }
        [retSet close];
    }];
    
    // 读取表情包的所有表情信息
    for (TLExpressionGroupModel *group in data) {
        group.data = [self expressionsForGroupID:group.gId];
    }
    
    return data;
}

- (BOOL)deleteExpressionGroupByID:(NSString *)gid forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_EXP_GROUP, EXP_GROUP_TABLE_NAME, uid, gid];
    return [self excuteSQL:sqlString, nil];
}

- (NSInteger)countOfUserWhoHasExpressionGroup:(NSString *)gid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_COUNT_EXP_GROUP_USERS, EXP_GROUP_TABLE_NAME, gid];
    __block NSInteger count = 0;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        count = [db intForQuery:sqlString];
    }];

    return count;
}

#pragma mark - # 表情 
- (BOOL)addExpressions:(NSArray *)expressions toGroupID:(NSString *)groupID
{
    for (TLExpressionModel *emoji in expressions) {
        NSString *sqlString = [NSString stringWithFormat:SQL_ADD_EXP, EXPS_TABLE_NAME];
        NSArray *arr = [NSArray arrayWithObjects:
                        groupID,
                        emoji.eId,
                        TLNoNilString(emoji.name),
                        @"", @"", @"", @"", @"", nil];
        BOOL ok = [self excuteSQL:sqlString withArrParameter:arr];
        if (!ok) {
            return NO;
        }
    }
    return YES;
}

- (NSMutableArray *)expressionsForGroupID:(NSString *)groupID
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_EXPS, EXPS_TABLE_NAME, groupID];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            TLExpressionModel *emoji = [[TLExpressionModel alloc] init];
            emoji.gid = [retSet stringForColumn:@"gid"];
            emoji.eId = [retSet stringForColumn:@"eid"];
            emoji.name = [retSet stringForColumn:@"name"];
            [data addObject:emoji];
        }
        [retSet close];
    }];
    
    return data;
}

@end
