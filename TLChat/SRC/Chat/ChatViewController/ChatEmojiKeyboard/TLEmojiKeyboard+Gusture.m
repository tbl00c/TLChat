//
//  TLEmojiKeyboard+Gusture.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard+Gusture.h"
#import "TLEmojiKeyboard+CollectionViewDataSource.h"

@implementation TLEmojiKeyboard (Gusture)

#pragma mark - Public Methods -
- (void)addGusture
{
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPressGR];
}

#pragma mark - Event Response -
static UICollectionViewCell *lastCell;
- (void)longPressAction:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {        // 长按停止
        lastCell = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardCancelTouchEmojiItem:)]) {
            [self.delegate emojiKeyboardCancelTouchEmojiItem:self];
        }
    }
    else {
        CGPoint point = [sender locationInView:self.collectionView];
        
        for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
            if (cell.x - minimumLineSpacing / 2.0 <= point.x && cell.y - minimumInteritemSpacing / 2.0 <= point.y && cell.x + cell.width + minimumLineSpacing / 2.0 >= point.x && cell.y + cell.height + minimumInteritemSpacing / 2.0 >= point.y) {
                if (lastCell == cell) {
                    return;
                }
                lastCell = cell;
                NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
                NSUInteger index = indexPath.section * self.curGroup.pageItemCount + indexPath.row;
                NSUInteger tIndex = [self transformModelIndex:index];  // 矩阵坐标转置
                if (tIndex >= self.curGroup.count) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardCancelTouchEmojiItem:)]) {
                        [self.delegate emojiKeyboardCancelTouchEmojiItem:self];
                    }
                    return;
                }
                TLEmoji *emoji = [self.curGroup objectAtIndex:tIndex];
                if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboard:didTouchEmojiItem:atRect:)]) {
                    emoji.type = self.curGroup.type;
                    CGRect rect = [cell frame];
                    rect.origin.x = rect.origin.x - self.width * (int)(rect.origin.x / self.width);
                    [self.delegate emojiKeyboard:self didTouchEmojiItem:emoji atRect:rect];
                }
                return;
            }
        }
        
        lastCell = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardCancelTouchEmojiItem:)]) {
            [self.delegate emojiKeyboardCancelTouchEmojiItem:self];
        }
    }
}

@end
