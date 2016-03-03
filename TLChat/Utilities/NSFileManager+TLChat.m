//
//  NSFileManager+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "NSFileManager+TLChat.h"

@implementation NSFileManager (TLChat)

+ (NSString *)pathUserSettingImage:(NSString *)userID
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Setting/Images/", [NSFileManager documentsPath], userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return path;
}

@end
