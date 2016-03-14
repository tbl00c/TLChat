//
//  TLConversationViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationViewController.h"
#import "TLFriendSearchViewController.h"
#import "TLChatViewController.h"
#import "TLConversationCell.h"
#import "TLSearchController.h"
#import "TLAddMenuView.h"
#import "TLFriendHelper.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

#define     HEIGHT_CONVERSATION_CELL        65.0f

@interface TLConversationViewController () <UISearchBarDelegate, TLAddMenuViewDelegate>

@property (nonatomic, strong) UIImageView *scrollTopView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) TLSearchController *searchController;

@property (nonatomic, strong) TLFriendSearchViewController *searchVC;

@property (nonatomic, strong) TLAddMenuView *addMenuView;

@end

@implementation TLConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"微信"];
    
    [self p_initUI];        // 初始化界面UI
    
    [self.tableView registerClass:[TLConversationCell class] forCellReuseIdentifier:@"TLConversationCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    [self initTestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.addMenuView.isShow) {
        [self.addMenuView dismiss];
    }
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    TLConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLConversationCell"];
    [cell setConversation:conversation];
    
    [cell setTopLineStyle:indexPath.row == 0 ? TLCellLineStyleFill : TLCellLineStyleNone];
    [cell setBottomLineStyle:indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault];
    
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CONVERSATION_CELL;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TLChatViewController *chatVC = [TLChatViewController sharedChatVC];
    
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    if (conversation.convType == TLConversationTypePersonal) {
        TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:conversation.userID];
        if (user == nil) {
            [UIAlertView alertWithTitle:@"错误" message:@"您不存在此好友"];
            return;
        }
        [chatVC setUser:user];
    }
    else if (conversation.convType == TLConversationTypeGroup){
        TLGroup *group = [[TLFriendHelper sharedFriendHelper] getGroupInfoByGroupID:conversation.userID];
        if (group == nil) {
            [UIAlertView alertWithTitle:@"错误" message:@"您不存在该讨论组"];
            return;
        }
        [chatVC setGroup:group];
    }
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chatVC animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    
    // 标为已读
    [(TLConversationCell *)[self.tableView cellForRowAtIndexPath:indexPath] markAsRead];
}

- (NSArray *) tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        [weakSelf.data removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (self.data.count > 0 && indexPath.row == self.data.count) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
            TLConversationCell *cell = [self.tableView cellForRowAtIndexPath:lastIndexPath];
            [cell setBottomLineStyle:TLCellLineStyleFill];
        }
    }];
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                          title:conversation.isRead ? @"标为未读" : @"标为已读"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        TLConversationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        conversation.isRead ? [cell markAsUnread] : [cell markAsRead];
        [tableView setEditing:NO animated:YES];
    }];
    moreAction.backgroundColor = [UIColor colorCellMoreButton];
    return @[delAction, moreAction];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchVC setFriendsData:[TLFriendHelper sharedFriendHelper].friendsData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"语音搜索按钮" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

//MARK: TLAddMenuViewDelegate
//  选中了addMenu的某个菜单项
- (void)addMenuView:(TLAddMenuView *)addMenuView didSelectedItem:(TLAddMenuItem *)item
{
    if (item.className.length > 0) {
        id vc = [[NSClassFromString(item.className) alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else {
        [UIAlertView alertWithTitle:item.title message:@"功能暂未实现"];
    }
}

#pragma mark - Event Response
- (void) rightBarButtonDown:(UIBarButtonItem *)sender
{
    if (self.addMenuView.isShow) {
        [self.addMenuView dismiss];
    }
    else {
        [self.addMenuView showInView:self.navigationController.view];
    }
}

// 网络情况改变
- (void)networkStatusChange:(NSNotification *)noti
{
    AFNetworkReachabilityStatus status = [noti.userInfo[@"AFNetworkingReachabilityNotificationStatusItem"] longValue];
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusUnknown:
            self.navigationItem.title = @"微信";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            self.navigationItem.title = @"微信(未连接)";
            break;
        default:
            break;
    }
}

#pragma mark - Private Methods -
- (void) p_initUI
{
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    [self.tableView addSubview:self.scrollTopView];
    [self.scrollTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tableView);
        make.bottom.mas_equalTo(self.tableView.mas_top).mas_offset(-35);
    }];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void) initTestData
{
    TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:@"u1007"];
    TLConversation *conv1 = [[TLConversation alloc] init];
    conv1.convType = TLConversationTypePersonal;
    conv1.userID = user.userID;
    conv1.username = user.showName;
    conv1.avatarURL = user.avatarURL;
    conv1.messageDetail = @"你好啊";
    conv1.date = [NSDate date];
    
    TLGroup *group = [[TLFriendHelper sharedFriendHelper] getGroupInfoByGroupID:@"g1001"];
    TLConversation *conv2 = [[TLConversation alloc] init];
    conv2.convType = TLConversationTypeGroup;
    conv2.userID = group.groupID;
    conv2.username = group.groupName;
    conv2.messageDetail = @"掌柜的：开工了~~";
    conv2.date = [NSDate date];
    [TLUIUtility getGroupAvatarByGroupUsers:group.users finished:^(NSString *avatarPath) {
        conv2.avatarPath = group.groupAvatarPath = avatarPath;
        [self.tableView reloadData];
    }];
    
    self.data = [NSMutableArray arrayWithObjects:conv1, conv2, nil];
}

#pragma mark - Getter -
- (TLSearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[TLSearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController setSearchResultsUpdater:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setDelegate:self];
        [_searchController setShowVoiceButton:YES];
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

- (UIImageView *)scrollTopView
{
    if (_scrollTopView == nil) {
        _scrollTopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conv_wechat_icon"]];
    }
    return _scrollTopView;
}

- (TLAddMenuView *)addMenuView
{
    if (_addMenuView == nil) {
        _addMenuView = [[TLAddMenuView alloc] init];
        [_addMenuView setDelegate:self];
    }
    return _addMenuView;
}

@end
