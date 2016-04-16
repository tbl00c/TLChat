//
//  TLEmojiKeyboard+GroupControlDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard+GroupControlDelegate.h"
#import "TLEmojiKeyboard+CollectionViewDelegate.h"

@implementation TLEmojiKeyboard (GroupControlDelegate)

#pragma mark - Public Methods -
- (void)updateSendButtonStatus
{
    if (self.curGroup.type == TLEmojiTypeEmoji || self.curGroup.type == TLEmojiTypeFace) {
        if ([self.delegate chatInputViewHasText]) {
            [self.groupControl setSendButtonStatus:TLGroupControlSendButtonStatusBlue];
        }
        else {
            [self.groupControl setSendButtonStatus:TLGroupControlSendButtonStatusGray];
        }
    }
    else {
        [self.groupControl setSendButtonStatus:TLGroupControlSendButtonStatusNone];
    }
}

#pragma mark - Delegate -
//MARK: TLEmojiGroupControlDelegate
- (void)emojiGroupControl:(TLEmojiGroupControl *)emojiGroupControl didSelectedGroup:(TLEmojiGroup *)group
{
    // 显示Group表情
    self.curGroup = group;
    [self resetCollectionSize];
    [self.pageControl setNumberOfPages:group.pageNumber];
    [self.pageControl setCurrentPage:0];
    [self.collectionView reloadData];
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.collectionView.width, self.collectionView.height) animated:NO];
    // 更新发送按钮状态
    [self updateSendButtonStatus];
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
    // 更新发送按钮状态
    [self updateSendButtonStatus];
}

@end
