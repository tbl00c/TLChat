//
//  TLConversationViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationViewController+Delegate.h"
#import "TLConversation+TLUser.h"
#import "TLConversationCell.h"

@implementation TLConversationViewController (Delegate)

#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.tableView registerClass:[TLConversationCell class] forCellReuseIdentifier:@"TLConversationCell"];
}

#pragma mark - Delegate -
//MARK: TLMessageManagerConvVCDelegate
- (void)updateConversationData
{
    [[TLMessageManager sharedInstance] conversationRecord:^(NSArray *data) {
        for (TLConversation *conversation in data) {
            if (conversation.convType == TLConversationTypePersonal) {
                TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:conversation.partnerID];
                [conversation updateUserInfo:user];
            }
            else if (conversation.convType == TLConversationTypeGroup) {
                TLGroup *group = [[TLFriendHelper sharedFriendHelper] getGroupInfoByGroupID:conversation.partnerID];
                [conversation updateGroupInfo:group];
            }
        }
        self.data = [[NSMutableArray alloc] initWithArray:data];
        [self.tableView reloadData];
    }];
}

//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    TLConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLConversationCell"];
    [cell setConversation:conversation];
    [cell setBottomLineStyle:indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault];
    
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CONVERSATION_CELL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TLChatViewController *chatVC = [TLChatViewController sharedChatVC];
    
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    if (conversation.convType == TLConversationTypePersonal) {
        TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:conversation.partnerID];
        if (user == nil) {
            [UIAlertView bk_alertViewWithTitle:@"错误" message:@"您不存在此好友"];
            return;
        }
        [chatVC setPartner:user];
    }
    else if (conversation.convType == TLConversationTypeGroup){
        TLGroup *group = [[TLFriendHelper sharedFriendHelper] getGroupInfoByGroupID:conversation.partnerID];
        if (group == nil) {
            [UIAlertView bk_alertViewWithTitle:@"错误" message:@"您不存在该讨论组"];
            return;
        }
        [chatVC setPartner:group];
    }
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chatVC animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    
    // 标为已读
    [(TLConversationCell *)[self.tableView cellForRowAtIndexPath:indexPath] markAsRead];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                       {
                                           [weakSelf.data removeObjectAtIndex:indexPath.row];
                                           BOOL ok = [[TLMessageManager sharedInstance] deleteConversationByPartnerID:conversation.partnerID];
                                           if (!ok) {
                                               [UIAlertView bk_alertViewWithTitle:@"错误" message:@"从数据库中删除会话信息失败"];
                                           }
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
    moreAction.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    return @[delAction, moreAction];
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
// 选中了addMenu的某个菜单项
- (void)addMenuView:(TLAddMenuView *)addMenuView didSelectedItem:(TLAddMenuItem *)item
{
    if (item.className.length > 0) {
        id vc = [[NSClassFromString(item.className) alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else {
        [UIAlertView bk_alertViewWithTitle:item.title message:@"功能暂未实现"];
    }
}

@end