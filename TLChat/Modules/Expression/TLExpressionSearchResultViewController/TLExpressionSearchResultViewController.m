//
//  TLExpressionSearchResultViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionSearchResultViewController.h"
#import "TLExpressionDetailViewController.h"
#import "TLExpressionGroupModel+SearchRequest.h"

#define         HEGIHT_EXPCELL      80

typedef NS_ENUM(NSInteger, TLExpressionSearchVCSectionType) {
    TLExpressionSearchVCSectionTypeItems,
};

@interface TLExpressionSearchResultViewController ()

/// 列表
@property (nonatomic, strong) UITableView *tableView;
/// 列表管理器
@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@end

@implementation TLExpressionSearchResultViewController

- (void)loadView
{
    [super loadView];
    [self setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.tableView = self.view.addTableView(1)
    .tableHeaderView([UIView new])
    .separatorStyle(UITableViewCellSeparatorStyleNone)
    .estimatedRowHeight(0).estimatedSectionFooterHeight(0).estimatedSectionHeaderHeight(0)
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;

    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

#pragma mark - # Request
- (void)requsetSearchExpressionGroupWithKeyword:(NSString *)keyword
{
    [TLUIUtility showLoading:nil];
    @weakify(self);
    [TLExpressionGroupModel requestExpressionSearchByKeyword:keyword success:^(NSArray *data) {
        [TLUIUtility hiddenLoading];
        if (data.count > 0) {
            [self p_reloadViewWithData:data];
        }
        else {
            [self p_reloadViewWithData:nil];
            [self.tableView showEmptyViewWithTitle:@"未搜索到相关表情包"];
        }
    } failure:^(NSString *error) {
        [TLUIUtility showErrorHint:error];
        [self p_reloadViewWithData:nil];
        [self.tableView showErrorViewWithTitle:error retryAction:^(id userData) {
            @strongify(self);
            [self requsetSearchExpressionGroupWithKeyword:keyword];
        }];
    }];
}

#pragma mark - # Delegate
//MARK: UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView removeTipView];
    NSString *keyword = searchBar.text;
    if (keyword.length > 0) {
        [self requsetSearchExpressionGroupWithKeyword:keyword];
    }
}

//MARK: UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController;
{
    [self p_clearView];
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *keyword = searchController.searchBar.text;
    if (keyword.length == 0) {
        [self p_clearView];
    }
}

#pragma mark - # Private Methods
- (void)p_clearView
{
    [self.tableView removeTipView];
    self.tableViewAngel.clear();
    self.tableViewAngel.addSection(TLExpressionSearchVCSectionTypeItems);
    [self.tableView reloadData];
}

- (void)p_reloadViewWithData:(NSArray *)data
{
    @weakify(self);
    self.tableViewAngel.sectionForTag(TLExpressionSearchVCSectionTypeItems).clear();
    self.tableViewAngel.addCells(@"TLExpressionItemCell").toSection(TLExpressionSearchVCSectionTypeItems).withDataModelArray(data).selectedAction(^ (TLExpressionGroupModel *model) {
        @strongify(self);
        if (self.itemClickAction) {
            self.itemClickAction(self, model);
        }
    });
    [self.tableView reloadData];
}

@end
