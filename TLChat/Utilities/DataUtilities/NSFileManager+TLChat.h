//
//  NSFileManager+TLChat.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+Paths.h"

@interface NSFileManager (TLChat)

/**
 *  图片 — 设置
 */
+ (NSString *)pathUserSettingImage:(NSString *)imageName;

/**
 *  图片 — 聊天
 */
+ (NSString *)pathUserChatImage:(NSString*)imageName;

/**
 *  图片 — 聊天背景
 */
+ (NSString *)pathUserChatBackgroundImage:(NSString *)imageName;

/**
 *  图片 — 用户头像
 */
+ (NSString *)pathUserAvatar:(NSString *)imageName;

/**
 *  图片 — 屏幕截图
 */
+ (NSString *)pathScreenshotImage:(NSString *)imageName;

/**
 *  图片 — 本地通讯录
 */
+ (NSString *)pathContactsAvatar:(NSString *)imageName;

/**
 *  聊天语音
 */
+ (NSString *)pathUserChatVoice:(NSString *)voiceName;

/**
 *  表情
 */
+ (NSString *)pathExpressionForGroupID:(NSString *)groupID;

/**
 *  数据 — 本地通讯录
 */
+ (NSString *)pathContactsData;

/**
 *  数据库 — 通用
 */
+ (NSString *)pathDBCommon;

/**
 *  数据库 — 聊天
 */
+ (NSString *)pathDBMessage;

/**
 *  缓存
 */
+ (NSString *)cacheForFile:(NSString *)filename;


@end
