//
//  TLChatDetailHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatDetailHelper.h"

@implementation TLChatDetailHelper


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
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray:@[group1, group2, group3, group4, group5, group6]];
    return data;
}

- (NSMutableArray *)chatDetailDataByGroupInfo:(TLGroup *)groupInfo
{
    TLSettingItem *users = TLCreateSettingItem(@"users");
    users.type = TLSettingItemTypeOther;
    TLSettingItem *allUsers = TLCreateSettingItem(([NSString stringWithFormat:@"全部群成员(%ld)", (long)groupInfo.count]));
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, (@[users, allUsers]));
    
    TLSettingItem *groupName = TLCreateSettingItem(@"群聊名称");
    groupName.subTitle = groupInfo.groupName;
    TLSettingItem *groupQR = TLCreateSettingItem(@"群二维码");
    groupQR.rightImagePath = @"mine_cell_myQR";
    TLSettingItem *groupPost = TLCreateSettingItem(@"群公告");
    if (groupInfo.post.length > 0) {
        groupPost.subTitle = groupInfo.post;
    }
    else {
        groupPost.subTitle = @"未设置";
    }
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[groupName, groupQR, groupPost]));
    
    TLSettingItem *screen = TLCreateSettingItem(@"消息免打扰");
    screen.type = TLSettingItemTypeSwitch;
    TLSettingItem *top = TLCreateSettingItem(@"置顶聊天");
    top.type = TLSettingItemTypeSwitch;
    TLSettingItem *save = TLCreateSettingItem(@"保存到通讯录");
    save.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, (@[screen, top, save]));
    
    TLSettingItem *myNikeName = TLCreateSettingItem(@"我在本群的昵称");
    myNikeName.subTitle = groupInfo.myNikeName;
    TLSettingItem *showOtherNikeName = TLCreateSettingItem(@"显示群成员昵称");
    showOtherNikeName.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group4 = TLCreateSettingGroup(nil, nil, (@[myNikeName, showOtherNikeName]));
    
    TLSettingItem *chatFile = TLCreateSettingItem(@"聊天文件");
    TLSettingItem *chatHistory = TLCreateSettingItem(@"查找聊天内容");
    TLSettingItem *chatBG = TLCreateSettingItem(@"设置当前聊天背景");
    TLSettingItem *report = TLCreateSettingItem(@"举报");
    TLSettingGroup *group5 = TLCreateSettingGroup(nil, nil, (@[chatFile, chatHistory, chatBG, report]));
    
    TLSettingItem *clear = TLCreateSettingItem(@"清空聊天记录");
    clear.showDisclosureIndicator = NO;
    TLSettingGroup *group6 = TLCreateSettingGroup(nil, nil, @[clear]);
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray:@[group1, group2, group3, group4, group5, group6]];
    return data;
}

@end
