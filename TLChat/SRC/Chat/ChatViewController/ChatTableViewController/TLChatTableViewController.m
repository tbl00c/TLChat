//
//  TLChatTableViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatTableViewController.h"
#import "TLChatTableViewController+Delegate.h"
#import <MJRefresh.h>

#define     PAGE_MESSAGE_COUNT      15

@interface TLChatTableViewController ()

@property (nonatomic, strong) MJRefreshNormalHeader *refresHeader;

/// 用户决定新消息是否显示时间
@property (nonatomic, strong) NSDate *curDate;

@end

@implementation TLChatTableViewController
@synthesize data = _data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 20)]];
    if (!self.disablePullToRefresh) {
        [self.tableView setMj_header:self.refresHeader];
    }
    [self registerCellClass];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTableView)];
    [self.tableView addGestureRecognizer:tap];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.menuView isShow]) {
        [self.menuView dismiss];
    }
}

#pragma mark - Public Methods -
- (void)reloadData
{
    [self.data removeAllObjects];
    [self.tableView reloadData];
    self.curDate = [NSDate date];
    if (!self.disablePullToRefresh) {
        [self.tableView setMj_header:self.refresHeader];
    }
    [self p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
        if (!hasMore) {
            self.tableView.mj_header = nil;
        }
        if (count > 0) {
            [self.tableView reloadData];
            [self.tableView scrollToBottomWithAnimation:NO];
        }
    }];
}

- (void)addMessage:(TLMessage *)message
{
    [self.data addObject:message];
    [self.tableView reloadData];
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    [self.tableView reloadData];
}

- (void)deleteMessage:(TLMessage *)message
{
    NSInteger index = [self.data indexOfObject:message];
    if (_delegate && [_delegate respondsToSelector:@selector(chatTableViewController:deleteMessage:)]) {
        BOOL ok = [_delegate chatTableViewController:self deleteMessage:message];
        if (ok) {
            [self.data removeObject:message];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [MobClick event:EVENT_DELETE_MESSAGE];
        }
        else {
            [UIAlertView bk_alertViewWithTitle:@"错误" message:@"从数据库中删除消息失败。"];
        }
    }
}

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    [self.tableView scrollToBottomWithAnimation:animation];
}

- (void)setDisablePullToRefresh:(BOOL)disablePullToRefresh
{
    if (disablePullToRefresh) {
        [self.tableView setMj_header:nil];
    }
    else {
        [self.tableView setMj_header:self.refresHeader];
    }
}

#pragma mark - Event Response -
- (void)didTouchTableView
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatTableViewControllerDidTouched:)]) {
        [_delegate chatTableViewControllerDidTouched:self];
    }
}

#pragma mark - Private Methods -
/**
 *  获取聊天历史记录
 */
- (void)p_tryToRefreshMoreRecord:(void (^)(NSInteger count, BOOL hasMore))complete
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatTableViewController:getRecordsFromDate:count:completed:)]) {
        [_delegate chatTableViewController:self
                        getRecordsFromDate:self.curDate
                                     count:PAGE_MESSAGE_COUNT
                                 completed:^(NSDate *date, NSArray *array, BOOL hasMore) {
                                     if (array.count > 0 && [date isEqualToDate:self.curDate]) {
                                         self.curDate = [array[0] date];
                                         [self.data insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
                                         complete(array.count, hasMore);
                                     }
                                     else {
                                         complete(0, hasMore);
                                     }
                                 }];
    }

}

#pragma mark - Getter -
- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (TLChatCellMenuView *)menuView
{
    if (_menuView == nil) {
        _menuView = [[TLChatCellMenuView alloc] init];
    }
    return _menuView;
}

- (MJRefreshNormalHeader *)refresHeader
{
    if (_refresHeader == nil) {
        _refresHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
                [self.tableView.mj_header endRefreshing];
                if (!hasMore) {
                    self.tableView.mj_header = nil;
                }
                if (count > 0) {
                    [self.tableView reloadData];
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }];
        }];
        _refresHeader.lastUpdatedTimeLabel.hidden = YES;
        _refresHeader.stateLabel.hidden = YES;
    }
    return _refresHeader;
}

@end
