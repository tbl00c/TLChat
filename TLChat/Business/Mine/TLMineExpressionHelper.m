//
//  TLMineExpressionHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineExpressionHelper.h"
#import "TLDBExpressionStore.h"

@interface TLMineExpressionHelper ()

@property (nonatomic, strong) TLDBExpressionStore *store;

@end

@implementation TLMineExpressionHelper

- (NSMutableArray *)myExpressionData
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableArray *myEmojiGroups = [NSMutableArray arrayWithArray:[self.store expressionGroupsByUid:[TLUserHelper sharedHelper].userID]];
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

- (BOOL)deleteExpressionGroupByID:(NSString *)groupID
{
    return [self.store deleteExpressionGroupByID:groupID forUid:[TLUserHelper sharedHelper].userID];
}

#pragma mark - # Getter -
- (TLDBExpressionStore *)store
{
    if (_store == nil) {
        _store = [[TLDBExpressionStore alloc] init];
    }
    return _store;
}

@end
