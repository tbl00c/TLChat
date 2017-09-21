//
//  TLExpressionChosenViewController+Proxy.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController+Proxy.h"
#import "TLExpressionProxy.h"
#import <MJRefresh.h>

@implementation TLExpressionChosenViewController (Proxy)

- (void)loadDataWithLoadingView:(BOOL)showLoadingView
{
    if (showLoadingView) {
        [TLUIUtility showLoading:nil];
    }
    kPageIndex = 1;
    TLExpressionProxy *proxy = [[TLExpressionProxy alloc] init];
    [proxy requestExpressionChosenListByPageIndex:kPageIndex success:^(id data) {
        [TLUIUtility hiddenLoading];
        kPageIndex ++;
        self.data = [[NSMutableArray alloc] init];
        for (TLEmojiGroup *group in data) {     // 优先使用本地表情
            TLEmojiGroup *localEmojiGroup = [[TLExpressionHelper sharedHelper] emojiGroupByID:group.groupID];
            if (localEmojiGroup) {
                [self.data addObject:localEmojiGroup];
            }
            else {
                [self.data addObject:group];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSString *error) {
        [TLUIUtility hiddenLoading];
    }];
    
    [proxy requestExpressionChosenBannerSuccess:^(id data) {
        self.bannerData = data;
        [self.tableView reloadData];
    } failure:^(NSString *error) {
        
    }];
}

- (void)loadMoreData
{
    TLExpressionProxy *proxy = [[TLExpressionProxy alloc] init];
    [proxy requestExpressionChosenListByPageIndex:kPageIndex success:^(NSMutableArray *data) {
        [TLUIUtility hiddenLoading];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            [self.tableView.mj_footer endRefreshing];
            kPageIndex ++;
            for (TLEmojiGroup *group in data) {     // 优先使用本地表情
                TLEmojiGroup *localEmojiGroup = [[TLExpressionHelper sharedHelper] emojiGroupByID:group.groupID];
                if (localEmojiGroup) {
                    [self.data addObject:localEmojiGroup];
                }
                else {
                    [self.data addObject:group];
                }
            }
            [self.tableView reloadData];
        }
    } failure:^(NSString *error) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [TLUIUtility hiddenLoading];
    }];
}

@end
