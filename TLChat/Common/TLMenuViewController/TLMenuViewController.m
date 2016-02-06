//
//  TLMenuViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMenuViewController.h"

@interface TLMenuViewController ()

@end

@implementation TLMenuViewController

- (void) loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setBackgroundColor:[UIColor colorTableViewBG]];
    [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[TLMenuCell class] forCellReuseIdentifier:@"TLMenuCell"];
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
    TLMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMenuCell"];
    TLMenuItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    [cell setMenuItem:item];
    return cell;
}

#pragma mark UITableViewDelegate
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
    return 15.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

@end
