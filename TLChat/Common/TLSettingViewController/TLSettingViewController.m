//
//  TLSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingViewController.h"
#import "TLSettingHeaderTitleView.h"
#import "TLSettingFooterTitleView.h"
#import "TLSettingCell.h"
#import "TLSettingButtonCell.h"
#import "TLSettingSwitchCell.h"

@interface TLSettingViewController ()

@end

@implementation TLSettingViewController

- (void) loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 15.0f)]];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 12.0f)]];
    [self.tableView setBackgroundColor:[UIColor colorTableViewBG]];
    [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.tableView setSeparatorColor:[UIColor colorCellLine]];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[TLSettingHeaderTitleView class] forHeaderFooterViewReuseIdentifier:@"TLSettingHeaderTitleView"];
    [self.tableView registerClass:[TLSettingFooterTitleView class] forHeaderFooterViewReuseIdentifier:@"TLSettingFooterTitleView"];
    [self.tableView registerClass:[TLSettingCell class] forCellReuseIdentifier:@"TLSettingCell"];
    [self.tableView registerClass:[TLSettingButtonCell class] forCellReuseIdentifier:@"TLSettingButtonCell"];
    [self.tableView registerClass:[TLSettingSwitchCell class] forCellReuseIdentifier:@"TLSettingSwitchCell"];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data[section] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    id cell = [tableView dequeueReusableCellWithIdentifier:item.cellClassName];
    [cell setItem:item];
    return cell;
}

#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TLSettingGroup *group = self.data[section];
    if (group.headerTitle == nil) {
        return nil;
    }
    TLSettingHeaderTitleView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLSettingHeaderTitleView"];
    [view setText:group.headerTitle];
    return view;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TLSettingGroup *group = self.data[section];
    if (group.footerTitle == nil) {
        return nil;
    }
    TLSettingFooterTitleView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLSettingFooterTitleView"];
    [view setText:group.footerTitle];
    return view;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    TLSettingGroup *group = self.data[section];
    return 0.5 + (group.headerTitle == nil ? 0 : 5.0f + group.headerHeight);
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    TLSettingGroup *group = self.data[section];
    return 20.0f + (group.footerTitle == nil ? 0 : 5.0f + group.footerHeight);
}


@end
