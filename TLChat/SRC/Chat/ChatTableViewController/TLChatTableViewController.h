//
//  TLChatTableViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatCellMenuView.h"
#import "TLMessage.h"

@class TLChatTableViewController;
@protocol TLChatTableViewControllerDelegate <NSObject>

- (void)chatTableViewControllerDidTouched:(TLChatTableViewController *)chatTVC;

- (void)chatRecordsFromDate:(NSDate *)date
                      count:(NSUInteger)count
                  completed:(void (^)(NSDate *, NSArray *, BOOL))completed;

@end

@interface TLChatTableViewController : UITableViewController

@property (nonatomic, assign) id<TLChatTableViewControllerDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) TLChatCellMenuView *menuView;

/**
 *  发送消息（在列表展示）
 */
- (void)addMessage:(TLMessage *)message;

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
