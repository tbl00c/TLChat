//
//  TLChatBaseViewController+ChatBar.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController.h"
#import "TLMoreKeyboard.h"
#import "TLEmojiKeyboard.h"

@interface TLChatBaseViewController (ChatBar) <TLChatBarDelegate, TLKeyboardDelegate, TLEmojiKeyboardDelegate>

/// 表情键盘
@property (nonatomic, strong, readonly) TLEmojiKeyboard *emojiKeyboard;

/// 更多键盘
@property (nonatomic, strong, readonly) TLMoreKeyboard *moreKeyboard;

- (void)loadKeyboard;
- (void)dismissKeyboard;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardFrameWillChange:(NSNotification *)notification;


@end
