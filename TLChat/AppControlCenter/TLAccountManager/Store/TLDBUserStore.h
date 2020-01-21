//
//  TLDBUserStore.h
//  TLChat
//
//  Created by 李伯坤 on 2017/3/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLDBBaseStore.h"

@class TLUser;
@interface TLDBUserStore : TLDBBaseStore

/**
 *  更新用户信息
 */
- (BOOL)updateUser:(TLUser *)user;

/**
 *  获取用户信息
 */
- (TLUser *)userByID:(NSString *)userID;

/**
 *  查询所有用户
 */
- (NSArray *)userData;

/**
 *  删除用户
 */
- (BOOL)deleteUsersByUid:(NSString *)uid;

@end
