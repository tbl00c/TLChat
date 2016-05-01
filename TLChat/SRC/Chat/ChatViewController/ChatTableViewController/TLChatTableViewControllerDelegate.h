//
//  TLChatTableViewControllerDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLMessage;
@class TLChatTableViewController;
@protocol TLChatTableViewControllerDelegate <NSObject>

/**
 *  聊天界面点击事件，用于收键盘
 */
- (void)chatTableViewControllerDidTouched:(TLChatTableViewController *)chatTVC;

/**
 *  下拉刷新，获取某个时间段的聊天记录（异步）
 *
 *  @param chatTVC   chatTVC
 *  @param date      开始时间
 *  @param count     条数
 *  @param completed 结果Blcok
 */
- (void)chatTableViewController:(TLChatTableViewController *)chatTVC
             getRecordsFromDate:(NSDate *)date
                          count:(NSUInteger)count
                      completed:(void (^)(NSDate *, NSArray *, BOOL))completed;

@optional
/**
 *  消息长按删除
 *
 *  @return 删除是否成功
 */
- (BOOL)chatTableViewController:(TLChatTableViewController *)chatTVC
                  deleteMessage:(TLMessage *)message;

/**
 *  用户头像点击事件
 */
- (void)chatTableViewController:(TLChatTableViewController *)chatTVC
             didClickUserAvatar:(TLUser *)user;

/**
 *  Message点击事件
 */
- (void)chatTableViewController:(TLChatTableViewController *)chatTVC
                didClickMessage:(TLMessage *)message;

/**
 *  Message双击事件
 */
- (void)chatTableViewController:(TLChatTableViewController *)chatTVC
          didDoubleClickMessage:(TLMessage *)message;

@end
