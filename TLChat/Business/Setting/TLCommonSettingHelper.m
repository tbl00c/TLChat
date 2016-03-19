//
//  TLCommonSettingHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLCommonSettingHelper.h"

@implementation TLCommonSettingHelper

+ (NSMutableArray *)chatBackgroundSettingData
{
    TLSettingItem *select = TLCreateSettingItem(@"选择背景图");
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[select]);
    
    TLSettingItem *album = TLCreateSettingItem(@"从手机相册中选择");
    TLSettingItem *camera = TLCreateSettingItem(@"拍一张");
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[album, camera]));
    
    TLSettingItem *toAll = TLCreateSettingItem(@"将背景应用到所有聊天场景");
    toAll.type = TLSettingItemTypeTitleButton;
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, @[toAll]);
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:group1, group2, group3, nil];
    return data;
}


- (id) init
{
    if (self = [super init]) {
        self.commonSettingData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"多语言");
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[item1]);
    
    TLSettingItem *item2 = TLCreateSettingItem(@"字体大小");
    TLSettingItem *item3 = TLCreateSettingItem(@"聊天背景");
    TLSettingItem *item4 = TLCreateSettingItem(@"我的表情");
    TLSettingItem *item5 = TLCreateSettingItem(@"朋友圈小视频");
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[item2, item3, item4, item5]));
    
    TLSettingItem *item6 = TLCreateSettingItem(@"听筒模式");
    item6.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, @[item6]);
    
    TLSettingItem *item7 = TLCreateSettingItem(@"功能");
    TLSettingGroup *group4 = TLCreateSettingGroup(nil, nil, @[item7]);
    
    TLSettingItem *item8 = TLCreateSettingItem(@"聊天记录迁移");
    TLSettingItem *item9 = TLCreateSettingItem(@"清理微信存储空间");
    TLSettingGroup *group5 = TLCreateSettingGroup(nil, nil, (@[item8, item9]));
    
    TLSettingItem *item10 = TLCreateSettingItem(@"清空聊天记录");
    item10.type = TLSettingItemTypeTitleButton;
    TLSettingGroup *group6 = TLCreateSettingGroup(nil, nil, @[item10]);
    
    [self.commonSettingData addObjectsFromArray:@[group1, group2, group3, group4, group5, group6]];
}

@end
