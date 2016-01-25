//
//  TLFriendsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendsViewController.h"

#import "TLFriendSearchViewController.h"

@interface TLFriendsViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) TLFriendSearchViewController *searchVC;

@end

@implementation TLFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通讯录"];
    
    [self.tableView setTableHeaderView:self.searchController.searchBar];
}

#pragma mark - Delegate
#pragma mark UISearchBarDelegate
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - Getter
- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setBarTintColor:[TLColorUtility colorSearchBarTint]];
        [_searchController.searchBar setDelegate:self];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[TLColorUtility colorSearchBarBorder].CGColor];
    }
    return _searchController;
}

- (TLFriendSearchViewController *) searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLFriendSearchViewController alloc] init];
    }
    return _searchVC;
}

@end
