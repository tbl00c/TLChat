//
//  TLExpressionMoreViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLExpressionMoreViewController.h"
#import "TLExpressionDetailViewController.h"
#import "TLExpressionMoreCell.h"
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
    [self.collectionView setFrame:CGRectMake(0, STATUSBAR_HEIGHT + NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVBAR_HEIGHT)];
    
    // 搜索
    self.addSection(TLExpressionMoreSectionTypeSearch);
    self.addCell(@"TLExpressionMoreSearchCell").toSection(TLExpressionMoreSectionTypeSearch);
    
    // 表情
    NSInteger col = SCREEN_WIDTH / (WIDTH_EXPRESSION_MORE_CELL + 10);
    CGFloat edge = (SCREEN_WIDTH - col * WIDTH_EXPRESSION_MORE_CELL) / (col + 1);
    self.addSection(TLExpressionMoreSectionTypeExprs).backgrounColor([UIColor whiteColor]).sectionInsets(UIEdgeInsetsMake(15, edge, 0, edge));
}

- (void)requestDataIfNeed
{
    if ([self dataModelArrayForSection:TLExpressionMoreSectionTypeExprs].count == 0) {
        [TLUIUtility showLoading:nil];
        [self requestExpressionMoreDataWithPageIndex:1];
    }
}

- (void)requestRetry:(UIButton *)sender
{
    [super requestRetry:sender];
    [self requestDataIfNeed];
}

#pragma mark - # Event Action
- (void)didSelectedExpressionGroup:(TLExpressionGroupModel *)groupModel
{
    TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] init];
    [detailVC setGroup:groupModel];
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
            [self.collectionView tt_endLoadMoreWithNoMoreData];
        }
        [self reloadView];
    } failure:^(id failureData) {
        @strongify(self);
        [TLUIUtility hiddenLoading];
        [self.collectionView tt_endLoadMore];
        [self showErrorViewWithTitle:failureData];
    }];
}


@end
