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

@optional
- (void)touchInEmojiItem:(TLEmoji *)emoji point:(CGPoint)point;

- (void)cancelTouchEmojiItem:(TLEmoji *)emoji;

- (void)selectedEmojiItem:(TLEmoji *)emoji;

- (void)emojiEditButtonDown;

- (void)sendButtonDown;

@end
