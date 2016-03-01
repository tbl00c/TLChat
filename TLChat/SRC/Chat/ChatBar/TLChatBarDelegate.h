//
//  TLChatBarDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLChatMacros.h"

@class TLChatBar;
@protocol TLChatBarDelegate <NSObject>

/**
 *  键盘状态改变
 */
- (void)chatBar:(TLChatBar *)chatBar changeStatusFrom:(TLChatBarStatus)fromStatus to:(TLChatBarStatus)toStatus;

/**
 *  输入框高度改变
 */
- (void)chatBar:(TLChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height;

@end