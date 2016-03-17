//
//  TLGroupViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupViewController.h"
#import "TLGroupViewController+Delegate.h"
#import "TLSearchController.h"

@interface TLGroupViewController () <UISearchBarDelegate>

@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"群聊"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    [self registerCellClass];
    
    self.data = [TLFriendHelper sharedFriendHelper].groupsData;
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

- (TLGroupSearchViewController *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLGroupSearchViewController alloc] init];
    }
    return _searchVC;
}

@end
