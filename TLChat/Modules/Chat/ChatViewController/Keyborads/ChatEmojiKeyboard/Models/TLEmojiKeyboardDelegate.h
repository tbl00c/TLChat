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
/**
 *  长按某个表情（展示）
 */
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didTouchEmojiItem:(TLEmoji *)emoji atRect:(CGRect)rect;

/**
 *  取消长按某个表情（停止展示）
 */
- (void)emojiKeyboardCancelTouchEmojiItem:(TLEmojiKeyboard *)emojiKB;

/**
 *  点击事件 —— 选中某个表情
 */
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didSelectedEmojiItem:(TLEmoji *)emoji;

/**
 *  点击事件 —— 表情发送按钮
 */
- (void)emojiKeyboardSendButtonDown;

/**
 *  点击事件 —— 删除按钮
 */
- (void)emojiKeyboardDeleteButtonDown;

/**
 *  点击事件 —— 表情编辑按钮
 */
- (void)emojiKeyboardEmojiEditButtonDown;

/**
 *  点击事件 —— 我的表情按钮
 */
- (void)emojiKeyboardMyEmojiEditButtonDown;

/**
 *  选中不同类型的表情组回调
 *  用于改变chatBar状态（个性表情组展示时textView不可用）
 */
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB selectedEmojiGroupType:(TLEmojiType)type;

@end
