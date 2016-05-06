//
//  TLChatBaseViewController+UIDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController.h"
#import "TLChatMacros.h"
#import "TLChatBarDelegate.h"
#import "TLKeyboardDelegate.h"

/**
 *  1、处理各种键盘（系统、自定义表情、自定义更多）回调
 *  2、响应chatBar的按钮点击事件
 */

@interface TLChatBaseViewController (UIDelegate) <TLChatBarDelegate, TLKeyboardDelegate>

- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardFrameWillChange:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;

@end
