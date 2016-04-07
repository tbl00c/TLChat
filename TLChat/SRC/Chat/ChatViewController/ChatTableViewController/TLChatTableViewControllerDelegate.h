//
//  TLChatTableViewControllerDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMessage.h"

@class TLChatTableViewController;
@protocol TLChatTableViewControllerDelegate <NSObject>

- (void)chatTableViewControllerDidTouched:(TLChatTableViewController *)chatTVC;

- (void)chatTableViewController:(TLChatTableViewController *)chatTVC
             getRecordsFromDate:(NSDate *)date
                          count:(NSUInteger)count
                      completed:(void (^)(NSDate *, NSArray *, BOOL))completed;

- (BOOL)chatTableViewController:(TLChatTableViewController *)chatTVC
                  deleteMessage:(TLMessage *)message;

@end
