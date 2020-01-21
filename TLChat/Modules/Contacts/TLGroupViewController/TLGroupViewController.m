//
//  TLGroupViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupViewController.h"
#import "TLGroupSearchResultViewController.h"
#import "TLSearchController.h"
#import "TLFriendHelper.h"
#import "TLLaunchManager.h"
#import "TLChatViewController.h"
#import "TLGroup+ChatModel.h"

typedef NS_ENUM(NSInteger, TLGroupVCSectionType) {
    TLGroupVCSectionTypeItems,
};

@interface TLGroupViewController ()

/// 总群数
@property (nonatomic, strong) UILabel *footerLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLGroupViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"群聊")];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor colorGrayBG]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableFooterView(self.footerLabel)
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;;
    
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *data = [TLFriendHelper sharedFriendHelper].groupsData;
    [self loadListUIWithData:data];
}

#pragma mark - # UI
- (void)loadListUIWithData:(NSArray *)data
{
    @weakify(self);
    self.tableViewAngel.clear();
    if (data.count == 0) {
        [self.tableView setTableHeaderView:nil];
        [self.tableView showEmptyViewWithTitle:@"你可通过群聊中的“保存到通讯录”选项，将其保存在这里"];
    }
    else {
        [self.tableView setTableHeaderView:self.searchController.searchBar];
        [self.footerLabel setText:[NSString stringWithFormat:@"%ld%@", data.count, LOCSTR(@"个群聊")]];
        self.tableViewAngel.addSection(TLGroupVCSectionTypeItems);
        self.tableViewAngel.addCells(@"TLGroupItemCell").toSection(TLGroupVCSectionTypeItems).withDataModelArray(data).selectedAction(^ (TLGroup *group) {
            @strongify(self);
            [self.navigationController popToRootViewControllerAnimated:NO];
            TLChatViewController *chatVC = [[TLChatViewController alloc] initWithGroupId:group.groupID];
            UINavigationController *navC = [TLLaunchManager sharedInstance].tabBarController.childViewControllers[0];
            [[TLLaunchManager sharedInstance].tabBarController setSelectedIndex:0];
            [chatVC setHidesBottomBarWhenPushed:YES];
            [navC pushViewController:chatVC animated:YES];
        });
    }
    [self.tableView reloadData];
}

#pragma mark - # Getters
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        @weakify(self);
        TLGroupSearchResultViewController *searchResultVC = [[TLGroupSearchResultViewController alloc] initWithJumpAction:^(__kindof UIViewController *vc) {
            @strongify(self);
            [self.searchController setActive:NO];
            [self.navigationController popToRootViewControllerAnimated:NO];
            UINavigationController *navC = [TLLaunchManager sharedInstance].tabBarController.childViewControllers[0];
            [[TLLaunchManager sharedInstance].tabBarController setSelectedIndex:0];
            [vc setHidesBottomBarWhenPushed:YES];
            [navC pushViewController:vc animated:YES];
        }];
        _searchController = [TLSearchController createWithResultsContrller:searchResultVC];
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
