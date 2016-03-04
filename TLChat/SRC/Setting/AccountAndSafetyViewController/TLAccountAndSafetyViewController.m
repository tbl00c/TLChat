//
//  TLAccountAndSafetyViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAccountAndSafetyViewController.h"
#import "TLAccountAndSafetyHelper.h"
#import "TLWebViewController.h"

@interface TLAccountAndSafetyViewController ()

@property (nonatomic, strong) TLAccountAndSafetyHelper *helper;

@end

@implementation TLAccountAndSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"账号与安全"];

    self.helper = [[TLAccountAndSafetyHelper alloc] init];
    self.data = [self.helper mineAccountAndSafetyDataByUserInfo:[TLUserHelper sharedHelper].user];
}

#pragma mark - Delegate -
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

@end
