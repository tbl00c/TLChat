//
//  TLEmojiGroupDisplayModel.h
//  TLChat
//
//  Created by 李伯坤 on 16/9/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEmojiGroup.h"

@interface TLEmojiGroupDisplayModel : NSObject

/// 基本信息
@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSString *groupIconPath;

/// 总数
@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, strong) NSMutableArray *data;

#pragma mark - 展示用

/// 每页个数
@property (nonatomic, assign) NSUInteger pageItemCount;

/// 页数
@property (nonatomic, assign) NSUInteger pageNumber;

/// 行数
@property (nonatomic, assign) NSUInteger rowNumber;

/// 列数
@property (nonatomic, assign) NSUInteger colNumber;


- (id)initWithEmojiGroup:(TLEmojiGroup *)emojiGroup pageNumber:(NSInteger)pageNumber andCount:(NSInteger)count;

- (id)objectAtIndex:(NSUInteger)index;

- (void)addEmoji:(TLEmoji *)emoji;

@end
