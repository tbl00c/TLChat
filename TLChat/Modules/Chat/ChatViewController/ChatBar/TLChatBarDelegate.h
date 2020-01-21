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
 *  chatBar状态改变
 */
- (void)chatBar:(TLChatBar *)chatBar changeStatusFrom:(TLChatBarStatus)fromStatus to:(TLChatBarStatus)toStatus;

/**
 *  输入框高度改变
 */
- (void)chatBar:(TLChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height;

/**
 *  发送文字
 */
- (void)chatBar:(TLChatBar *)chatBar sendText:(NSString *)text;


// 录音控制 
- (void)chatBarStartRecording:(TLChatBar *)chatBar;

- (void)chatBarWillCancelRecording:(TLChatBar *)chatBar cancel:(BOOL)cancel;

- (void)chatBarDidCancelRecording:(TLChatBar *)chatBar;

- (void)chatBarFinishedRecoding:(TLChatBar *)chatBar;

@end