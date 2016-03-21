
//
//  TLDBConversationSQL.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLDBConversationSQL_h
#define TLDBConversationSQL_h

#define     CONV_TABLE_NAME             @"conversation"


#define     SQL_CREATE_CONV_TABLE       @"CREATE TABLE IF NOT EXISTS %@(\
                                        uid TEXT,\
                                        fid TEXT,\
                                        conv_type INTEGER DEFAULT (0), \
                                        date TEXT,\
                                        unread_count INTEGER DEFAULT (0),\
                                        ext1 TEXT,\
                                        ext2 TEXT,\
                                        ext3 TEXT,\
                                        ext4 TEXT,\
                                        ext5 TEXT,\
                                        PRIMARY KEY(uid, fid))"


#define     SQL_ADD_CONV                @"REPLACE INTO %@ ( uid, fid, conv_type, date, unread_count, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"


#define     SQL_SELECT_CONVS            @"SELECT * FROM %@ WHERE uid = %@ ORDER BY date DESC"
#define     SQL_SELECT_CONV_UNREAD      @"SELECT unread_count FROM %@ WHERE uid = '%@' and fid = '%@'"


#define     SQL_DELETE_CONV             @"DELETE FROM %@ WHERE uid = '%@' and fid = '%@'"
#define     SQL_DELETE_ALL_CONVS        @"DELETE FROM %@ WHERE uid = '%@'"

#endif /* TLDBConversationSQL_h */
