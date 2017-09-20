//
//  TLNewFriendViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNewFriendViewController+Delegate.h"
#import "TLContactsViewController.h"

@implementation TLNewFriendViewController (Delegate)

#pragma mark - Private Methods -
- (void)registerCellClass
{
    [self.tableView registerClass:[TLAddThirdPartFriendCell class] forCellReuseIdentifier:@"TLAddThirdPartFriendCell"];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLAddThirdPartFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLAddThirdPartFriendCell"];
        [cell setThridPartItems:@[TLThirdPartFriendTypeContacts]];
        [cell setDelegate:self];
        return cell;
    }
    return nil;
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 20.0f;
    }
    return 0.0f;
}

//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

//MARK: TLAddThirdPartFriendCellDelegate
- (void)addThirdPartFriendCellDidSelectedType:(NSString *)thirdPartFriendType
{
    if ([TLThirdPartFriendTypeContacts isEqualToString:thirdPartFriendType]) {
        TLContactsViewController *contactsVC = [[TLContactsViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:contactsVC animated:YES];
    }
    else if ([TLThirdPartFriendTypeQQ isEqualToString:thirdPartFriendType]) {
        
    }
    else if ([TLThirdPartFriendTypeGoogle isEqualToString:thirdPartFriendType]) {
        
    }
}

@end
