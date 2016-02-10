//
//  TLNewMessageSettingHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNewMessageSettingHelper.h"

@implementation TLNewMessageSettingHelper

- (id) init
{
    if (self = [super init]) {
        self.mineNewMessageSettingData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"接受新消息通知");
    item1.subTitle = @"已开启";
    item1.showDisclosureIndicator = NO;
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, @"如果你要关闭或开启微信的新消息通知，请在iPhone的“设置” - “通知”功能中，找到应用程序“微信”更改。", @[item1]);
    
    TLSettingItem *item2 = TLCreateSettingItem(@"通知显示消息详情");
    item2.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, @"关闭后，当收到微信消息时，通知提示将不显示发信人和内容摘要。", @[item2]);
    
    TLSettingItem *item3 = TLCreateSettingItem(@"功能消息免打扰");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, @"设置系统功能消息提示声音和振动时段。", @[item3]);
    
    TLSettingItem *item4 = TLCreateSettingItem(@"声音");
    item4.type = TLSettingItemTypeSwitch;
    TLSettingItem *item5 = TLCreateSettingItem(@"震动");
    item5.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group4 = TLCreateSettingGroup(nil, @"当微信在运行时，你可以设置是否需要声音或者振动。", (@[item4, item5]));
    
    TLSettingItem *item6 = TLCreateSettingItem(@"朋友圈照片更新");
    item6.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group5 = TLCreateSettingGroup(nil, @"关闭后，有朋友更新照片时，界面下面的“发现”切换按钮上不再出现红点提示。", @[item6]);
    
    [self.mineNewMessageSettingData addObjectsFromArray:@[group1, group2, group3, group4, group5]];
}

@end
