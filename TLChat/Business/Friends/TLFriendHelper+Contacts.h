//
//  TLFriendHelper+Contacts.h
//  TLChat
//
//  Created by libokun on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHelper.h"
#import "TLContact.h"

@interface TLFriendHelper (Contacts)

/**
 *  获取铜须路好友
 *
 *  @param success 获取成功，异步返回（通讯录列表，格式化的通讯录列表，格式化的通讯录列表组标题）
 *  @param failed  获取失败
 */
+ (void)tryToGetAllContactsSuccess:(void (^)(NSArray *data, NSArray *formatData, NSArray *headers))success
                            failed:(void (^)())failed;

@end
