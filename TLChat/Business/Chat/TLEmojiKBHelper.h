//
//  TLEmojiKBHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEmojiGroup.h"

@interface TLEmojiKBHelper : NSObject

@property (nonatomic, strong) NSMutableArray *emojiGroupData;

+ (NSMutableArray *)getEmojiDataByPath:(NSString *)path;

@end
