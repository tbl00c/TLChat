//
//  TLDBMessageStore.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBMessageStore.h"

#define     MESSAGE_TABLE_NAME      @"message"
#define     CREATE_TABLE            @"CREATE TABLE IF NOT EXISTS %@(\
                                    msgid TEXT,\
                                    uid TEXT,\
                                    fid TEXT,\
                                    date DATE,\
                                    own_type INTEGER DEFAULT (0),\
                                    msg_type INTEGER DEFAULT (0),\
                                    content TEXT,\
                                    send_status INTEGER DEFAULT (0),\
                                    received_status BOOLEAN DEFAULT (0),\
                                    ext1 TEXT,\
                                    ext2 TEXT,\
                                    ext3 TEXT,\
                                    ext4 TEXT,\
                                    ext5 TEXT,\
                                    PRIMARY KEY(uid, msgid, fid))"


@implementation TLDBMessageStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [TLDBManager sharedInstance].messageQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 聊天记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:CREATE_TABLE, MESSAGE_TABLE_NAME];
    return [self createTable:MESSAGE_TABLE_NAME withSqlString:sqlString];
}

- (BOOL)addMessage:(TLDBMessage *)message
{
    return YES;
}

@end
