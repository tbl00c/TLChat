//
//  TLEmojiKeyboard+EmojiGroupControl.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard+EmojiGroupControl.h"
#import "TLExpressionGroupModel+TLEmojiKB.h"

@implementation TLEmojiKeyboard (EmojiGroupControl)

#pragma mark - Delegate
//MARK: TLEmojiGroupControlDelegate
- (void)emojiGroupControl:(TLEmojiGroupControl *)emojiGroupControl didSelectedGroup:(TLExpressionGroupModel *)group
{
    // 显示Group表情
    self.curGroup = group;
    [self.displayView scrollToEmojiGroupAtIndex:[self.emojiGroupData indexOfObject:group]];
    [self.pageControl setNumberOfPages:group.pageNumber];
    [self.pageControl setCurrentPage:0];
    // 更新chatBar的textView状态
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboard:selectedEmojiGroupType:)]) {
        [self.delegate emojiKeyboard:self selectedEmojiGroupType:group.type];
    }
}

- (void)emojiGroupControlEditMyEmojiButtonDown:(TLEmojiGroupControl *)emojiGroupControl
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardMyEmojiEditButtonDown)]) {
        [self.delegate emojiKeyboardMyEmojiEditButtonDown];
    }
}

- (void)emojiGroupControlEditButtonDown:(TLEmojiGroupControl *)emojiGroupControl
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardEmojiEditButtonDown)]) {
        [self.delegate emojiKeyboardEmojiEditButtonDown];
    }
}

- (void)emojiGroupControlSendButtonDown:(TLEmojiGroupControl *)emojiGroupControl
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardSendButtonDown)]) {
        [self.delegate emojiKeyboardSendButtonDown];
    }
}

@end
