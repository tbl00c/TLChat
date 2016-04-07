//
//  TLChatTableViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatTableViewControllerDelegate.h"
#import "TLChatCellMenuView.h"

#import "TLTextMessage.h"
#import "TLImageMessage.h"
#import "TLExpressionMessage.h"


@interface TLChatTableViewController : UITableViewController

@property (nonatomic, assign) id<TLChatTableViewControllerDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) TLChatCellMenuView *menuView;

/// 禁用下拉刷新
@property (nonatomic, assign) BOOL disablePullToRefresh;

/**
 *  发送消息（在列表展示）
 */
- (void)addMessage:(TLMessage *)message;

/**
 *  删除消息
 */
- (void)deleteMessage:(TLMessage *)message;

/**
 *  滚动到底部
 *
 *  @param animation 是否执行动画
 */
- (void)scrollToBottomWithAnimation:(BOOL)animation;

/**
 *  重新加载聊天信息
 */
- (void)reloadData;

@end
