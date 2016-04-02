//
//  TLInfoViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLInfoViewController.h"
#import "TLInfoHeaderFooterView.h"
#import <MobClick.h>

@implementation TLInfoViewController

- (void) loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_INFO_TOP_SPACE)]];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_INFO_BOTTOM_SPACE)]];
    [self.tableView setBackgroundColor:[UIColor colorTableViewBG]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 10.0f)]];
    [self.tableView registerClass:[TLInfoHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"TLInfoHeaderFooterView"];
    [self.tableView registerClass:[TLInfoCell class] forCellReuseIdentifier:@"TLInfoCell"];
    [self.tableView registerClass:[TLInfoButtonCell class] forCellReuseIdentifier:@"TLInfoButtonCell"];
}

- (void)dealloc
{
#ifdef DEBUG_MEMERY
    NSLog(@"dealloc %@", self.navigationItem.title);
#endif
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *group = self.data[indexPath.section];
    TLInfo *info = [group objectAtIndex:indexPath.row];
    id cell;
    if (info.type == TLInfoTypeButton) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TLInfoButtonCell"];
        [cell setDelegate:self];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TLInfoCell"];
    }
    [cell setInfo:info];
    
    if (indexPath.row == 0 && info.type != TLInfoTypeButton) {
        [cell setTopLineStyle:TLCellLineStyleFill];
    }
    else {
        [cell setTopLineStyle:TLCellLineStyleNone];
    }
    if (info.type == TLInfoTypeButton) {
        [cell setBottomLineStyle:TLCellLineStyleNone];
    }
    else if (indexPath.row == group.count - 1) {
        [cell setBottomLineStyle:TLCellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:TLCellLineStyleDefault];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLInfoHeaderFooterView"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLInfoHeaderFooterView"];
}

//MARK: TLTableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLInfo *info = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if (info.type == TLInfoTypeButton) {
        return 50.0f;
    }
    return HEIGHT_INFO_CELL;
}

//MARK: TLInfoButtonCellDelegate
- (void)infoButtonCellClicked:(TLInfo *)info
{
    [UIAlertView bk_alertViewWithTitle:@"子类未处理按钮点击事件" message:[NSString stringWithFormat:@"Title: %@", info.title]];
}

@end
