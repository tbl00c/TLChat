//
//  TLCommonSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLCommonSettingViewController.h"
#import "TLMessageManager.h"

#import "TLChatViewController.h"
#import "TLChatFontViewController.h"
#import "TLChatBackgroundSettingViewController.h"
#import "TLMyExpressionViewController.h"

#import "TLChatNotificationKey.h"

@implementation TLCommonSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通用"];
    
    [self p_initCommonSettingData];
}

#pragma mark - # Delegate
//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"字体大小"]) {
        TLChatFontViewController *chatFontVC = [[TLChatFontViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatFontVC animated:YES];
    }
    else if ([item.title isEqualToString:@"聊天背景"]) {
        TLChatBackgroundSettingViewController *chatBGSettingVC = [[TLChatBackgroundSettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatBGSettingVC animated:YES];
    }
    else if ([item.title isEqualToString:@"我的表情"]) {
        TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myExpressionVC animated:YES];
    }
    else if ([item.title isEqualToString:@"清空聊天记录"]) {
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"将删除所有个人和群的聊天记录。" clickAction:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [[TLMessageManager sharedInstance] deleteAllMessages];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHAT_VIEW_RESET object:nil];
            }
        } cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空聊天记录" otherButtonTitles:nil];
        [actionSheet show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - # Private Methods
- (void)p_initCommonSettingData
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
    
    self.data = @[group1, group2, group3, group4, group5, group6].mutableCopy;
}

@end
