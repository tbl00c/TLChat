//
//  TLChatGroupDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatGroupDetailViewController.h"
#import "TLChatDetailHelper.h"
#import "TLMessageManager+MessageRecord.h"
#import "TLUserGroupCell.h"

#import "TLChatViewController.h"

#import "TLFriendDetailViewController.h"
#import "TLGroupQRCodeViewController.h"
#import "TLChatFileViewController.h"
#import "TLChatBackgroundSettingViewController.h"

#define     TAG_EMPTY_CHAT_REC      1001

@interface TLChatGroupDetailViewController () <TLUserGroupCellDelegate, TLActionSheetDelegate>

@property (nonatomic, strong) TLChatDetailHelper *helper;

@end

@implementation TLChatGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"聊天详情"];
    
    self.helper = [[TLChatDetailHelper alloc] init];
    self.data = [self.helper chatDetailDataByGroupInfo:self.group];
    
    [self.tableView registerClass:[TLUserGroupCell class] forCellReuseIdentifier:@"TLUserGroupCell"];
}


#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        TLUserGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLUserGroupCell"];
        [cell setUsers:self.group.users];
        [cell setDelegate:self];
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"群二维码"]) {
        TLGroupQRCodeViewController *gorupQRCodeVC = [[TLGroupQRCodeViewController alloc] init];
        [gorupQRCodeVC setGroup:self.group];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:gorupQRCodeVC animated:YES];
    }
    else if ([item.title isEqualToString:@"设置当前聊天背景"]) {
        TLChatBackgroundSettingViewController *chatBGSettingVC = [[TLChatBackgroundSettingViewController alloc] init];
        [chatBGSettingVC setPartnerID:self.group.groupID];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatBGSettingVC animated:YES];
    }
    else if ([item.title isEqualToString:@"聊天文件"]) {
        TLChatFileViewController *chatFileVC = [[TLChatFileViewController alloc] init];
        [chatFileVC setPartnerID:self.group.groupID];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatFileVC animated:YES];
    }
    else if ([item.title isEqualToString:@"清空聊天记录"]) {
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空聊天记录" otherButtonTitles: nil];
        actionSheet.tag = TAG_EMPTY_CHAT_REC;
        [actionSheet show];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSUInteger count = self.group.count;
        return ((count + 1) / 4 + ((((count + 1) % 4) == 0) ? 0 : 1)) * 90 + 15;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

//MARK: TLActionSheetDelegate
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == TAG_EMPTY_CHAT_REC) {
        if (buttonIndex == 0) {
            BOOL ok = [[TLMessageManager sharedInstance] deleteMessagesByPartnerID:self.group.groupID];
            if (!ok) {
                [UIAlertView bk_alertViewWithTitle:@"错误" message:@"清空讨论组聊天记录失败"];
            }
            else {
                [[TLChatViewController sharedChatVC] resetChatVC];
            }
        }
    }
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
    [UIAlertView bk_alertViewWithTitle:@"提示" message:@"添加讨论组成员"];
}
@end
