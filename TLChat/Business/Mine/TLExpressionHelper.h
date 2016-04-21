//
//  TLExpressionHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLSettingGroup.h"
#import "TLEmojiGroup.h"

@interface TLExpressionHelper : NSObject

/// 默认表情（Face）
@property (nonatomic, strong, readonly) TLEmojiGroup *defaultFaceGroup;

/// 默认系统Emoji
@property (nonatomic, strong, readonly) TLEmojiGroup *defaultSystemEmojiGroup;

/// 用户表情组
@property (nonatomic, strong, readonly) NSArray *userEmojiGroups;

/// 用户收藏的表情
@property (nonatomic, strong, readonly) TLEmojiGroup *userPreferEmojiGroup;


+ (TLExpressionHelper *)sharedHelper;

/**
 *  根据groupID获取表情包
 */
- (TLEmojiGroup *)emojiGroupByID:(NSString *)groupID;

/**
 *  添加表情包
 */
- (BOOL)addExpressionGroup:(TLEmojiGroup *)emojiGroup;

/**
 *  删除表情包
 */
- (BOOL)deleteExpressionGroupByID:(NSString *)groupID;

/**
 *  表情包是否被其他用户使用
 *
 *  用来判断是否可删除表情包文件
 */
- (BOOL)didExpressionGroupAlwaysInUsed:(NSString *)groupID;


#pragma mark - 下载表情包
- (void)downloadExpressionsWithGroupInfo:(TLEmojiGroup *)group
                                progress:(void (^)(CGFloat progress))progress
                                 success:(void (^)(TLEmojiGroup *group))success
                                 failure:(void (^)(TLEmojiGroup *group, NSString *error))failure;


#pragma mark - 列表用
/**
 *  列表数据 — 我的表情
 */
- (NSMutableArray *)myExpressionListData;

@end
