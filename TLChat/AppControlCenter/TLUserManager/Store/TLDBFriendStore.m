//
//  TLDBFriendStore.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBFriendStore.h"
#import "TLDBFriendSQL.h"
#import "TLDBManager.h"
#import "TLUser.h"

@implementation TLDBFriendStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [TLDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            DDLogError(@"DB: 好友表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_FRIENDS_TABLE, FRIENDS_TABLE_NAME];
    return [self createTable:FRIENDS_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addFriend:(TLUser *)user forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_FRIEND, FRIENDS_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(uid),
                        TLNoNilString(user.userID),
                        TLNoNilString(user.username),
                        TLNoNilString(user.nikeName),
                        TLNoNilString(user.avatarURL),
                        TLNoNilString(user.remarkName),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (BOOL)updateFriendsData:(NSArray *)friendData forUid:(NSString *)uid
{
    NSArray *oldData = [self friendsDataByUid:uid];
    if (oldData.count > 0) {
        // 建立新数据的hash表，用于删除数据库中的过时数据
        NSMutableDictionary *newDataHash = [[NSMutableDictionary alloc] init];
        for (TLUser *user in friendData) {
            [newDataHash setValue:@"YES" forKey:user.userID];
        }
        for (TLUser *user in oldData) {
            if ([newDataHash objectForKey:user.userID] == nil) {
                BOOL ok = [self deleteFriendByFid:user.userID forUid:uid];
                if (!ok) {
                    DDLogError(@"DBError: 删除过期好友失败");
                }
            }
        }
    }
    
    for (TLUser *user in friendData) {
        BOOL ok = [self addFriend:user forUid:uid];
        if (!ok) {
            return ok;
        }
    }
    
    return YES;
}

- (NSMutableArray *)friendsDataByUid:(NSString *)uid
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_FRIENDS, FRIENDS_TABLE_NAME, uid];
    
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

- (BOOL)deleteFriendByFid:(NSString *)fid forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_FRIEND, FRIENDS_TABLE_NAME, uid, fid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

@end
