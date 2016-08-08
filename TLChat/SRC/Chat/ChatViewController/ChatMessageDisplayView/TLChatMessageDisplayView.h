//
//  TLChatMessageDisplayView.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatMessageDisplayViewDelegate.h"
#import "TLChatCellMenuView.h"

#import "TLTextMessage.h"
#import "TLImageMessage.h"
#import "TLExpressionMessage.h"
#import "TLVoiceMessage.h"


@interface TLChatMessageDisplayView : UIView

@property (nonatomic, assign) id<TLChatMessageDisplayViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong, readonly) UITableView *tableView;

/// 禁用下拉刷新
@property (nonatomic, assign) BOOL disablePullToRefresh;

/// 禁用长按菜单
@property (nonatomic, assign) BOOL disableLongPressMenu;


/**
 *  发送消息（在列表展示）
 */
- (void)addMessage:(TLMessage *)message;

/**
 *  删除消息
 */
- (void)deleteMessage:(TLMessage *)message;
- (void)deleteMessage:(TLMessage *)message withAnimation:(BOOL)animation;

/**
 *  更新消息状态
 */
- (void)updateMessage:(TLMessage *)message;
- (void)reloadData;

/**
 *  滚动到底部
 *
 *  @param animation 是否执行动画
 */
- (void)scrollToBottomWithAnimation:(BOOL)animation;

/**
 *  重新加载聊天信息
 */
- (void)resetMessageView;

@end
