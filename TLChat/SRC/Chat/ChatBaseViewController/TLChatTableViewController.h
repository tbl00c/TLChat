//
//  TLChatTableViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMessage.h"

@class TLChatTableViewController;
@protocol TLChatTableViewControllerDelegate <NSObject>

- (void)chatTableViewControllerDidTouched:(TLChatTableViewController *)chatTVC;

@end

@interface TLChatTableViewController : UITableViewController

@property (nonatomic, assign) id<TLChatTableViewControllerDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *data;

- (void)sendMessage:(TLMessage *)message;

- (void)scrollToBottomWithAnimation:(BOOL)animation;

- (void)clearData;

@end
