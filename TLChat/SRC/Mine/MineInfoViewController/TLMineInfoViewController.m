//
//  TLMineInfoViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineInfoViewController.h"
#import "TLMineInfoHelper.h"

#import "TLMineInfoAvatarCell.h"

@interface TLMineInfoViewController ()

@property (nonatomic, strong) TLMineInfoHelper *helper;

@end

@implementation TLMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"个人信息"];
    
    [self.tableView registerClass:[TLMineInfoAvatarCell class] forCellReuseIdentifier:@"TLMineInfoAvatarCell"];
    
    self.helper = [[TLMineInfoHelper alloc] init];
    self.data = self.helper.mineInfoData;
}

#pragma mark - Delegate
#pragma mark UITableViewDataSource
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"头像"]) {
        TLMineInfoAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMineInfoAvatarCell"];
        [cell setItem:item];
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"头像"]) {
        return 85.0f;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
