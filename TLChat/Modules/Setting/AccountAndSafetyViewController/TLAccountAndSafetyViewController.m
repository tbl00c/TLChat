//
//  TLAccountAndSafetyViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAccountAndSafetyViewController.h"
#import "TLWebViewController.h"
#import "TLUserHelper.h"

@implementation TLAccountAndSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"账号与安全"];

    [self p_initAccountAndSafetyData];
}

#pragma mark - # Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"微信安全中心"]) {
        TLWebViewController *webVC = [[TLWebViewController alloc] init];
        [webVC setUrl:@"http://weixin110.qq.com/"];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - # Private Methods
- (void)p_initAccountAndSafetyData
{
    TLUser *userInfo = [TLUserHelper sharedHelper].user;
    
    TLSettingItem *username = TLCreateSettingItem(@"微信号");
    if (userInfo.username.length > 0) {
        username.subTitle = userInfo.username;
        username.showDisclosureIndicator = NO;
        username.disableHighlight = YES;
    }
    else {
        username.subTitle = @"未设置";
    }
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[username]);
    
    TLSettingItem *qqNumber = TLCreateSettingItem(@"QQ号");
    qqNumber.subTitle = (userInfo.detailInfo.qqNumber.length > 0 ? userInfo.detailInfo.qqNumber : @"未绑定");
    TLSettingItem *phoneNumber = TLCreateSettingItem(@"手机号");
    phoneNumber.subTitle = (phoneNumber.subTitle.length > 0 ?userInfo.detailInfo.phoneNumber : @"未绑定");
    TLSettingItem *email = TLCreateSettingItem(@"邮箱地址");
    email.subTitle = userInfo.detailInfo.email.length > 0 ? userInfo.detailInfo.email : @"未绑定";
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[qqNumber, phoneNumber, email]));
    
    TLSettingItem *voiceLock = TLCreateSettingItem(@"声音锁");
    TLSettingItem *password = TLCreateSettingItem(@"微信密码");
    TLSettingItem *idProtect = TLCreateSettingItem(@"账号保护");
    //    if () {
    idProtect.subTitle = @"已保护";
    idProtect.rightImagePath = @"setting_lockon";
    //    }
    //    else {
    //        idProtect.subTitle = @"未保护";
    //        idProtect.rightImagePath = @"setting_lockoff";
    //    }
    TLSettingItem *safetyCenter = TLCreateSettingItem(@"微信安全中心");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, @"如果遇到账号信息泄露、忘记密码、诈骗等账号问题，可前往微信安全中心。", (@[voiceLock, password, idProtect, safetyCenter]));
    
    self.data = @[group1, group2, group3].mutableCopy;

}

@end
