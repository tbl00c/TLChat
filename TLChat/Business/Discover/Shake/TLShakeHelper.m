//
//  TLShakeHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLShakeHelper.h"
#import "TLSettingGroup.h"

@implementation TLShakeHelper

- (id) init
{
    if (self = [super init]) {
        self.shakeSettingData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"使用默认背景图片");
    item1.showDisclosureIndicator = NO;
    TLSettingItem *item2 = TLCreateSettingItem(@"换张背景图片");
    TLSettingItem *item3 = TLCreateSettingItem(@"音效");
    item3.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, (@[item1, item2, item3]));
    
    TLSettingItem *item5 = TLCreateSettingItem(@"打招呼的人");
    TLSettingItem *item6 = TLCreateSettingItem(@"摇到的历史");
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[item5, item6]));
    
    TLSettingItem *item7 = TLCreateSettingItem(@"摇一摇消息");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, (@[item7]));
    
    [self.shakeSettingData addObjectsFromArray:@[group1, group2, group3]];
}


@end
