//
//  TLChatKeyboardController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLChatMacros.h"
#import "TLChatBarDelegate.h"
#import "TLKeyboardDelegate.h"

@class TLChatBaseViewController;

@interface TLChatKeyboardController : NSObject <TLChatBarDelegate, TLKeyboardDelegate>

@property (nonatomic, weak) TLChatBaseViewController *chatBaseVC;

- (void)keyboardWillHide:(NSNotification *)notification;

- (void)keyboardFrameWillChange:(NSNotification *)notification;

- (void)keyboardDidShow:(NSNotification *)notification;

@end
