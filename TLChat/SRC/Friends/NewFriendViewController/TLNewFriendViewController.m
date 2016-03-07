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

@interface TLNewFriendViewController () <UISearchBarDelegate>

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
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    
}

#pragma mark - Delegate -
//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
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
