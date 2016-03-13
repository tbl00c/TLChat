//
//  TLDBBaseStore.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLDBManager.h"

@interface TLDBBaseStore : NSObject

/// 数据库操作队列(从TLDBManager中获取，默认使用commonQueue)
@property (nonatomic, weak) FMDatabaseQueue *dbQueue;


- (BOOL)createTable:(NSString*)tableName withSqlString:(NSString*)sqlString;

@end
