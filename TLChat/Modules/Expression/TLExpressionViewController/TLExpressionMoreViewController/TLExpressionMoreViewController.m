//
//  TLExpressionMoreViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLExpressionMoreViewController.h"
#import "TLExpressionDetailViewController.h"
#import "TLExpressionGroupModel+MoreRequest.h"

typedef NS_ENUM(NSInteger, TLExpressionMoreSectionType) {
    TLExpressionMoreSectionTypeSearch,
    TLExpressionMoreSectionTypeExprs,
};

@interface TLExpressionMoreViewController ()

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation TLExpressionMoreViewController

- (void)loadView
{
    [super loadView];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    @weakify(self);
    // 搜索
    self.addSection(TLExpressionMoreSectionTypeSearch);
    self.addCell(@"TLExpressionMoreSearchCell").toSection(TLExpressionMoreSectionTypeSearch).eventAction(^ id(NSInteger eventType, id data) {
        @strongify(self);
        [self didSelectedExpressionGroup:data];
        return nil;
    });
    
    // 表情
    self.addSection(TLExpressionMoreSectionTypeExprs).backgrounColor([UIColor whiteColor]).sectionInsets(UIEdgeInsetsMake(15, 15, 0, 15)).minimumInteritemSpacing(15);
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (!CGRectEqualToRect(self.collectionView.frame, self.view.bounds)) {
        [self.collectionView setFrame:self.view.bounds];
        self.updateCells.all();
        [self.collectionView reloadData];
    }
}

- (void)requestDataIfNeed
{
    if ([self dataModelArrayForSection:TLExpressionMoreSectionTypeExprs].count == 0) {
        [TLUIUtility showLoading:nil];
        [self requestExpressionMoreDataWithPageIndex:1];
    }
}

#pragma mark - # Event Action
- (void)didSelectedExpressionGroup:(TLExpressionGroupModel *)groupModel
{
    TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] initWithGroupModel:groupModel];
    PushVC(detailVC);
}

#pragma mark - # Request
- (void)requestExpressionMoreDataWithPageIndex:(NSInteger)pageIndex
{
    if (pageIndex == 1) {
        [self.collectionView tt_removeLoadMoreFooter];
    }
    self.pageIndex = pageIndex;
    [self removeTipView];
    @weakify(self);
    [TLExpressionGroupModel requestExpressionMoreListByPageIndex:pageIndex success:^(NSArray *successData) {
        @strongify(self);
        [TLUIUtility hiddenLoading];
        if (pageIndex == 1) {
            [self deleteAllItemsForSection:TLExpressionMoreSectionTypeExprs];
        }
        if (successData.count > 0) {
            if (pageIndex == 1) {
                [self.collectionView tt_addLoadMoreFooterWithAction:^{
                    @strongify(self);
                    [self requestExpressionMoreDataWithPageIndex:self.pageIndex + 1];
                }];
            }
            self.addCells(@"TLExpressionMoreCell").withDataModelArray(successData).toSection(TLExpressionMoreSectionTypeExprs).selectedAction(^ (id data) {
                @strongify(self);
                [self didSelectedExpressionGroup:data];
            });
            [self.collectionView tt_endLoadMore];
        }
        else {
            [self.collectionView tt_showNoMoreFooter];
        }
        [self reloadView];
    } failure:^(id failureData) {
        @strongify(self);
        [TLUIUtility hiddenLoading];
        [self.collectionView tt_endLoadMore];
        [self.view showErrorViewWithTitle:failureData retryAction:^(id userData) {
            @strongify(self);
            [self requestDataIfNeed];
        }];
    }];
}


@end
