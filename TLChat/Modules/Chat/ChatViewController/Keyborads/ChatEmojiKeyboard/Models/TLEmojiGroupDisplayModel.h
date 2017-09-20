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

@property (nonatomic, assign) TLEmojiType type;

@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSString *groupIconPath;

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, strong) NSArray *data;

#pragma mark - 标记

@property (nonatomic, assign) NSInteger emojiGroupIndex;

@property (nonatomic, assign) NSInteger pageIndex;

#pragma mark - 展示用

/// 每页个数
@property (nonatomic, assign) NSUInteger pageItemCount;

/// 页数
@property (nonatomic, assign) NSUInteger pageNumber;

/// 行数
@property (nonatomic, assign) NSUInteger rowNumber;

/// 列数
@property (nonatomic, assign) NSUInteger colNumber;

@property (nonatomic, assign) CGSize cellSize;

@property (nonatomic, assign) UIEdgeInsets sectionInsets;


- (id)initWithEmojiGroup:(TLEmojiGroup *)emojiGroup pageNumber:(NSInteger)pageNumber andCount:(NSInteger)count;

- (id)objectAtIndex:(NSUInteger)index;

- (void)addEmoji:(TLEmoji *)emoji;

@end
