//
//  TLChatBaseViewController+ChatTableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+ChatTableView.h"
#import "TLTextDisplayView.h"

@implementation TLChatBaseViewController (ChatTableView)

#pragma mark - Public Methods -
- (void)addToShowMessage:(TLMessage *)message
{
    message.showTime = [self p_needShowTime:message.date];
    [self.chatTableVC addMessage:message];
    [self.chatTableVC scrollToBottomWithAnimation:YES];
}

- (void)resetChatTVC
{
    [self.chatTableVC reloadData];
    lastDateInterval = 0;
    msgAccumulate = 0;
}

#pragma mark - Delegate -
//MARK: TLChatTableViewControllerDelegate
// chatView 点击事件
- (void)chatTableViewControllerDidTouched:(TLChatTableViewController *)chatTVC
{
    if ([self.chatBar isFirstResponder]) {
        [self.chatBar resignFirstResponder];
    }
}

// chatView 获取历史记录
- (void)chatTableViewController:(TLChatTableViewController *)chatTVC getRecordsFromDate:(NSDate *)date count:(NSUInteger)count completed:(void (^)(NSDate *, NSArray *, BOOL))completed
{
    [[TLMessageManager sharedInstance] messageRecordForPartner:[self.partner chat_userID] fromDate:date count:count complete:^(NSArray *array, BOOL hasMore) {
        if (array.count > 0) {
            int count = 0;
            NSTimeInterval tm = 0;
            for (TLMessage *message in array) {
                if (++count > MAX_SHOWTIME_MSG_COUNT || tm == 0 || message.date.timeIntervalSince1970 - tm > MAX_SHOWTIME_MSG_SECOND) {
                    tm = message.date.timeIntervalSince1970;
                    count = 0;
                    message.showTime = YES;
                }
                if (message.ownerTyper == TLMessageOwnerTypeSelf) {
                    message.fromUser = self.user;
                }
                else {
                    if ([self.partner chat_userType] == TLChatUserTypeUser) {
                        message.fromUser = self.partner;
                    }
                    else if ([self.partner chat_userType] == TLChatUserTypeGroup){
                        if ([self.partner respondsToSelector:@selector(groupMemberByID:)]) {
                            message.fromUser = [self.partner groupMemberByID:message.friendID];
                        }
                    }
                }
            }
        }
        completed(date, array, hasMore);
    }];
}

- (BOOL)chatTableViewController:(TLChatTableViewController *)chatTVC deleteMessage:(TLMessage *)message
{
    return [[TLMessageManager sharedInstance] deleteMessageByMsgID:message.messageID];
}

- (void)chatTableViewController:(TLChatTableViewController *)chatTVC didClickUserAvatar:(TLUser *)user
{
    if ([self respondsToSelector:@selector(didClickedUserAvatar:)]) {
        [self didClickedUserAvatar:user];
    }
}

- (void)chatTableViewController:(TLChatTableViewController *)chatTVC didDoubleClickMessage:(TLMessage *)message
{
    if (message.messageType == TLMessageTypeText) {
        TLTextDisplayView *displayView = [[TLTextDisplayView alloc] init];
        [displayView showInView:self.navigationController.view withAttrText:[(TLTextMessage *)message attrText] animation:YES];
    }
}

- (void)chatTableViewController:(TLChatTableViewController *)chatTVC didClickMessage:(TLMessage *)message
{
    if (message.messageType == TLMessageTypeImage && [self respondsToSelector:@selector(didClickedImageMessages:atIndex:)]) {
        [[TLMessageManager sharedInstance] chatImagesAndVideosForPartnerID:[self.partner chat_userID] completed:^(NSArray *imagesData) {
            NSInteger index = -1;
            for (int i = 0; i < imagesData.count; i ++) {
                if ([message.messageID isEqualToString:[imagesData[i] messageID]]) {
                    index = i;
                    break;
                }
            }
            if (index >= 0) {
                [self didClickedImageMessages:imagesData atIndex:index];
            }
        }];
    }
}

#pragma mark - Private Methods -
static NSTimeInterval lastDateInterval = 0;
static NSInteger msgAccumulate = 0;
- (BOOL)p_needShowTime:(NSDate *)date
{
    if (++msgAccumulate > MAX_SHOWTIME_MSG_COUNT || lastDateInterval == 0 || date.timeIntervalSince1970 - lastDateInterval > MAX_SHOWTIME_MSG_SECOND) {
        lastDateInterval = date.timeIntervalSince1970;
        msgAccumulate = 0;
        return YES;
    }
    return NO;
}


@end
