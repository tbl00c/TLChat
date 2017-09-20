//
//  TLFriendDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailViewController.h"
#import "TLFriendDetailViewController+Delegate.h"
#import "TLFriendDetailSettingViewController.h"
#import "TLFriendHelper+Detail.h"

@implementation TLFriendDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"详细资料"];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self registerCellClass];
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    NSArray *array = [[TLFriendHelper sharedFriendHelper] friendDetailArrayByUserInfo:self.user];
    self.data = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    TLFriendDetailSettingViewController *detailSetiingVC = [[TLFriendDetailSettingViewController alloc] init];
    [detailSetiingVC setUser:self.user];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailSetiingVC animated:YES];
}

@end
