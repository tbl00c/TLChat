//
//  TLExpressionChosenViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController.h"
#import "TLExpressionChosenViewController+TableView.h"
#import "TLExpressionSearchViewController.h"
#import "TLSearchController.h"
#import "TLExpressionProxy.h"

@interface TLExpressionChosenViewController () <UISearchBarDelegate>

@property (nonatomic, strong) TLExpressionProxy *proxy;

@property (nonatomic, strong) TLSearchController *searchController;
@property (nonatomic, strong) TLExpressionSearchViewController *searchVC;

@end

@implementation TLExpressionChosenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    [self registerCellsForTableView:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    [self.proxy requestExpressionChosenListSuccess:^(id data) {
        NSLog(@"OK");
        weakSelf.data = data;
        [weakSelf.tableView reloadData];
    } failure:^(NSString *error) {
        NSLog(@"NO");
    }];
}

#pragma mark - #Delegate -
//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

#pragma mark - # Getter -
- (TLExpressionProxy *)proxy
{
    if (_proxy == nil) {
        _proxy = [[TLExpressionProxy alloc] init];
    }
    return _proxy;
}

- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[TLSearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController setSearchResultsUpdater:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索表情"];
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}

- (TLExpressionSearchViewController *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLExpressionSearchViewController alloc] init];
    }
    return _searchVC;
}

@end
