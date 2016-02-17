//
//  TLChatEmojiKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatKeyboardDelegate.h"

@interface TLChatEmojiKeyboard : UIView

@property (nonatomic, assign) id<TLChatKeyboardDelegate> delegate;

+ (TLChatEmojiKeyboard *)keyboard;

- (void) showInView:(UIView *)view withAnimation:(BOOL)animation;

- (void) dismissWithAnimation:(BOOL)animation;

@end
