//
//  TLDBExpressionSQL.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLDBExpressionSQL_h
#define TLDBExpressionSQL_h

#pragma mark - # 表情组
#define     EXP_GROUP_TABLE_NAME             @"expression_group"

#define     SQL_CREATE_EXP_GROUP_TABLE       @"CREATE TABLE IF NOT EXISTS %@(\
                                            uid TEXT,\
                                            gid TEXT,\
                                            type INTEGER DEFAULT (0), \
                                            name TEXT,\
                                            desc TEXT,\
                                            detail TEXT,\
                                            count INTEGER DEFAULT (0), \
                                            auth_id TEXT,\
                                            auth_name TEXT,\
                                            date TEXT,\
                                            ext1 TEXT,\
                                            ext2 TEXT,\
                                            ext3 TEXT,\
                                            ext4 TEXT,\
                                            ext5 TEXT,\
                                            PRIMARY KEY(uid, gid))"


#define     SQL_ADD_EXP_GROUP           @"REPLACE INTO %@ ( uid, gid, type, name, desc, detail, count, auth_id, auth_name, date, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )"

#define     SQL_SELECT_EXP_GROUP        @"SELECT * FROM %@ WHERE uid = '%@' order by date desc"

#define     SQL_DELETE_EXP_GROUP        @"DELETE FROM %@ WHERE uid = '%@' and gid = '%@'"

#define     SQL_SELECT_COUNT_EXP_GROUP_USERS    @"SELECT count(uid) FROM %@ WHERE gid = '%@'"

#pragma mark - # 表情
#define     EXPS_TABLE_NAME             @"expressions"

#define     SQL_CREATE_EXPS_TABLE       @"CREATE TABLE IF NOT EXISTS %@(\
                                        gid TEXT,\
                                        eid TEXT, \
                                        name TEXT,\
                                        ext1 TEXT,\
                                        ext2 TEXT,\
                                        ext3 TEXT,\
                                        ext4 TEXT,\
                                        ext5 TEXT,\
                                        PRIMARY KEY(gid, eid))"


#define     SQL_ADD_EXP           @"REPLACE INTO %@ ( gid, eid, name, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ? )"

#define     SQL_SELECT_EXPS        @"SELECT * FROM %@ WHERE gid = '%@'"


#endif /* TLDBExpressionSQL_h */
