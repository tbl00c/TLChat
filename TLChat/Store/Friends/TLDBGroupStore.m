//
//  TLDBGroupStore.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBGroupStore.h"
#import "TLDBGroupSQL.h"
#import "TLGroup.h"

@implementation TLDBGroupStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [TLDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            DDLogError(@"DB: 讨论组表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_GROUPS_TABLE, GROUPS_TABLE_NAME];
    BOOL ok = [self createTable:GROUPS_TABLE_NAME withSQL:sqlString];
    if (ok) {
        sqlString = [NSString stringWithFormat:SQL_CREATE_GROUP_MEMBERS_TABLE, GROUP_MEMBER_TABLE_NAMGE];
        ok = [self createTable:GROUP_MEMBER_TABLE_NAMGE withSQL:sqlString];
    }
    return ok;
}

- (BOOL)addGroup:(TLGroup *)group forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_GROUP, GROUPS_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(uid),
                        TLNoNilString(group.groupID),
                        TLNoNilString(group.groupName),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    if (ok) {
        // 将通讯录成员插入数据库
        ok = [self addGroupMembers:group.users forUid:uid andGid:group.groupID];
    }
    return ok;
}

- (BOOL)updateGroupsData:(NSArray *)groupData forUid:(NSString *)uid
{
    NSArray *oldData = [self groupsDataByUid:uid];
    if (oldData.count > 0) {
        // 建立新数据的hash表，用于删除数据库中的过时数据
        NSMutableDictionary *newDataHash = [[NSMutableDictionary alloc] init];
        for (TLGroup *group in groupData) {
            [newDataHash setValue:@"YES" forKey:group.groupID];
        }
        for (TLGroup *group in oldData) {
            if ([newDataHash objectForKey:group.groupID] == nil) {
                BOOL ok = [self deleteGroupByGid:group.groupID forUid:uid];
                if (!ok) {
                    DDLogError(@"DBError: 删除过期讨论组失败！");
                }
            }
        }
    }
    
    // 将数据插入数据库
    for (TLGroup *group in groupData) {
        BOOL ok = [self addGroup:group forUid:uid];
        if (!ok) {
            return ok;
        }
    }
    
    return YES;
}


- (NSMutableArray *)groupsDataByUid:(NSString *)uid
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_GROUPS, GROUPS_TABLE_NAME, uid];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            TLGroup *group = [[TLGroup alloc] init];
            group.groupID = [retSet stringForColumn:@"gid"];
            group.groupName = [retSet stringForColumn:@"name"];
            [data addObject:group];
        }
        [retSet close];
    }];
    
    // 获取讨论组成员
    for (TLGroup *group in data) {
        group.users = [self groupMembersForUid:uid andGid:group.groupID];
    }
    
    return data;
}

- (BOOL)deleteGroupByGid:(NSString *)gid forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_GROUP, GROUPS_TABLE_NAME, uid, gid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}


#pragma mark - # Group Members 
- (BOOL)addGroupMember:(TLUser *)user forUid:(NSString *)uid andGid:(NSString *)gid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_GROUP_MEMBER, GROUP_MEMBER_TABLE_NAMGE];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(uid),
                        TLNoNilString(gid),
                        TLNoNilString(user.userID),
                        TLNoNilString(user.username),
                        TLNoNilString(user.nikeName),
                        TLNoNilString(user.avatarURL),
                        TLNoNilString(user.remarkName),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (BOOL)addGroupMembers:(NSArray *)users forUid:(NSString *)uid andGid:(NSString *)gid
{
    NSArray *oldData = [self groupMembersForUid:uid andGid:gid];
    if (oldData.count > 0) {
        // 建立新数据的hash表，用于删除数据库中的过时数据
        NSMutableDictionary *newDataHash = [[NSMutableDictionary alloc] init];
        for (TLUser *user in users) {
            [newDataHash setValue:@"YES" forKey:user.userID];
        }
        for (TLUser *user in oldData) {
            if ([newDataHash objectForKey:user.userID] == nil) {
                BOOL ok = [self deleteGroupMemberForUid:uid gid:gid andFid:user.userID];
                if (!ok) {
                    DDLogError(@"DBError: 删除过期好友失败");
                }
            }
        }
    }
    for (TLUser *user in users) {
        BOOL ok = [self addGroupMember:user forUid:uid andGid:gid];
        if (!ok) {
            return NO;
        }
    }
    return YES;
}

- (NSMutableArray *)groupMembersForUid:(NSString *)uid andGid:(NSString *)gid
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_GROUP_MEMBERS, GROUP_MEMBER_TABLE_NAMGE, uid];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            TLUser *user = [[TLUser alloc] init];
            user.userID = [retSet stringForColumn:@"uid"];
            user.username = [retSet stringForColumn:@"username"];
            user.nikeName = [retSet stringForColumn:@"nikename"];
            user.avatarURL = [retSet stringForColumn:@"avatar"];
            user.remarkName = [retSet stringForColumn:@"remark"];
            [data addObject:user];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteGroupMemberForUid:(NSString *)uid gid:(NSString *)gid andFid:(NSString *)fid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_GROUP_MEMBER, GROUP_MEMBER_TABLE_NAMGE, uid, gid, fid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

@end
