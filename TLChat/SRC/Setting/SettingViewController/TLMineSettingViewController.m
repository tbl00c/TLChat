//
//  TLMineSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineSettingViewController.h"
#import "TLSettingHelper.h"

#import "TLAccountAndSafetyViewController.h"
#import "TLNewMessageSettingViewController.h"
#import "TLPrivacySettingViewController.h"
#import "TLCommonSettingViewController.h"
#import "TLHelpAndFeedbackViewController.h"
#import "TLAboutViewController.h"

@interface TLMineSettingViewController ()

@property (nonatomic, strong) TLSettingHelper *helper;

@end

@implementation TLMineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"设置"];
    
    self.helper = [[TLSettingHelper alloc] init];
    self.data = self.helper.mineSettingData;
}

#pragma mark - delegate -
//MARK: UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"账号与安全"]) {
        TLAccountAndSafetyViewController *accountAndSafetyVC = [[TLAccountAndSafetyViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:accountAndSafetyVC animated:YES];
    }
    else if ([item.title isEqualToString:@"新消息通知"]) {
        TLNewMessageSettingViewController *newMessageSettingVC = [[TLNewMessageSettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:newMessageSettingVC animated:YES];
    }
    else if ([item.title isEqualToString:@"隐私"]) {
        TLPrivacySettingViewController *privacySettingVC = [[TLPrivacySettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:privacySettingVC animated:YES];
    }
    else if ([item.title isEqualToString:@"通用"]) {
        TLCommonSettingViewController *commonSettingVC = [[TLCommonSettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:commonSettingVC animated:YES];
    }
    else if ([item.title isEqualToString:@"帮助与反馈"]) {
        TLHelpAndFeedbackViewController *helpAndFeedbackVC = [[TLHelpAndFeedbackViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:helpAndFeedbackVC animated:YES];
    }
    else if ([item.title isEqualToString:@"关于微信"]) {
        TLAboutViewController *aboutVC = [[TLAboutViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
