//
//  TLChatDetailHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatDetailHelper.h"

@interface TLChatDetailHelper ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation TLChatDetailHelper

- (id)init
{
    if (self = [super init]) {
        self.data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray *)chatDetailDataByUserInfo:(TLUser *)userInfo
{
    TLSettingItem *users = TLCreateSettingItem(@"users");
    users.type = TLSettingItemTypeOther;
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[users]);
    
    TLSettingItem *top = TLCreateSettingItem(@"置顶聊天");
    top.type = TLSettingItemTypeSwitch;
    TLSettingItem *screen = TLCreateSettingItem(@"消息免打扰");
    screen.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[top, screen]));
    
    TLSettingItem *chatFile = TLCreateSettingItem(@"聊天文件");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, @[chatFile]);
    
    TLSettingItem *chatBG = TLCreateSettingItem(@"设置当前聊天背景");
    TLSettingItem *chatHistory = TLCreateSettingItem(@"查找聊天内容");
    TLSettingGroup *group4 = TLCreateSettingGroup(nil, nil, (@[chatBG, chatHistory]));
    
    TLSettingItem *clear = TLCreateSettingItem(@"清空聊天记录");
    clear.showDisclosureIndicator = NO;
    TLSettingGroup *group5 = TLCreateSettingGroup(nil, nil, @[clear]);
    
    TLSettingItem *report = TLCreateSettingItem(@"举报");
    TLSettingGroup *group6 = TLCreateSettingGroup(nil, nil, @[report]);
    
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:@[group1, group2, group3, group4, group5, group6]];
    return self.data;
}

@end
