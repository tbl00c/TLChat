//
//  TLPublicServerViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLPublicServerViewController.h"
#import "TLPublicServerSearchViewController.h"
#import "TLSearchController.h"

@interface TLPublicServerViewController () <UISearchBarDelegate>

@property (nonatomic, strong) TLSearchController *searchController;

@property (nonatomic, strong) TLPublicServerSearchViewController *searchVC;

@end

@implementation TLPublicServerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"公众号"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
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

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

#pragma mark - Getter -
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[TLSearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController setSearchResultsUpdater:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}

- (TLPublicServerSearchViewController *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLPublicServerSearchViewController alloc] init];
    }
    return _searchVC;
}


@end
