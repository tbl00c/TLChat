//
//  TLGroupViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupViewController+Delegate.h"
#import "TLChatViewController.h"
#import "TLRootViewController.h"
#import "TLGroup+ChatModel.h"
#import "TLGroupCell.h"

@implementation TLGroupViewController (Delegate)

#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.tableView registerClass:[TLGroupCell class] forCellReuseIdentifier:@"TLGroupCell"];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLGroup *group = self.data[indexPath.row];
    TLGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLGroupCell"];
    [cell setGroup:group];
    [cell setBottomLineStyle:(indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault)];
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLGroup *group = [self.data objectAtIndex:indexPath.row];
    TLChatViewController *chatVC = [TLChatViewController sharedChatVC];
    [chatVC setPartner:group];
    UIViewController *vc = [[TLRootViewController sharedRootViewController] childViewControllerAtIndex:0];
    [[TLRootViewController sharedRootViewController] setSelectedIndex:0];
    [vc setHidesBottomBarWhenPushed:YES];
    [vc.navigationController pushViewController:chatVC animated:YES completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
    [vc setHidesBottomBarWhenPushed:NO];
}

//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchVC setGroupData:self.data];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
