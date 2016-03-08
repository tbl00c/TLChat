//
//  TLConversation.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLConversation : NSObject


/**
 *  会话类型（个人，讨论组，企业号）
 */
@property (nonatomic, assign) TLConversationType convType;

/**
 *  消息提醒类型
 */
@property (nonatomic, assign) TLMessageRemindType remindType;

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *userID;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;

/**
 *  头像地址（网络）
 */
@property (nonatomic, strong) NSString *avatarURL;

/**
 *  头像地址（本地）
 */
@property (nonatomic, strong) NSString *avatarPath;

/**
 *  时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 *  消息类型
 */
@property (nonatomic, assign) TLMessageType messageType;

/**
 *  消息展示内容
 */
@property (nonatomic, strong) NSString *messageDetail;

/**
 *  提示红点类型
 */
@property (nonatomic, assign) TLClueType clueType;

/**
 *  是否已读
 */
@property (nonatomic, assign) BOOL isRead;

/**
 *  提示数量
 */
@property (nonatomic, assign) NSInteger clueNumber;


@end
