//
//  TLChatBaseViewController+ChatTableViewDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController+ChatTableViewDelegate.h"

@implementation TLChatBaseViewController (ChatTableViewDelegate)

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
- (void)chatTableViewControllerDidTouched:(TLChatTableViewController *)chatTVC
{
    if ([self.chatBar isFirstResponder]) {
        [self.chatBar resignFirstResponder];
    }
}

/**
 *  获取历史记录
 */
- (void)chatTableViewController:(TLChatTableViewController *)chatTVC getRecordsFromDate:(NSDate *)date count:(NSUInteger)count completed:(void (^)(NSDate *, NSArray *, BOOL))completed
{
    NSString *partnerID;
    if (self.curChatType == TLPartnerTypeGroup) {
        partnerID = self.group.groupID;
    }
    else {
        partnerID = self.user.userID;
    }
    [[TLMessageManager sharedInstance] messageRecordForPartner:partnerID fromDate:date count:count complete:^(NSArray *array, BOOL hasMore) {
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
                    message.fromUser = [TLUserHelper sharedHelper].user;
                }
                else {
                    if (self.curChatType == TLPartnerTypeUser) {
                        message.fromUser = self.user;
                    }
                    else {
                        message.fromUser = [self.group memberByUserID:message.friendID];
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
