//
//  TLConversationCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.

#import "TLTableViewCell.h"
#import "TLConversation.h"

@interface TLConversationCell : TLTableViewCell

/// 会话Model
@property (nonatomic, strong) TLConversation *conversation;

#pragma mark - Public Methods
/**
 *  标记为未读
 */
- (void) markAsUnread;

/**
 *  标记为已读
 */
- (void) markAsRead;

@end
