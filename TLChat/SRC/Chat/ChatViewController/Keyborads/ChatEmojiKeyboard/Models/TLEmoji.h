//
//  TLEmoji.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLChatMacros.h"

@interface TLEmoji : NSObject

@property (nonatomic, assign) TLEmojiType type;

@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSString *emojiID;

@property (nonatomic, strong) NSString *emojiName;

@property (nonatomic, strong) NSString *emojiPath;

@property (nonatomic, strong) NSString *emojiURL;

@property (nonatomic, assign) CGFloat size;

+ (NSString *)expressionURLWithEid:(NSString *)eid;

+ (NSString *)expressionDownloadURLWithEid:(NSString *)eid;

@end
