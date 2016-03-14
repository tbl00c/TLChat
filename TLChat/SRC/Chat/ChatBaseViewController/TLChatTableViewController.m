//
//  TLChatTableViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatTableViewController.h"
#import "TLFriendDetailViewController.h"
#import "TLTextMessageCell.h"
#import <MJRefresh.h>

#define     PAGE_MESSAGE_COUNT      15

@interface TLChatTableViewController () <TLMessageCellDelegate>

@property (nonatomic, strong) MJRefreshNormalHeader *refresHeader;

@property (nonatomic, strong) NSDate *curDate;

@end

@implementation TLChatTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorChatTableViewBG]];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    self.refresHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
    self.refresHeader.lastUpdatedTimeLabel.hidden = YES;
    self.refresHeader.stateLabel.hidden = YES;
    [self.tableView setMj_header:self.refresHeader];
    
    [self.tableView registerClass:[TLTextMessageCell class] forCellReuseIdentifier:@"TLTextMessageCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTableView)];
    [self.tableView addGestureRecognizer:tap];
}

#pragma mark - Public Methods -
- (void)clearData
{
    [self.data removeAllObjects];
    [self.tableView reloadData];
    [self.tableView setMj_header:self.refresHeader];
    self.curDate = [NSDate date];
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

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    [self.tableView scrollToBottomWithAnimation:animation];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMessage *message = self.data[indexPath.row];
    if (message.messageType == TLMessageTypeText) {
        TLTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLTextMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    return nil;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TLMessage *message = self.data[indexPath.row];
    return message.frame.height;
}

//MARK: TLMessageCellDelegate
- (void)messageCellDidClickAvatarForUser:(TLUser *)user
{
    TLFriendDetailViewController *detailVC = [[TLFriendDetailViewController alloc] init];
    [detailVC setUser:user];
    [self.parentViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//MARK: UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatTableViewControllerDidTouched:)]) {
        [_delegate chatTableViewControllerDidTouched:self];
    }
}

#pragma mark - Event Response -
- (void)p_tryToRefreshMoreRecord:(void (^)(NSInteger count, BOOL hasMore))complete
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatRecordsFromDate:count:completed:)]) {
        [_delegate chatRecordsFromDate:self.curDate
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

- (void)didTouchTableView
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatTableViewControllerDidTouched:)]) {
        [_delegate chatTableViewControllerDidTouched:self];
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

@end
