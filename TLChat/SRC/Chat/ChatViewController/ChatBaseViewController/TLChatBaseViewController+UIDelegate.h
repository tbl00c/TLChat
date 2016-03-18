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

@interface TLChatBaseViewController (UIDelegate) <TLChatBarDelegate, TLKeyboardDelegate>

- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardFrameWillChange:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;

@end
