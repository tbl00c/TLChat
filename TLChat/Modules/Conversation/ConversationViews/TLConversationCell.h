//
//  TLConversationCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.

#import <UIKit/UIKit.h>
#import "TLConversation.h"

#define     HEIGHT_CONVERSATION_CELL        64.0f

typedef NS_ENUM(NSInteger, TLConversationCellSeperatorStyle) {
    TLConversationCellSeperatorStyleDefault,
    TLConversationCellSeperatorStyleFill,
};

@interface TLConversationCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

/// 会话Model
@property (nonatomic, strong) TLConversation *conversation;

@property (nonatomic, assign) TLConversationCellSeperatorStyle bottomSeperatorStyle;

/**
 *  标记为未读
 */
- (void)markAsUnread;

/**
 *  标记为已读
 */
- (void)markAsRead;

@end
