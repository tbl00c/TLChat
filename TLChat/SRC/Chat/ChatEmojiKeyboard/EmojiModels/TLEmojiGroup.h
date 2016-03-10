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

@property (nonatomic, strong) NSString *groupIconPath;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSString *dataPath;

/**
 *  总数
 */
@property (nonatomic, assign) NSUInteger count;

/**
 *  每页个数
 */
@property (nonatomic, assign) NSUInteger pageItemNumber;

/**
 *  页数
 */
@property (nonatomic, assign) NSUInteger pageNumber;

/**
 *  行数
 */
@property (nonatomic, assign) NSUInteger lineNumber;

/**
 *  列数
 */
@property (nonatomic, assign) NSUInteger rowNumber;

- (id)objectAtIndex:(NSUInteger)index;

@end
