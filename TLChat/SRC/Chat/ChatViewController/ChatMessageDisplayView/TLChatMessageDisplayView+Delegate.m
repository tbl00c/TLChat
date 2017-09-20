//
//  TLChatMessageDisplayView+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatMessageDisplayView+Delegate.h"
#import "TLTextDisplayView.h"
#import "TLChatEventStatistics.h"

@implementation TLChatMessageDisplayView (Delegate)

#pragma mark - # Public Methods
- (void)registerCellClassForTableView:(UITableView *)tableView
{
    [tableView registerClass:[TLTextMessageCell class] forCellReuseIdentifier:@"TLTextMessageCell"];
    [tableView registerClass:[TLImageMessageCell class] forCellReuseIdentifier:@"TLImageMessageCell"];
    [tableView registerClass:[TLExpressionMessageCell class] forCellReuseIdentifier:@"TLExpressionMessageCell"];
    [tableView registerClass:[TLVoiceMessageCell class] forCellReuseIdentifier:@"TLVoiceMessageCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}

#pragma mark - # Delegate
//MARK: UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMessage * message = self.data[indexPath.row];
    if (message.messageType == TLMessageTypeText) {
        TLTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLTextMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    else if (message.messageType == TLMessageTypeImage) {
        TLImageMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLImageMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    else if (message.messageType == TLMessageTypeExpression) {
        TLExpressionMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLExpressionMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    else if (message.messageType == TLMessageTypeVoice) {
        TLVoiceMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLVoiceMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row >= self.data.count) {
        return 0.0f;
    }
    TLMessage * message = self.data[indexPath.row];
    return message.messageFrame.height;
}

//MARK: TLMessageCellDelegate
- (void)messageCellDidClickAvatarForUser:(TLUser *)user
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didClickUserAvatar:)]) {
        [self.delegate chatMessageDisplayView:self didClickUserAvatar:user];
    }
}

- (void)messageCellTap:(TLMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didClickMessage:)]) {
        [self.delegate chatMessageDisplayView:self didClickMessage:message];
    }
}

/**
 *  双击Message Cell
 */
- (void)messageCellDoubleClick:(TLMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didDoubleClickMessage:)]) {
        [self.delegate chatMessageDisplayView:self didDoubleClickMessage:message];
    }
}

- (void)messageCellLongPress:(TLMessage *)message rect:(CGRect)rect
{
    NSInteger row = [self.data indexOfObject:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    if (self.disableLongPressMenu) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }

    CGRect cellRect = [self.tableView rectForRowAtIndexPath:indexPath];
    rect.origin.y += cellRect.origin.y - self.tableView.contentOffset.y;
    __weak typeof(self)weakSelf = self;
    [self.menuView showInView:self withMessageType:message.messageType rect:rect actionBlock:^(TLChatMenuItemType type) {
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        if (type == TLChatMenuItemTypeCopy) {
            NSString *str = [message messageCopy];
            [[UIPasteboard generalPasteboard] setString:str];
        }
        else if (type == TLChatMenuItemTypeDelete) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"是否删除该条消息" delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil];
            actionSheet.tag = [weakSelf.data indexOfObject:message];
            [actionSheet show];
        }
    }];
}

//MARK: UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayViewDidTouched:)]) {
        [self.delegate chatMessageDisplayViewDidTouched:self];
    }
}

//MARK: TLActionSheetDelegate
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        TLMessage * message = [self.data objectAtIndex:actionSheet.tag];
        [self p_deleteMessage:message];
    }
}

#pragma mark - # Private Methods
- (void)p_deleteMessage:(TLMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:deleteMessage:)]) {
        BOOL ok = [self.delegate chatMessageDisplayView:self deleteMessage:message];
        if (ok) {
            [self deleteMessage:message withAnimation:YES];
            [MobClick event:EVENT_DELETE_MESSAGE];
        }
        else {
            [TLUIUtility showAlertWithTitle:@"错误" message:@"从数据库中删除消息失败。"];
        }
    }
}

@end
