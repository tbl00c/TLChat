//
//  TLMobileContactsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMobileContactsViewController.h"
#import "TLMobileContactsSearchResultViewController.h"
#import "TLSearchController.h"
#import "TLMobileContactsAngel.h"
#import "TLMobileContactHelper.h"
#import "TLFriendEventStatistics.h"

@interface TLMobileContactsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TLMobileContactsAngel *tableViewAngel;

@property (nonatomic, strong) TLSearchController *searchController;
@property (nonatomic, strong) TLMobileContactsSearchResultViewController *searchResultVC;

@end

@implementation TLMobileContactsViewController

- (void)loadView
{
    [super loadView];
    
    [self p_loadUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self p_loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [TLUIUtility hiddenLoading];
}

#pragma mark - # Private Methods
- (void)p_loadUI
{
    [self setTitle:LOCSTR(@"通讯录朋友")];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.searchResultVC = [[TLMobileContactsSearchResultViewController alloc] init];
    self.searchController = [TLSearchController createWithResultsContrller:self.searchResultVC];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor whiteColor]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableHeaderView(self.searchController.searchBar).tableFooterView([UIView new])
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor colorBlackForNavBar]];
    
    self.tableViewAngel = [[TLMobileContactsAngel alloc] initWithHostView:self.tableView];
}

- (void)p_loadData
{
    [TLUIUtility showLoading:@"加载中"];
    @weakify(self);
    [TLMobileContactHelper tryToGetAllContactsSuccess:^(NSArray *data, NSArray *formatData, NSArray *headers) {
        @strongify(self);
        [TLUIUtility hiddenLoading];
        self.searchResultVC.contactsData = data;
        [self.tableViewAngel resetListWithMobileContactsData:formatData sectionHeaders:headers];
        [self.tableView reloadData];
        [MobClick event:EVENT_GET_CONTACTS];
    } failed:^{
        [TLUIUtility hiddenLoading];
        [TLUIUtility showAlertWithTitle:@"错误" message:@"未成功获取到通讯录信息"];
    }];
}

@end
