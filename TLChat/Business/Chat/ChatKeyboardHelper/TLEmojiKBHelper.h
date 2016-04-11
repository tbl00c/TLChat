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

@property (nonatomic, strong) TLEmojiGroup *defaultFaceGroup;

+ (TLEmojiKBHelper *)sharedKBHelper;

- (void)emojiGroupDataByUserID:(NSString *)userID complete:(void (^)(NSMutableArray *))complete;

- (NSMutableArray *)userEmojiGroupsByUserID:(NSString *)userID;

+ (NSMutableArray *)getEmojisByGroupID:(NSString *)groupID;

@end
