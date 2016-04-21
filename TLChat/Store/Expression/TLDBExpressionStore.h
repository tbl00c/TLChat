//
//  TLDBExpressionStore.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseStore.h"
#import "TLEmojiGroup.h"

@interface TLDBExpressionStore : TLDBBaseStore

/**
 *  添加表情包
 */
- (BOOL)addExpressionGroup:(TLEmojiGroup *)group forUid:(NSString *)uid;

/**
 *  查询所有表情包
 */
- (NSArray *)expressionGroupsByUid:(NSString *)uid;

/**
 *  删除表情包
 */
- (BOOL)deleteExpressionGroupByID:(NSString *)gid forUid:(NSString *)uid;

/**
 *  拥有某表情包的用户数
 */
- (NSInteger)countOfUserWhoHasExpressionGroup:(NSString *)gid;


@end
