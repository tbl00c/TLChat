//
//  TLExpressionHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionHelper.h"

static TLExpressionHelper *helper = nil;

@implementation TLExpressionHelper

+ (id)sharedHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[TLExpressionHelper alloc] init];
    });
    return helper;
}

- (void)downloadExpressionsWithGroupInfo:(TLEmojiGroup *)group
                                progress:(void (^)(CGFloat))progress
                                 success:(void (^)(TLEmojiGroup *))success
                                 failure:(void (^)(TLEmojiGroup *, NSString *))failure
{
    NSString *path = [NSFileManager pathExpressionForGroupID:group.groupID];
    dispatch_queue_t downloadQueue = dispatch_queue_create([group.groupID UTF8String], nil);
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    for (int i = 0; i <= group.data.count; i++) {
        dispatch_group_async(downloadGroup, downloadQueue, ^{
            NSString *emojiUrl = @"";
            NSString *emojiName = @"";
            if (i == group.data.count) {
                emojiUrl = group.groupIconURL;
                emojiName = [NSString stringWithFormat:@"icon_%@.png", group.groupID];
            }
            else {
                TLEmoji *emoji = group.data[i];
                emojiUrl = [TLHost expressionDownloadURLWithEid:emoji.emojiID];
                emojiName = [emoji.emojiID stringByAppendingString:@".gif"];
            }
            NSString *emojiPath = [path stringByAppendingString:emojiName];
            NSData *data = [NSData dataWithContentsOfURL:TLURL(emojiUrl)];
            [data writeToFile:emojiPath atomically:YES];
        });
    }
    dispatch_group_notify(downloadGroup, downloadQueue, ^{
        success(group);
    });
}

@end
