//
//  UIScrollView+TLLoadMoreFooter.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UIScrollView+TLLoadMoreFooter.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (TLLoadMoreFooter)

- (void)tt_addLoadMoreFooterWithAction:(void (^)())loadMoreAction
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:loadMoreAction];
    [footer setTitle:LOCSTR(@"正在加载...") forState:MJRefreshStateRefreshing];
    [footer setTitle:LOCSTR(@"没有更多数据了") forState:MJRefreshStateNoMoreData];
    [self setMj_footer:footer];
}

- (void)tt_beginLoadMore
{
    [self.mj_footer beginRefreshing];
}

- (void)tt_endLoadMore
{
    [self.mj_footer endRefreshing];
}

- (void)tt_showNoMoreFooter
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)tt_showNoMoreFooterWithTitle:(NSString *)title
{
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.mj_footer;
    [footer setTitle:title forState:MJRefreshStateNoMoreData];
    [self tt_showNoMoreFooter];
}

- (void)tt_removeLoadMoreFooter
{
    [self setMj_footer:nil];
}

@end
