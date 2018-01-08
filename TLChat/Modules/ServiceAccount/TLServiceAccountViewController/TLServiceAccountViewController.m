//
//  TLServiceAccountViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLServiceAccountViewController.h"
#import "TLServiceAccountSearchResultViewController.h"
#import "TLSearchController.h"

@interface TLServiceAccountViewController () <UISearchBarDelegate>

@property (nonatomic, strong) TLSearchController *searchController;

@property (nonatomic, strong) TLServiceAccountSearchResultViewController *searchVC;

@end

@implementation TLServiceAccountViewController

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
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}

- (TLServiceAccountSearchResultViewController *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLServiceAccountSearchResultViewController alloc] init];
    }
    return _searchVC;
}


@end
