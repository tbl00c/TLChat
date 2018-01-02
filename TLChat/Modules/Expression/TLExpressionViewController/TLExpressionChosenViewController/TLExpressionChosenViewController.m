//
//  TLExpressionChosenViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController.h"
#import "TLExpressionChosenViewController+TableView.h"
#import "TLExpressionChosenViewController+Proxy.h"
#import "TLExpressionSearchViewController.h"
#import "TLSearchController.h"
#import <MJRefresh.h>
#import "TLExpressionHelper.h"

typedef NS_ENUM(NSInteger, TLExpressionChosenSectionType) {
    TLExpressionChosenSectionTypeBanner,
    TLExpressionChosenSectionTypeRec,
    TLExpressionChosenSectionTypeChosen,
};

@interface TLExpressionChosenViewController () <UISearchBarDelegate>

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLExpressionChosenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.tableView = self.view.addTableView(1)
    .frame(self.view.bounds)
    .backgroundColor([UIColor whiteColor])
    .tableHeaderView(self.searchController.searchBar)
    .tableFooterView([UIView new])
    .delegate(self).dataSource(self)
    .view;
    
//    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    [self.tableView setMj_footer:footer];
    
    [self registerCellsForTableView:self.tableView];
    [self loadDataWithLoadingView:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [TLUIUtility hiddenLoading];
}

#pragma mark - # Getter
- (TLSearchController *)searchController
{
    if (!_searchController) {
        _searchController = [TLSearchController createWithResultsContrllerClassName:NSStringFromClass([TLExpressionSearchViewController class])];
        [_searchController.searchBar setPlaceholder:LOCSTR(@"搜索表情")];
    }
    return _searchController;
}


@end
