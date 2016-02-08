//
//  TLMineViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineViewController.h"
#import "TLMineHeaderCell.h"
#import "TLMineHelper.h"
#import "TLUserHelper.h"

#import "TLMineSettingViewController.h"

@interface TLMineViewController ()

@property (nonatomic, strong) TLMineHelper *mineHelper;

@end

@implementation TLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我"];
    
    self.mineHelper = [[TLMineHelper alloc] init];
    self.data = self.mineHelper.mineMenuData;
    
    [self.tableView registerClass:[TLMineHeaderCell class] forCellReuseIdentifier:@"TLMineHeaderCell"];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 + [super numberOfSectionsInTableView:tableView];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : [super tableView:tableView numberOfRowsInSection:section - 1];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLMineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMineHeaderCell"];
        [cell setUser:[TLUserHelper sharedHelper].user];
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
}

#pragma mark UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    return [super tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return;
    }
    TLMenuItem *item = [self.data[indexPath.section - 1] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"设置"]) {
        TLMineSettingViewController *settingVC = [[TLMineSettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:settingVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
        return;
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
