//
//  TLOfficialAccountViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLOfficialAccountViewController.h"
#import "TLOfficialAccountSearchResultViewController.h"
#import "TLSearchController.h"

@interface TLOfficialAccountViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLOfficialAccountViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"公众号")];

    [self addRightBarButtonWithImage:TLImage(@"nav_add") actionBlick:^{
        [TLUIUtility showInfoHint:@"暂未实现"];
    }];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor colorGrayBG])
    .tableHeaderView(self.searchController.searchBar)
    .tableFooterView([UIView new])
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;
    
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

#pragma mark - # Getters
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        TLOfficialAccountSearchResultViewController *searchResultVC = [[TLOfficialAccountSearchResultViewController alloc] init];
        _searchController = [TLSearchController createWithResultsContrller:searchResultVC];
    }
    return _searchController;
}

@end
