//
//  NSFileManager+TLChat.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+Paths.h"

@interface NSFileManager (TLChat)

+ (NSString *)pathUserSettingImage:(NSString *)imageName forUser:(NSString *)userID;

+ (NSString *)pathUserChatImage:(NSString*)imageName forUser:(NSString *)userID;

+ (NSString *)pathUserChatAvatarImage:(NSString *)imageName forUser:(NSString *)userID;

+ (NSString *)pathContactsAvatar;

@end
