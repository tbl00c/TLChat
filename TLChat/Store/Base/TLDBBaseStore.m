//
//  TLDBBaseStore.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseStore.h"

@implementation TLDBBaseStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [TLDBManager sharedInstance].commonQueue;
    }
    return self;
}

- (BOOL)createTable:(NSString*)tableName withSqlString:(NSString*)sqlString
{
    __block BOOL ok = YES;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if(![db tableExists:tableName]){
            ok = [db executeUpdate:sqlString withArgumentsInArray:nil];
        }
    }];
    return ok;
}

@end
