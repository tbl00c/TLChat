//
//  TLEmojiGroup.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLChatMacros.h"
#import "TLEmoji.h"

@interface TLEmojiGroup : NSObject

@property (nonatomic, assign) TLEmojiType type;

/// 基本信息
@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSString *groupIconPath;

@property (nonatomic, strong) NSString *groupIconURL;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSString *path;

/// 详细信息
@property (nonatomic, strong) NSString *groupInfo;

@property (nonatomic, strong) NSString *groupDetailInfo;

/// 作者
@property (nonatomic, strong) NSString *authName;

@property (nonatomic, strong) NSString *authID;



#pragma mark - 展示用
/// 总数
@property (nonatomic, assign) NSUInteger count;

/// 每页个数
@property (nonatomic, assign) NSUInteger pageItemCount;

/// 页数
@property (nonatomic, assign) NSUInteger pageNumber;

/// 行数
@property (nonatomic, assign) NSUInteger rowNumber;

/// 列数
@property (nonatomic, assign) NSUInteger colNumber;

- (id)objectAtIndex:(NSUInteger)index;

@end
