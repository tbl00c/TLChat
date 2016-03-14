//
//  TLDBMessageStoreSQL.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLDBMessageStoreSQL_h
#define TLDBMessageStoreSQL_h

#define     MESSAGE_TABLE_NAME      @"message"

#define     CREATE_TABLE_SQL        @"CREATE TABLE IF NOT EXISTS %@(\
                                    msgid TEXT,\
                                    uid TEXT,\
                                    fid TEXT,\
                                    date TEXT,\
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

#define     ADD_MESSAGE_SQL         @"REPLACE INTO %@ ( msgid, uid, fid, date, own_type, msg_type, content, send_status, received_status, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"


#define     MESSAGES_PAGE_SQL   @"SELECT * FROM %@ WHERE uid = '%@' and fid = '%@' and date < '%@' order by date desc LIMIT '%ld'"

#endif /* TLDBMessageStoreSQL_h */
