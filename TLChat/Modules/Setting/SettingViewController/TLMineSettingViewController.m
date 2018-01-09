//
//  TLMineSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineSettingViewController.h"
#import "TLAccountAndSafetyViewController.h"
#import "TLNewMessageSettingViewController.h"
#import "TLPrivacySettingViewController.h"
#import "TLCommonSettingViewController.h"
#import "TLHelpAndFeedbackViewController.h"
#import "TLAboutViewController.h"

@interface TLMineSettingViewController () <TLActionSheetDelegate>


@end

@implementation TLMineSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:LOCSTR(@"设置")];
    
    [self p_initMineSettingData];
}

#pragma mark - # delegate
//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"账号与安全"]) {
        TLAccountAndSafetyViewController *accountAndSafetyVC = [[TLAccountAndSafetyViewController alloc] init];
        PushVC(accountAndSafetyVC);
    }
    else if ([item.title isEqualToString:@"新消息通知"]) {
        TLNewMessageSettingViewController *newMessageSettingVC = [[TLNewMessageSettingViewController alloc] init];
        PushVC(newMessageSettingVC);
    }
    else if ([item.title isEqualToString:@"隐私"]) {
        TLPrivacySettingViewController *privacySettingVC = [[TLPrivacySettingViewController alloc] init];
        PushVC(privacySettingVC);
    }
    else if ([item.title isEqualToString:@"通用"]) {
        TLCommonSettingViewController *commonSettingVC = [[TLCommonSettingViewController alloc] init];
        PushVC(commonSettingVC);
    }
    else if ([item.title isEqualToString:@"帮助与反馈"]) {
        TLHelpAndFeedbackViewController *helpAndFeedbackVC = [[TLHelpAndFeedbackViewController alloc] init];
        PushVC(helpAndFeedbackVC);
    }
    else if ([item.title isEqualToString:@"关于微信"]) {
        TLAboutViewController *aboutVC = [[TLAboutViewController alloc] init];
        PushVC(aboutVC);
    }
    else if ([item.title isEqualToString:@"退出登录"]) {
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号。" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
        [actionSheet show];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

//MARK: TLActionSheetDelegate
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

}

#pragma mark - # Private Methods
- (void)p_initMineSettingData
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
    
    self.data = @[group1, group2, group3, group4].mutableCopy;
}

@end
