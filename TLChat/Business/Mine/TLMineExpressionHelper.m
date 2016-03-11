//
//  TLMineExpressionHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineExpressionHelper.h"
#import "TLEmojiKBHelper.h"

@implementation TLMineExpressionHelper

- (NSMutableArray *)myExpressionDataByUserID:(NSString *)userID
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableArray *myEmojiGroups = [[TLEmojiKBHelper sharedKBHelper] userEmojiGroupsByUserID:userID];
    if (myEmojiGroups) {
        TLSettingGroup *group1 = TLCreateSettingGroup(@"聊天面板中的表情", nil, myEmojiGroups);
        [data addObject:group1];
    }
    
    TLSettingItem *userEmojis = TLCreateSettingItem(@"添加的表情");
    TLSettingItem *buyedEmojis = TLCreateSettingItem(@"购买的表情");
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[userEmojis, buyedEmojis]));
    [data addObject:group2];
    
    return data;

}

@end
