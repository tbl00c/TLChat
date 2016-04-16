//
//  TLEmojiKBHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKBHelper.h"
#import "TLExpressionHelper.h"
#import "TLEmojiGroup.h"

static TLEmojiKBHelper *helper;

@interface TLEmojiKBHelper ()

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, strong) NSMutableArray *systemEmojiGroups;

@property (nonatomic, strong) void (^complete)(NSMutableArray *);

@end

@implementation TLEmojiKBHelper

+ (TLEmojiKBHelper *)sharedKBHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[TLEmojiKBHelper alloc] init];
    });
    return helper;
}

- (void)updateEmojiGroupData
{
    if (self.userID && self.complete) {
        [self emojiGroupDataByUserID:self.userID complete:self.complete];
    }
}

- (void)emojiGroupDataByUserID:(NSString *)userID complete:(void (^)(NSMutableArray *))complete
{
    self.userID = userID;
    self.complete = complete;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *emojiGroupData = [[NSMutableArray alloc] init];
        
        // 默认表情包
        NSArray *defaultEmojiGroups = @[[TLExpressionHelper sharedHelper].defaultFaceGroup,
                                        [TLExpressionHelper sharedHelper].defaultSystemEmojiGroup];
        [emojiGroupData addObject:defaultEmojiGroups];
        
        // 用户收藏的表情包
        TLEmojiGroup *preferEmojiGroup = [TLExpressionHelper sharedHelper].userPreferEmojiGroup;
        if (preferEmojiGroup && preferEmojiGroup.count > 0) {
            [emojiGroupData addObject:@[preferEmojiGroup]];
        }
        
        // 用户的表情包
        NSArray *userGroups = [TLExpressionHelper sharedHelper].userEmojiGroups;
        if (userGroups && userGroups.count > 0) {
            [emojiGroupData addObject:userGroups];
        }
        
        // 系统设置
        [emojiGroupData addObject:self.systemEmojiGroups];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(emojiGroupData);
        });
    });
}

#pragma mark - Getter -
- (NSMutableArray *)systemEmojiGroups
{
    if (_systemEmojiGroups == nil) {
        TLEmojiGroup *editGroup = [[TLEmojiGroup alloc] init];
        editGroup.type = TLEmojiTypeOther;
        editGroup.groupIconPath = @"emojiKB_settingBtn";
        _systemEmojiGroups = [[NSMutableArray alloc] initWithObjects:editGroup, nil];
    }
    return _systemEmojiGroups;
}


@end
