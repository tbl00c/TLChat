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
    group1.dataPath = [[NSBundle mainBundle] pathForResource:@"FaceEmoji" ofType:@"json"];
    TLEmojiGroup *group2 = [[TLEmojiGroup alloc] init];
    group2.type = TLEmojiGroupTypeEmoji;
    group2.groupIconPath = @"emojiKB_group_face";
    group2.dataPath = [[NSBundle mainBundle] pathForResource:@"SystemEmoji" ofType:@"json"];
    TLEmojiGroup *group3 = [[TLEmojiGroup alloc] init];
    group3.type = TLEmojiGroupTypeImage;
    group3.groupIconPath = @"emojiKB_group_tusiji";
    group3.dataPath = [[NSBundle mainBundle] pathForResource:@"TusijiEmoji" ofType:@"json"];
    TLEmojiGroup *group4 = [[TLEmojiGroup alloc] init];
    group4.type = TLEmojiGroupTypeImageWithTitle;
    group4.groupIconPath = @"emojiKB_group_tusiji";
    group4.dataPath = [[NSBundle mainBundle] pathForResource:@"TusijiTitleEmoji" ofType:@"json"];
    [self.emojiGroupData addObjectsFromArray:@[group1, group2, group3, group4]];
}

+ (NSMutableArray *)getEmojiDataByPath:(NSString *)path
{
    if (path == nil) {
        return nil;
    }
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = [TLEmoji mj_objectArrayWithKeyValuesArray:jsonArray];
    return [NSMutableArray arrayWithArray:array];
}

@end
