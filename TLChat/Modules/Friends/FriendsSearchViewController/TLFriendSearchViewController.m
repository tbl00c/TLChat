//
//  TLFriendSearchViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendSearchViewController.h"
#import "TLFriendCell.h"
#import "TLFriendHelper.h"

@interface TLFriendSearchViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSMutableArray *friendsData;

@end

@implementation TLFriendSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendsData = [TLFriendHelper sharedFriendHelper].friendsData;
    self.data = @[].mutableCopy;
    [self.tableView registerClass:[TLFriendCell class] forCellReuseIdentifier:@"FriendCell"];
}

#pragma mark - # Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"联系人";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    
    TLUser *user = [self.data objectAtIndex:indexPath.row];
    [cell setUser:user];
    [cell setTopLineStyle:(indexPath.row == 0 ? TLCellLineStyleFill : TLCellLineStyleNone)];
    [cell setBottomLineStyle:(indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault)];
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_FRIEND_CELL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLUser *user = [self.data objectAtIndex:indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.itemSelectedAction) {
        self.itemSelectedAction(self, user);
    }
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    [self.data removeAllObjects];
    for (TLUser *user in self.friendsData) {
        if ([user.remarkName containsString:searchText] || [user.username containsString:searchText] || [user.nikeName containsString:searchText] || [user.pinyin containsString:searchText] || [user.pinyinInitial containsString:searchText]) {
            [self.data addObject:user];
        }
    }
    [self.tableView reloadData];
}

//MARK: UISearchBarDelegate
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [TLUIUtility showAlertWithTitle:@"语音搜索按钮"];
}

@end
