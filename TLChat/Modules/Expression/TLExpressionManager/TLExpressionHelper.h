//
//  TLExpressionHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLExpressionGroupModel.h"

@interface TLExpressionHelper : NSObject

/// 默认表情（Face）
@property (nonatomic, strong, readonly) TLExpressionGroupModel *defaultFaceGroup;

/// 默认系统Emoji
@property (nonatomic, strong, readonly) TLExpressionGroupModel *defaultSystemEmojiGroup;

/// 用户表情组
@property (nonatomic, strong, readonly) NSArray *userEmojiGroups;

/// 用户收藏的表情
@property (nonatomic, strong, readonly) TLExpressionGroupModel *userPreferEmojiGroup;


+ (TLExpressionHelper *)sharedHelper;

/**
 *  根据groupID获取表情包
 */
- (TLExpressionGroupModel *)emojiGroupByID:(NSString *)groupID;

/**
 *  添加表情包
 */
- (BOOL)addExpressionGroup:(TLExpressionGroupModel *)emojiGroup;

/**
 *  删除表情包
 */
- (BOOL)deleteExpressionGroupByID:(NSString *)groupID;

- (void)updateExpressionGroupModelsStatus:(NSArray *)groupModelArray;


#pragma mark - 下载表情包
- (void)downloadExpressionsWithGroupInfo:(TLExpressionGroupModel *)group
                                progress:(void (^)(CGFloat progress))progress
                                 success:(void (^)(TLExpressionGroupModel *group))success
                                 failure:(void (^)(TLExpressionGroupModel *group, NSString *error))failure;


@end
