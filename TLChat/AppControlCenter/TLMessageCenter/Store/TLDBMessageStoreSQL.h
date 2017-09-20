//
//  TLDBMessageStoreSQL.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLDBMessageStoreSQL_h
#define TLDBMessageStoreSQL_h

#define     MESSAGE_TABLE_NAME              @"message"


#define     SQL_CREATE_MESSAGE_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                            msgid TEXT,\
                                            uid TEXT,\
                                            fid TEXT,\
                                            subfid TEXT,\
                                            date TEXT,\
                                            partner_type INTEGER DEFAULT (0),\
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
                                            PRIMARY KEY(uid, msgid, fid, subfid))"


#define     SQL_ADD_MESSAGE                 @"REPLACE INTO %@ ( msgid, uid, fid, subfid, date, partner_type, own_type, msg_type, content, send_status, received_status, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"


#define     SQL_SELECT_MESSAGES_PAGE        @"SELECT * FROM %@ WHERE uid = '%@' and fid = '%@' and date < '%@' order by date desc LIMIT '%ld'"
#define     SQL_SELECT_CHAT_FILES           @"SELECT * FROM %@ WHERE uid = '%@' and fid = '%@' and msg_type = '2'"
#define     SQL_SELECT_CHAT_MEDIA           @"SELECT * FROM %@ WHERE uid = '%@' and fid = '%@' and msg_type = '2'"
#define     SQL_SELECT_LAST_MESSAGE         @"SELECT * FROM %@ WHERE date = ( SELECT MAX(date) FROM %@ WHERE uid = '%@' and fid = '%@' )"


#define     SQL_DELETE_MESSAGE              @"DELETE FROM %@ WHERE msgid = '%@'"
#define     SQL_DELETE_FRIEND_MESSAGES      @"DELETE FROM %@ WHERE uid = '%@' and fid = '%@'"
#define     SQL_DELETE_USER_MESSAGES        @"DELETE FROM %@ WHERE uid = '%@'"


#endif /* TLDBMessageStoreSQL_h */
