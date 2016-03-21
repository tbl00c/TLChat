//
//  TLConversationViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationViewController.h"
#import "TLConversationViewController+Delegate.h"
#import "TLSearchController.h"
#import <AFNetworking.h>

#import "TLMessageManager+ConversationRecord.h"

@interface TLConversationViewController ()

@property (nonatomic, strong) UIImageView *scrollTopView;

@property (nonatomic, strong) TLSearchController *searchController;

@property (nonatomic, strong) TLAddMenuView *addMenuView;

@end

@implementation TLConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"微信"];
    
    [self p_initUI];        // 初始化界面UI
    [self registerCellClass];
    
    [[TLMessageManager sharedInstance] setConversationDelegate:self];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //TODO: 临时写法
    [self updateConversationData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.addMenuView.isShow) {
        [self.addMenuView dismiss];
    }
}

#pragma mark - Event Response
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    if (self.addMenuView.isShow) {
        [self.addMenuView dismiss];
    }
    else {
        [self.addMenuView showInView:self.navigationController.view];
    }
}

// 网络情况改变
- (void)networkStatusChange:(NSNotification *)noti
{
    AFNetworkReachabilityStatus status = [noti.userInfo[@"AFNetworkingReachabilityNotificationStatusItem"] longValue];
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusUnknown:
            [self.navigationItem setTitle:@"微信"];
            break;
        case AFNetworkReachabilityStatusNotReachable:
            [self.navigationItem setTitle:@"微信(未连接)"];
            break;
        default:
            break;
    }
}

#pragma mark - Private Methods -
- (void)p_initUI
{
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self.tableView addSubview:self.scrollTopView];
    [self.scrollTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tableView);
        make.bottom.mas_equalTo(self.tableView.mas_top).mas_offset(-35);
    }];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

#pragma mark - Getter -
- (TLSearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[TLSearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController setSearchResultsUpdater:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setDelegate:self];
        [_searchController setShowVoiceButton:YES];
    }
    return _searchController;
}

- (TLFriendSearchViewController *) searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLFriendSearchViewController alloc] init];
    }
    return _searchVC;
}

- (UIImageView *)scrollTopView
{
    if (_scrollTopView == nil) {
        _scrollTopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conv_wechat_icon"]];
    }
    return _scrollTopView;
}

- (TLAddMenuView *)addMenuView
{
    if (_addMenuView == nil) {
        _addMenuView = [[TLAddMenuView alloc] init];
        [_addMenuView setDelegate:self];
    }
    return _addMenuView;
}

@end