//
//  TLSettingHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingHelper.h"

@implementation TLSettingHelper

- (id) init
{
    if (self = [super init]) {
        self.mineSettingData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"账号与安全");
//    if () {
        item1.subTitle = @"已保护";
        item1.rightImagePath = @"setting_lockon";
//    }
//    else {
//        item1.subTitle = @"为保护";
//        item1.rightImagePath = @"setting_lockoff";
//    }
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[item1]);
    
    TLSettingItem *item2 = TLCreateSettingItem(@"新消息通知");
    TLSettingItem *item3 = TLCreateSettingItem(@"隐私");
    TLSettingItem *item4 = TLCreateSettingItem(@"通用");
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[item2, item3, item4]));
    
    TLSettingItem *item5 = TLCreateSettingItem(@"帮助与反馈");
    TLSettingItem *item6 = TLCreateSettingItem(@"关于微信");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, (@[item5, item6]));
    
    TLSettingItem *item7 = TLCreateSettingItem(@"退出登录");
    item7.type = TLSettingItemTypeTitleButton;
    TLSettingGroup *group4 = TLCreateSettingGroup(nil, nil, @[item7]);
    
    [self.mineSettingData addObjectsFromArray:@[group1, group2, group3, group4]];
}

@end
