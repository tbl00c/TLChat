//
//  TLExpressionGroupModel.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLChatMacros.h"
#import "TLExpressionModel.h"

typedef NS_ENUM(NSInteger, TLExpressionGroupStatus) {
    TLExpressionGroupStatusNet,                     // 未下载
    TLExpressionGroupStatusDownloading,             // 正在下载
    TLExpressionGroupStatusLocal,                   // 已下载
};

@interface TLExpressionGroupModel: NSObject

@property (nonatomic, assign) TLEmojiType type;

/// 表情包id
@property (nonatomic, strong) NSString *gId;

/// 表情包名称
@property (nonatomic, strong) NSString *name;
/// 表情包描述
@property (nonatomic, strong) NSString *detail;

/// 表情包icon路径
@property (nonatomic, strong) NSString *iconPath;
/// 表情包iconURL
@property (nonatomic, strong) NSString *iconURL;

/// 表情包bannerId
@property (nonatomic, strong) NSString *bannerId;
/// 表情包bannerURL
@property (nonatomic, strong) NSString *bannerURL;

/// 表情
@property (nonatomic, strong) NSMutableArray *data;
/// 表情总数
@property (nonatomic, assign) NSUInteger count;

/// 详细信息
@property (nonatomic, strong) NSString *groupInfo;
/// 发布日期
@property (nonatomic, strong) NSDate *date;

/// 作者姓名
@property (nonatomic, strong) NSString *authName;
/// 作者Id
@property (nonatomic, strong) NSString *authID;

/// 表情包状态
@property (nonatomic, assign) TLExpressionGroupStatus status;

/// 表情包路径
@property (nonatomic, strong, readonly) NSString *path;

/// 下载进度
@property (nonatomic, assign) CGFloat downloadProgress;
/// 下载进度block
@property (nonatomic, copy) void (^downloadProgressAction)(TLExpressionGroupModel *groupModel, CGFloat progress);
/// 下载完成block
@property (nonatomic, copy) void (^downloadCompleteAction)(TLExpressionGroupModel *groupModel, BOOL success, id data);

- (id)objectAtIndex:(NSUInteger)index;

@end


