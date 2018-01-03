//
//  TLLaunchManager+UserData.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLLaunchManager+UserData.h"
#import "TLWalletViewController.h"
#import "TLExpressionGroupModel+Download.h"
#import "TLMineEventStatistics.h"

@implementation TLLaunchManager (UserData)

- (void)initUserData
{
    NSNumber *lastRunDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastRunDate"];
    
    if (lastRunDate == nil) {
        [TLUIUtility showAlertWithTitle:@"提示" message:@"首次启动App，是否随机下载两组个性表情包，稍候也可在“我的”-“表情”中选择下载。" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionHandler:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self downloadDefaultExpression];
            }
        }];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:lastRunDate.doubleValue];
    NSNumber *sponsorStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"sponsorStatus"];
    NSLog(@"今天第%ld次进入", (long)sponsorStatus.integerValue);
    if ([date isSameDay:[NSDate date]]) {
        if (sponsorStatus.integerValue == 3) {
            [TLUIUtility showAlertWithTitle:nil message:@"如果此份源码对您有足够大帮助，您可以小额赞助我，以激励我继续维护，做得更好。" cancelButtonTitle:@"不了" otherButtonTitles:@[@"小额赞助"] actionHandler:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    TLWalletViewController *walletVC = [[TLWalletViewController alloc] init];
                    [walletVC setHidesBottomBarWhenPushed:YES];
                    [self.tabBarController pushViewController:walletVC animated:YES];
                    [MobClick event:EVENT_DONATE_ALERT_YES];
                    [[NSUserDefaults standardUserDefaults] setObject:@(-1) forKey:@"sponsorStatus"];
                }
                else {
                    [MobClick event:EVENT_DONATE_ALERT_NO];
                    [[NSUserDefaults standardUserDefaults] setObject:@(-1) forKey:@"sponsorStatus"];
                }
            }];
        }
        [[NSUserDefaults standardUserDefaults] setObject:@(sponsorStatus.integerValue + 1) forKey:@"sponsorStatus"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:@([[NSDate date] timeIntervalSince1970]) forKey:@"lastRunDate"];
        if (sponsorStatus.integerValue != -1) {
            [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"sponsorStatus"];
        }
    }
}

/// 下载默认表情包
- (void)downloadDefaultExpression
{
    [TLUIUtility showLoading:nil];
    __block NSInteger count = 0;
    __block NSInteger successCount = 0;
    TLExpressionGroupModel *group = [[TLExpressionGroupModel alloc] init];
    group.gId = @"241";
    group.name = @"婉转的骂人";
    group.iconURL = [IEXPRESSION_HOST_URL stringByAppendingString:@"expre/downloadsuo.do?pId=10790"];
    group.groupInfo = @"婉转的骂人";
    group.detail = @"婉转的骂人表情，慎用";
    [group setDownloadCompleteAction:^(TLExpressionGroupModel *groupModel, BOOL success, id data) {
        count ++;
        if (success) {
            successCount ++;
        }
        if (count == 2) {
            [TLUIUtility showSuccessHint:[NSString stringWithFormat:@"成功下载%ld组表情！", (long)successCount]];
        }
    }];
    [group startDownload];

    TLExpressionGroupModel *group1 = [[TLExpressionGroupModel alloc] init];
    group1.gId = @"223";
    group1.name = @"王锡玄";
    group1.iconURL = [IEXPRESSION_HOST_URL stringByAppendingString:@"expre/downloadsuo.do?pId=10482"];
    group1.groupInfo = @"王锡玄 萌娃 冷笑宝宝";
    group1.detail = @"韩国萌娃，冷笑宝宝王锡玄表情包";
    [group1 setDownloadCompleteAction:^(TLExpressionGroupModel *groupModel, BOOL success, id data) {
        count ++;
        if (success) {
            successCount ++;
        }
        if (count == 2) {
            [TLUIUtility showSuccessHint:[NSString stringWithFormat:@"成功下载%ld组表情！", (long)successCount]];
        }
    }];
    [group1 startDownload];
}


@end
