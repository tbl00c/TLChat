//
//  TLContactsViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsViewController+Delegate.h"
#import "TLFriendHeaderView.h"
#import "TLContactCell.h"

@implementation TLContactsViewController (Delegate)

- (void)registerCellClass
{
    [self.tableView registerClass:[TLFriendHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLFriendHeaderView"];
    [self.tableView registerClass:[TLContactCell class] forCellReuseIdentifier:@"TLContactCell"];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TLUserGroup *group = [self.data objectAtIndex:section];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLContact *contact = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    TLContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLContactCell"];
    [cell setContact:contact];
    if (indexPath.section == self.data.count - 1 && indexPath.row == [self.data[indexPath.section] count] - 1) {
        [cell setBottomLineStyle:TLCellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:(indexPath.row == [self.data[indexPath.section] count] - 1 ? TLCellLineStyleNone : TLCellLineStyleDefault)];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TLUserGroup *group = [self.data objectAtIndex:section];
    TLFriendHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLFriendHeaderView"];
    [view setTitle:group.groupName];
    return view;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.headers;
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0f;
}

//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchVC setContactsData:self.contactsData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
