//
//  TLEmojiKBHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLExpressionGroupModel.h"

@interface TLEmojiKBHelper : NSObject

+ (TLEmojiKBHelper *)sharedKBHelper;

- (void)emojiGroupDataByUserID:(NSString *)userID complete:(void (^)(NSMutableArray *))complete;

- (void)updateEmojiGroupData;

@end
