//
//  TLEmojiKBHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKBHelper.h"
#import "TLEmojiGroup.h"

@implementation TLEmojiKBHelper

- (id) init
{
    if (self = [super init]) {
        self.emojiGroupData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLEmojiGroup *group1 = [[TLEmojiGroup alloc] init];
    group1.type = TLEmojiGroupTypeFace;
    group1.groupIconPath = @"emojiKB_group_face";
    TLEmojiGroup *group2 = [[TLEmojiGroup alloc] init];
    group2.type = TLEmojiGroupTypeEmoji;
    group2.groupIconPath = @"emojiKB_group_face";
    TLEmojiGroup *group3 = [[TLEmojiGroup alloc] init];
    group3.type = TLEmojiGroupTypeImage;
    group3.groupIconPath = @"emojiKB_group_face";
    TLEmojiGroup *group4 = [[TLEmojiGroup alloc] init];
    group4.type = TLEmojiGroupTypeImageWithTitle;
    group4.groupIconPath = @"emojiKB_group_face";
    [self.emojiGroupData addObjectsFromArray:@[group1, group2, group3, group4]];
    
}

@end
