//
//  TLEmojiKeyboard+DisplayView.m
//  TLChat
//
//  Created by 李伯坤 on 16/9/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard+DisplayView.h"

@implementation TLEmojiKeyboard (DisplayView)

#pragma mark - # Delegate
//MARK: TLEmojiGroupDisplayViewDelegate
- (void)emojiGroupDisplayView:(TLEmojiGroupDisplayView *)displayView didClickedEmoji:(TLEmoji *)emoji
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboard:didSelectedEmojiItem:)]) {
        [self.delegate emojiKeyboard:self didSelectedEmojiItem:emoji];
    }
}

- (void)emojiGroupDisplayViewDeleteButtonPressed:(TLEmojiGroupDisplayView *)displayView;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardDeleteButtonDown)]) {
        [self.delegate emojiKeyboardDeleteButtonDown];
    }
}

- (void)emojiGroupDisplayView:(TLEmojiGroupDisplayView *)displayView didScrollToPageIndex:(NSInteger)pageIndex forGroupIndex:(NSInteger)groupIndex
{
    TLEmojiGroup *group = self.emojiGroupData[groupIndex];
    if (self.curGroup != group) {
        self.curGroup = group;
        [self.pageControl setHidden:group.pageNumber <= 1];
        [self.pageControl setNumberOfPages:group.pageNumber];
        [self.groupControl selectEmojiGroupAtIndex:groupIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboard:selectedEmojiGroupType:)]) {
            [self.delegate emojiKeyboard:self selectedEmojiGroupType:group.type];
        }
    }
    [self.pageControl setCurrentPage:pageIndex];

}

static UICollectionViewCell *lastCell;
- (void)emojiGroupDisplayView:(TLEmojiGroupDisplayView *)displayView didLongPressEmoji:(TLEmoji *)emoji atRect:(CGRect)rect
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboard:didTouchEmojiItem:atRect:)]) {
        [self.delegate emojiKeyboard:self didTouchEmojiItem:emoji atRect:rect];
    }
}

- (void)emojiGroupDisplayViewDidStopLongPressEmoji:(TLEmojiGroupDisplayView *)displayView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardCancelTouchEmojiItem:)]) {
        [self.delegate emojiKeyboardCancelTouchEmojiItem:self];
    }
}


@end
