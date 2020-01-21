//
//  TLMobileContactHelper.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/9.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMobileContactModel.h"

@interface TLMobileContactHelper : NSObject

/**
 *  获取通讯录好友
 *
 *  @param success 获取成功，异步返回（通讯录列表，格式化的通讯录列表，格式化的通讯录列表组标题）
 *  @param failed  获取失败
 */
+ (void)tryToGetAllContactsSuccess:(void (^)(NSArray *data, NSArray *formatData, NSArray *headers))success
                            failed:(void (^)())failed;

@end
