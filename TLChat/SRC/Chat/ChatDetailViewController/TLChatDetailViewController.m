//
//  TLChatDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatDetailViewController.h"
#import "TLChatDetailHelper.h"
#import "TLUserGroupCell.h"
#import "TLFriendDetailViewController.h"

@interface TLChatDetailViewController () <TLUserGroupCellDelegate>

@property (nonatomic, strong) TLChatDetailHelper *helper;

@end

@implementation TLChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"聊天详情"];
    
    self.helper = [[TLChatDetailHelper alloc] init];
    self.data = [self.helper chatDetailDataByUserInfo:self.user];
    
    [self.tableView registerClass:[TLUserGroupCell class] forCellReuseIdentifier:@"TLUserGroupCell"];
}


#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLUserGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLUserGroupCell"];
        [cell setUsers:[NSMutableArray arrayWithArray:@[self.user]]];
        [cell setDelegate:self];
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSUInteger count = self.user ? 1 : 0;
        return ((count + 1) / 4 + ((((count + 1) % 4) == 0) ? 0 : 1)) * 90 + 15;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

//MARK: TLUserGroupCellDelegate
- (void)userGroupCellDidSelectUser:(TLUser *)user
{
    TLFriendDetailViewController *detailVC = [[TLFriendDetailViewController alloc] init];
    [detailVC setUser:user];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)userGroupCellAddUserButtonDown
{
    [UIAlertView alertWithTitle:@"提示" message:@"添加讨论组成员"];
}

@end
