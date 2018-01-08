//
//  TLMobileContactsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMobileContactsViewController.h"
#import "TLMobileContactsViewController+Delegate.h"
#import "TLSearchController.h"
#import "TLFriendHelper+Contacts.h"
#import "TLUserGroup.h"
#import "TLFriendEventStatistics.h"

@interface TLMobileContactsViewController () <UISearchBarDelegate>

@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLMobileContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通讯录朋友"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor colorBlackForNavBar]];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    [self registerCellClass];
    
    [TLUIUtility showLoading:@"加载中"];
    [TLFriendHelper tryToGetAllContactsSuccess:^(NSArray *data, NSArray *formatData, NSArray *headers) {
        [TLUIUtility hiddenLoading];
        self.data = formatData;
        self.contactsData = data;
        self.headers = headers;
        [self.tableView reloadData];
        
        [MobClick event:EVENT_GET_CONTACTS];
    } failed:^{
        [TLUIUtility hiddenLoading];
        [TLUIUtility showAlertWithTitle:@"错误" message:@"未成功获取到通讯录信息"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([TLUIUtility isShowLoading]) {
        [TLUIUtility hiddenLoading];
    }
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

- (TLMobileContactsSearchResultViewController *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLMobileContactsSearchResultViewController alloc] init];
    }
    return _searchVC;
}

@end
