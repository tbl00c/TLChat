//
//  TLEmojiKeyboardDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEmoji.h"

@class TLEmojiKeyboard;
@protocol TLEmojiKeyboardDelegate <NSObject>

- (BOOL)chatInputViewHasText;

@optional
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didTouchEmojiItem:(TLEmoji *)emoji atRect:(CGRect)rect;

- (void)emojiKeyboardCancelTouchEmojiItem:(TLEmojiKeyboard *)emojiKB;

- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didSelectedEmojiItem:(TLEmoji *)emoji;

- (void)emojiKeyboardSendButtonDown;

- (void)emojiKeyboardEmojiEditButtonDown;

- (void)emojiKeyboardMyEmojiEditButtonDown;

- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB selectedEmojiGroupType:(TLEmojiType)type;

@end
