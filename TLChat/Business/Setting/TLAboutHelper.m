//
//  TLAboutHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAboutHelper.h"

@implementation TLAboutHelper

- (id) init
{
    if (self = [super init]) {
        self.abouSettingtData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"去评分");
    TLSettingItem *item2 = TLCreateSettingItem(@"欢迎页");
    TLSettingItem *item3 = TLCreateSettingItem(@"功能介绍");
    TLSettingItem *item4 = TLCreateSettingItem(@"系统通知");
    TLSettingItem *item5 = TLCreateSettingItem(@"举报与投诉");
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, (@[item1, item2, item3, item4, item5]));
    [self.abouSettingtData addObjectsFromArray:@[group1]];
}

@end
