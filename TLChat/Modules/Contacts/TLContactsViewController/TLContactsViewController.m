//
//  TLContactsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsViewController.h"
#import "TLContactsAngel.h"
#import "TLFriendHelper.h"

#import "TLSearchController.h"
#import "TLContactsSearchResultViewController.h"
#import "TLUserDetailViewController.h"
#import "TLAddContactsViewController.h"

@interface TLContactsViewController ()

/// 列表
@property (nonatomic, strong) UITableView *tableView;

/// 列表数据及控制中心
@property (nonatomic, strong) TLContactsAngel *listAngel;

/// 总好友数
@property (nonatomic, strong) UILabel *footerLabel;

/// 搜索
@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLContactsViewController

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"通讯录"), @"tabbar_contacts", @"tabbar_contactsHL");
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    // 初始化界面视图控件
    [self p_loadUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 开始监听通讯录数据
    [self p_startMonitorContactsData];
}

#pragma mark - # Pirvate Methods
- (void)p_loadUI
{
    [self.navigationItem setTitle:LOCSTR(@"通讯录")];
    
    @weakify(self);
    [self addRightBarButtonWithImage:TLImage(@"nav_add_friend") actionBlick:^{
        @strongify(self);
        TLAddContactsViewController *addFriendVC = [[TLAddContactsViewController alloc] init];
        PushVC(addFriendVC);
    }];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor colorGrayBG]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableHeaderView(self.searchController.searchBar).tableFooterView(self.footerLabel)
    .estimatedRowHeight(0).estimatedSectionFooterHeight(0).estimatedSectionHeaderHeight(0)
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor colorBlackForNavBar]];
    
    self.listAngel = [[TLContactsAngel alloc] initWithHostView:self.tableView pushAction:^(__kindof UIViewController *vc) {
        @strongify(self);
        PushVC(vc);
    }];
}

- (void)p_startMonitorContactsData
{
    [self.listAngel resetListWithContactsData:[TLFriendHelper sharedFriendHelper].data sectionHeaders:[TLFriendHelper sharedFriendHelper].sectionHeaders];
    [self.footerLabel setText:[NSString stringWithFormat:@"%ld%@", (long)[TLFriendHelper sharedFriendHelper].friendCount, LOCSTR(@"位联系人")]];
    [self.tableView reloadData];
    
    @weakify(self);
    [[TLFriendHelper sharedFriendHelper] setDataChangedBlock:^(NSMutableArray *data, NSMutableArray *headers, NSInteger friendCount) {
        @strongify(self);
        [self.listAngel resetListWithContactsData:[TLFriendHelper sharedFriendHelper].data sectionHeaders:[TLFriendHelper sharedFriendHelper].sectionHeaders];
        [self.footerLabel setText:[NSString stringWithFormat:@"%ld%@", (long)friendCount, LOCSTR(@"位联系人")]];
        [self.tableView reloadData];
    }];
}

#pragma mark - # Getters
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        TLContactsSearchResultViewController *searchVC = [[TLContactsSearchResultViewController alloc] init];
        @weakify(self);
        [searchVC setItemSelectedAction:^(TLContactsSearchResultViewController *searchVC, TLUser *userModel) {
            @strongify(self);
            [self.searchController setActive:NO];
            TLUserDetailViewController *detailVC = [[TLUserDetailViewController alloc] initWithUserModel:userModel];
            PushVC(detailVC);
        }];
        _searchController = [TLSearchController createWithResultsContrller:searchVC];
        [_searchController setEnableVoiceInput:YES];
    }
    return _searchController;
}

- (UILabel *)footerLabel
{
    if (_footerLabel == nil) {
        _footerLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0f)];
        [_footerLabel setTextAlignment:NSTextAlignmentCenter];
        [_footerLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_footerLabel setTextColor:[UIColor grayColor]];
    }
    return _footerLabel;
}

@end
