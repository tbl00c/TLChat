//
//  TLEmojiKeyboardDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEmoji.h"

@protocol TLEmojiKeyboardDelegate <NSObject>

- (BOOL)chatInputViewHasText;

@optional
- (void)touchInEmojiItem:(TLEmoji *)emoji rect:(CGRect)rect;

- (void)cancelTouchEmojiItem;

- (void)selectedEmojiItem:(TLEmoji *)emoji;

- (void)sendButtonDown;

- (void)emojiEditButtonDown;

- (void)myEmojiEditButtonDown;

@end
