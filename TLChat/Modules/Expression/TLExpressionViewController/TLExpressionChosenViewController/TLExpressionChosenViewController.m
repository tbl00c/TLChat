//
//  TLExpressionChosenViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController.h"
#import "TLExpressionSearchResultViewController.h"
#import "TLSearchController.h"
#import "TLExpressionGroupModel+ChosenRequest.h"
#import "TLExpressionHelper.h"
#import "TLExpressionChosenAngel.h"
#import "TLExpressionDetailViewController.h"

typedef NS_ENUM(NSInteger, TLExpressionChosenSectionType) {
    TLExpressionChosenSectionTypeBanner,
    TLExpressionChosenSectionTypeRec,
    TLExpressionChosenSectionTypeChosen,
};

@interface TLExpressionChosenViewController () <UISearchBarDelegate>

@property (nonatomic, assign) NSInteger pageIndex;

/// 列表
@property (nonatomic, strong) UITableView *tableView;
/// 列表管理器
@property (nonatomic, strong) TLExpressionChosenAngel *tableViewAngel;
/// 请求队列
@property (nonatomic, strong) ZZFLEXRequestQueue *requestQueue;
/// 搜索
@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLExpressionChosenViewController

- (void)loadView
{
    [super loadView];
    
    [self p_loadUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 更新表情状态
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [TLUIUtility hiddenLoading];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (!CGRectEqualToRect(self.view.bounds, self.tableView.frame)) {
        [self.tableView setFrame:self.view.bounds];
        self.tableViewAngel.updateCells.all();
        [self.tableView reloadData];
    }
}

#pragma mark - # Requests
- (void)requestDataIfNeed
{
    if (self.tableViewAngel.sectionForTag(TLExpressionChosenSectionTypeChosen).dataModelArray.count > 0) {
        return;
    }
    if (self.requestQueue.isRuning) {
        return;
    }
    self.requestQueue = [[ZZFLEXRequestQueue alloc] init];
    [self.requestQueue addRequestModel:self.bannerRequestModel];
    [self.requestQueue addRequestModel:self.recommentRequestModel];
    [self.requestQueue addRequestModel:[self listRequestModelWithPageIndex:1]];
    [TLUIUtility showLoading:nil];
    [self.requestQueue runAllRequestsWithCompleteAction:^(NSArray *data, NSInteger successCount, NSInteger failureCount) {
        [TLUIUtility hiddenLoading];
    }];
}

#pragma mark - # Event Action
- (void)didSelectedExpressionGroup:(TLExpressionGroupModel *)groupModel
{
    TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] initWithGroupModel:groupModel];
    PushVC(detailVC);
}

#pragma mark - # Private Methods
- (void)p_loadUI
{
    /// 初始化列表
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.zz_make.backgroundColor([UIColor whiteColor])
    .separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableHeaderView(self.searchController.searchBar)
    .tableFooterView([UIView new])
    .estimatedRowHeight(0).estimatedSectionFooterHeight(0).estimatedSectionHeaderHeight(0);
    [self.view addSubview:self.tableView];
    
    /// 初始化列表管理器
    self.tableViewAngel = [[TLExpressionChosenAngel alloc] initWithHostView:self.tableView];
    
    /// 初始化基本模块
    self.tableViewAngel.addSection(TLExpressionChosenSectionTypeBanner);
    self.tableViewAngel.addSection(TLExpressionChosenSectionTypeRec);
    self.tableViewAngel.addSection(TLExpressionChosenSectionTypeChosen);
}

#pragma mark - # Getter
- (TLSearchController *)searchController
{
    if (!_searchController) {
        @weakify(self);
        TLExpressionSearchResultViewController *searchResultVC = [[TLExpressionSearchResultViewController alloc] init];
        [searchResultVC setItemClickAction:^(TLExpressionSearchResultViewController *searchController, id data) {
            @strongify(self);
            [self.searchController setActive:NO];
            [self didSelectedExpressionGroup:data];
        }];
        _searchController = [TLSearchController createWithResultsContrller:searchResultVC];
        [_searchController.searchBar setPlaceholder:LOCSTR(@"搜索表情")];
    }
    return _searchController;
}

- (ZZFLEXRequestModel *)bannerRequestModel
{
    @weakify(self);
    ZZFLEXRequestModel *requestModel = [ZZFLEXRequestModel requestModelWithTag:TLExpressionChosenSectionTypeBanner requestAction:^(ZZFLEXRequestModel *requestModel) {
        [TLExpressionGroupModel requestExpressionChosenBannerSuccess:^(id successData) {
            [requestModel executeRequestCompleteMethodWithSuccess:YES data:successData];
        } failure:^(id failureData) {
            [requestModel executeRequestCompleteMethodWithSuccess:NO data:failureData];
        }];
    } requestCompleteAction:^(ZZFLEXRequestModel *requestModel) {
        @strongify(self);
        if (!self) return;
        self.tableViewAngel.sectionForTag(TLExpressionChosenSectionTypeBanner).clear();
        if (requestModel.success) {
            self.tableViewAngel.addCell(@"TLExpressionBannerCell").toSection(requestModel.tag).withDataModel(requestModel.data).eventAction(^id (NSInteger eventType, id data) {
                @strongify(self);
                [self didSelectedExpressionGroup:data];
                return nil;
            });
        }
        else {
            [TLUIUtility showErrorHint:requestModel.data];
        }
        [self.tableView reloadData];
    }];
    return requestModel;
}

- (ZZFLEXRequestModel *)recommentRequestModel
{
    @weakify(self);
    ZZFLEXRequestModel *requestModel = [ZZFLEXRequestModel requestModelWithTag:TLExpressionChosenSectionTypeRec requestAction:^(ZZFLEXRequestModel *requestModel) {
        [TLExpressionGroupModel requestExpressionRecommentListSuccess:^(id successData) {
            [requestModel executeRequestCompleteMethodWithSuccess:YES data:successData];
        } failure:^(id failureData) {
            [requestModel executeRequestCompleteMethodWithSuccess:NO data:failureData];
        }];
    } requestCompleteAction:^(ZZFLEXRequestModel *requestModel) {
        @strongify(self);
        if (!self) return;
        self.tableViewAngel.sectionForTag(requestModel.tag).clear();
        if (requestModel.success) {
            self.tableViewAngel.setHeader(@"TLExpressionTitleView").withDataModel(LOCSTR(@"推荐表情")).toSection(requestModel.tag);
            [[TLExpressionHelper sharedHelper] updateExpressionGroupModelsStatus:requestModel.data];
            self.tableViewAngel.addCells(@"TLExpressionItemCell").withDataModelArray(requestModel.data).toSection(requestModel.tag).selectedAction(^ (id data) {
                @strongify(self);
                [self didSelectedExpressionGroup:data];
            });
        }
        [self.tableView reloadData];
    }];
    return requestModel;
}

- (ZZFLEXRequestModel *)listRequestModelWithPageIndex:(NSInteger)pageIndex
{
    self.pageIndex = pageIndex;
    @weakify(self);
    ZZFLEXRequestModel *requestModel = [ZZFLEXRequestModel requestModelWithTag:TLExpressionChosenSectionTypeChosen requestAction:^(ZZFLEXRequestModel *requestModel) {
        @strongify(self);
        if (!self) return;
        [TLExpressionGroupModel requestExpressionChosenListByPageIndex:pageIndex success:^(id successData) {
            [requestModel executeRequestCompleteMethodWithSuccess:YES data:successData];
        } failure:^(id failureData) {
            [requestModel executeRequestCompleteMethodWithSuccess:NO data:failureData];
        }];
    } requestCompleteAction:^(ZZFLEXRequestModel *requestModel) {
        @strongify(self);
        if (!self) return;
        if (pageIndex == 1) {
            
        }
        if (requestModel.success) {
            if (pageIndex == 1) {
                self.tableViewAngel.sectionForTag(requestModel.tag).clear();
                if ([requestModel.data count] > 0) {
                    self.tableViewAngel.setHeader(@"TLExpressionTitleView").withDataModel(LOCSTR(@"更多精选")).toSection(requestModel.tag);
                }
                
                [self.tableView tt_addLoadMoreFooterWithAction:^{
                    @strongify(self);
                    [[self listRequestModelWithPageIndex:self.pageIndex + 1] executeRequestMethod];
                }];
            }
            
            if ([requestModel.data count] > 0) {
                [[TLExpressionHelper sharedHelper] updateExpressionGroupModelsStatus:requestModel.data];
                self.tableViewAngel.addCells(@"TLExpressionItemCell").withDataModelArray(requestModel.data).toSection(requestModel.tag).selectedAction(^ (id data) {
                    @strongify(self);
                    [self didSelectedExpressionGroup:data];
                });
                [self.tableView tt_endLoadMore];
            }
            else {
                [self.tableView tt_showNoMoreFooter];
            }
        }
        else {
            if (pageIndex == 1) {
                [self.view showErrorViewWithTitle:requestModel.data retryAction:^(id userData) {
                    @weakify(self);
                    [self requestDataIfNeed];
                }];
            }
            else {
                [self.tableView tt_showNoMoreFooter];
            }
        }
        [self.tableView reloadData];
    }];
    return requestModel;
}

@end
