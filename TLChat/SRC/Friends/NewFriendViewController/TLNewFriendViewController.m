//
//  TLNewFriendViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNewFriendViewController.h"
#import "TLNewFriendSearchViewController.h"
#import "TLSearchController.h"
#import "TLAddThirdPartFriendCell.h"
#import "TLContactsViewController.h"
#import "TLAddFriendViewController.h"

@interface TLNewFriendViewController () <UISearchBarDelegate, TLAddThirdPartFriendCellDelegate>

@property (nonatomic, strong) TLSearchController *searchController;

@property (nonatomic, strong) TLNewFriendSearchViewController *searchVC;

@end

@implementation TLNewFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"新的朋友"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"添加朋友" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self.tableView registerClass:[TLAddThirdPartFriendCell class] forCellReuseIdentifier:@"TLAddThirdPartFriendCell"];
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    TLAddFriendViewController *addFriendVC = [[TLAddFriendViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addFriendVC animated:YES];
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
        [cell setThridPartItems:@[TLThirdPartFriendTypeContacts, TLThirdPartFriendTypeQQ]];
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

#pragma mark - Getter -
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[TLSearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController setSearchResultsUpdater:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"微信号/手机号"];
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}

- (TLNewFriendSearchViewController *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLNewFriendSearchViewController alloc] init];
    }
    return _searchVC;
}

@end
