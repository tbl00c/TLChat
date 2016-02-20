//
//  TLEmojiGroup.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLChatMacros.h"
#import "tlemoji.h"

@interface TLEmojiGroup : NSObject

@property (nonatomic, assign) TLEmojiGroupType type;

@property (nonatomic, strong) NSString *groupIconPath;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, assign) NSUInteger pageItemNumber;

@property (nonatomic, assign) NSUInteger pageNumber;

@property (nonatomic, assign) NSUInteger lineNumber;

@property (nonatomic, assign) NSUInteger rowNumber;

- (id)objectAtIndex:(NSUInteger)index;

@end
