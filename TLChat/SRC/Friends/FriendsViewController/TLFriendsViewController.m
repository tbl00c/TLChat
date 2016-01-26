//
//  TLFriendsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendsViewController.h"
#import "TLFriendSearchViewController.h"
#import "TLFriendHeaderView.h"
#import "TLFriendCell.h"
#import "TLUserGroup.h"

@interface TLFriendsViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *sectionHeaders;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) TLFriendSearchViewController *searchVC;

@end

@implementation TLFriendsViewController

- (void)viewDidLoad {
    [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.tableView setSeparatorColor:[TLColorUtility colorCellLine]];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[TLColorUtility colorNavBarBarTint]];
    
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通讯录"];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add_friend"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    [self.tableView registerClass:[TLFriendHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLFriendHeaderView"];
    [self.tableView registerClass:[TLFriendCell class] forCellReuseIdentifier:@"TLFriendCell"];
    
    [self initTestData];
}

#pragma mark - Delegate
#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TLUserGroup *group = [self.data objectAtIndex:section];
    return group.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    TLUserGroup *group = [self.data objectAtIndex:section];
    TLFriendHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLFriendHeaderView"];
    [view setTitle:group.groupName];
    return view;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLFriendCell"];
    TLUserGroup *group = [self.data objectAtIndex:indexPath.section];
    TLUser *user = [group objectAtIndex:indexPath.row];
    [cell setUser:user];
    return cell;
}

// 拼音首字母检索
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeaders;
}

// 检索时空出搜索框
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [self.tableView scrollRectToVisible:_searchController.searchBar.frame animated:NO];
        return -1;
    }
    return index;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else {
        return 22.0f;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark UISearchBarDelegate
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - Event Response
- (void) rightBarButtonDown:(UIBarButtonItem *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Right Bar Button Down!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - Getter
- (NSMutableArray *) data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
        
        TLUser *item_new = [[TLUser alloc] initWithUserID:@"-1" avatarPath:@"friends_new" remarkName:@"新的朋友"];
        TLUser *item_group = [[TLUser alloc] initWithUserID:@"-2" avatarPath:@"friends_group" remarkName:@"群聊"];
        TLUser *item_tag = [[TLUser alloc] initWithUserID:@"-3" avatarPath:@"friends_tag" remarkName:@"标签"];
        TLUser *item_public = [[TLUser alloc] initWithUserID:@"-4" avatarPath:@"friends_public" remarkName:@"公共号"];
        NSMutableArray *defaultItems = [NSMutableArray arrayWithObjects:item_new, item_group, item_tag, item_public, nil];
        TLUserGroup *defaultGroup = [[TLUserGroup alloc] initWithGroupName:nil users:defaultItems];
        [_data addObject:defaultGroup];
    }
    return _data;
}

- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setBarTintColor:[TLColorUtility colorSearchBarTint]];
        [_searchController.searchBar setDelegate:self];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[TLColorUtility colorSearchBarBorder].CGColor];
    }
    return _searchController;
}

- (TLFriendSearchViewController *) searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLFriendSearchViewController alloc] init];
    }
    return _searchVC;
}

- (void) initTestData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *arr1 = [[NSMutableArray alloc] initWithCapacity:3];
        TLUser *user1 = [[TLUser alloc] init];
        user1.nikeName = @"吕轻侯";
        user1.userID = @"yun";
        user1.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        [arr1 addObject:user1];
        TLUser *user2 = [[TLUser alloc] init];
        user2.nikeName = @"白展堂";
        user2.userID = @"小白2";
        user2.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        [arr1 addObject:user2];
        TLUser *user3 = [[TLUser alloc] init];
        user3.remarkName = @"李秀莲";
        user3.userID = @"xiulian";
        user3.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        [arr1 addObject:user3];
        
        TLUserGroup *defaultGroup = [[TLUserGroup alloc] initWithGroupName:@"A" users:arr1];
        [_data addObject:defaultGroup];
        
        NSMutableArray *arr2 = [[NSMutableArray alloc] init];
        TLUser *user4 = [[TLUser alloc] init];
        user4.remarkName = @"燕小六";
        user4.userID = @"xiao6";
        user4.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        [arr2 addObject:user4];
        TLUserGroup *defaultGroup2 = [[TLUserGroup alloc] initWithGroupName:@"B" users:arr2];
        [_data addObject:defaultGroup2];
        
        NSMutableArray *arr3 = [[NSMutableArray alloc] init];
        TLUser *user5 = [[TLUser alloc] init];
        user5.remarkName = @"郭芙蓉";
        user5.userID = @"furongMM";
        user5.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        [arr3 addObject:user5];
        TLUser *user6 = [[TLUser alloc] init];
        user6.nikeName = @"佟湘玉";
        user6.userID = @"yu";
        user6.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        [arr3 addObject:user6];
        TLUser *user7 = [[TLUser alloc] init];
        user7.nikeName = @"莫小贝";
        user7.userID = @"XB";
        user7.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        [arr3 addObject:user7];
        
        TLUserGroup *defaultGroup3 = [[TLUserGroup alloc] initWithGroupName:@"C" users:arr3];
        [_data addObject:defaultGroup3];
        
        self.sectionHeaders = [[NSMutableArray alloc] initWithArray:@[UITableViewIndexSearch, @"A", @"B", @"C"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

@end
