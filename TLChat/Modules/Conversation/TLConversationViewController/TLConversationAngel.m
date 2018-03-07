//
//  TLConversationAngel.m
//  TLChat
//
//  Created by 李伯坤 on 2017/12/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLConversationAngel.h"
#import <ZZFLEX/ZZFLEXAngel+Private.h>
#import <ZZFLEX/ZZFlexibleLayoutSectionModel.h>
#import "TLConversation.h"
#import "TLMessageManager+ConversationRecord.h"
#import "TLConversationCell.h"

@implementation TLConversationAngel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView badgeStatusChangeAction:(void (^)(NSString *))badgeStatusChangeAction
{
    if (self = [super initWithHostView:hostView]) {
        self.badgeStatusChangeAction = badgeStatusChangeAction;
    }
    return self;
}

- (void)reloadBadge
{
    if (!self.badgeStatusChangeAction) {
        return;
    }
    NSInteger count = 0;
    NSArray *data = self.dataModelArray.all();
    for (TLConversation *conversation in data) {
        if ([conversation isKindOfClass:[TLConversation class]]) {
            if (conversation.unreadCount > 0) {
                count += conversation.unreadCount;
            }
        }
    }
    NSString *badge = count > 0 ? @(count).stringValue : nil;
    self.badgeStatusChangeAction(badge);
}

#pragma mark - # Delegate
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel.sectionTag == TLConversationSectionTagTopConversation
        || sectionModel.sectionTag == TLConversationSectionTagConv) {
        @weakify(self);
        TLConversation *conversation = self.dataModel.atIndexPath(indexPath);
        UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                             title:@"删除"
                                                                           handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                               @strongify(self);
                                                                               [self p_tableView:tableView deleteItemAtIndexPath:indexPath];
                                                                           }];
        UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                              title:conversation.isRead ? @"标为未读" : @"标为已读"
                                                                            handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                                @strongify(self);
                                                                                TLConversation *conversation = self.dataModel.atIndexPath(indexPath);
                                                                                TLConversationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                                                                                conversation.isRead ? [cell markAsUnread] : [cell markAsRead];
                                                                                [tableView setEditing:NO animated:YES];
                                                                                [self reloadBadge];
                                                                            }];
        return @[delAction, moreAction];
    }
    return nil;
}

#pragma mark - # Private Methods
- (void)p_tableView:(UITableView *)tableView deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:indexPath.row];
    TLConversation *conversation = viewModel.dataModel;
    
    if (!conversation) {
        [TLUIUtility showErrorHint:@"获取会话信息时出现异常"];
        return;
    }
    
    // 从数据库中删除
    BOOL ok = [[TLMessageManager sharedInstance] deleteConversationByPartnerID:conversation.partnerID];
    if (!ok) {
        [TLUIUtility showAlertWithTitle:@"错误" message:@"从数据库中删除会话信息失败"];
        return;
    }
    
    // 删除列表数据源
    self.deleteCell.byDataModel(conversation);
    // 删除列表cell
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 分割线
    if (indexPath.row >= 0 && indexPath.row == sectionModel.itemsArray.count) {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        TLConversationCell *cell = [tableView cellForRowAtIndexPath:lastIndexPath];
        [cell setBottomSeperatorStyle:TLConversationCellSeperatorStyleFill];
    }
}

@end
