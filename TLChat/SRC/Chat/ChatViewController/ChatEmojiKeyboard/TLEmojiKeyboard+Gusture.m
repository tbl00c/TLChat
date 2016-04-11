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
static NSInteger lastIndex = -1;
- (void)longPressAction:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {        // 长按停止
        if (lastIndex != -1) {      // 取消选中状态
            id cell = [self.collectionView cellForItemAtIndexPath:[self p_getIndexPathOfIndex:lastIndex]];
            [cell setShowHighlightImage:NO];
        }
        lastIndex = -1;
        if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardCancelTouchEmojiItem:)]) {
            [self.delegate emojiKeyboardCancelTouchEmojiItem:self];
        }
    }
    else {
        CGPoint point = [sender locationInView:self.collectionView];
        // 获取point点的表情
        [self p_getEmojiItemAtPoint:point success:^(TLEmoji *emoji, NSInteger index) {
            if (lastIndex == index) {       // 与之前选中的Emoji一致，不回调，以免闪屏
                return ;
            }
            else if (lastIndex != -1) {     // 取消之前选中cell的高亮状态
                id cell = [self.collectionView cellForItemAtIndexPath:[self p_getIndexPathOfIndex:lastIndex]];
                [cell setShowHighlightImage:NO];
            }
            lastIndex = index;
            id cell = [self.collectionView cellForItemAtIndexPath:[self p_getIndexPathOfIndex:index]];
            [cell setShowHighlightImage:YES];
            if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboard:didTouchEmojiItem:atRect:)]) {
                //FIXME: emoji类型确定的方式太LOW！
                emoji.type = self.curGroup.type;
                CGRect rect = [cell frame];
                rect.origin.x = rect.origin.x - self.width * (int)(rect.origin.x / self.width);
                [self.delegate emojiKeyboard:self didTouchEmojiItem:emoji atRect:rect];
            }
            
        } failed:^{
            if (lastIndex != -1) {
                id cell = [self.collectionView cellForItemAtIndexPath:[self p_getIndexPathOfIndex:lastIndex]];
                [cell setShowHighlightImage:NO];
            }
            lastIndex = -1;
            if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboardCancelTouchEmojiItem:)]) {
                [self.delegate emojiKeyboardCancelTouchEmojiItem:self];
            }
        }];
    }
}

#pragma mark - Private Methods -
/**
 *  获取collectionView中某个点的Emoji
 *
 *  @param point   点
 *  @param success 在point点存在Emoji，在数据源中的位置
 *  @param failed  在point点不存在Emoji
 */
- (void)p_getEmojiItemAtPoint:(CGPoint)point
                      success:(void (^)(TLEmoji *, NSInteger))success
                       failed:(void (^)())failed
{
    NSInteger page = point.x / self.collectionView.width;
    point.x -= page * self.collectionView.width;
    if (point.x < headerReferenceSize.width || point.x > self.collectionView.width - footerReferenceSize.width || point.y < sectionInsets.top || point.y > self.collectionView.contentSize.height - sectionInsets.bottom) {
        failed();
    }
    else {
        point.x -= headerReferenceSize.width;
        point.y -= sectionInsets.top;
        NSInteger w = (self.collectionView.width - headerReferenceSize.width) / self.curGroup.colNumber;
        NSInteger h = (self.collectionView.height - sectionInsets.top) / self.curGroup.rowNumber;
        NSInteger x = point.x / w;
        NSInteger y = point.y / h;
        NSInteger index = page * self.curGroup.pageItemCount + y * self.curGroup.colNumber + x;
        
        if (index >= self.curGroup.count) {
            failed();
        }
        else {
            TLEmoji *emoji = [self.curGroup objectAtIndex:index];
            success(emoji, index);
        }
    }
}

- (NSIndexPath *)p_getIndexPathOfIndex:(NSInteger)index
{
    index = [self transformCellIndex:index];
    NSInteger row = index % self.curGroup.pageItemCount;
    NSInteger section = index / self.curGroup.pageItemCount;
    return [NSIndexPath indexPathForRow:row inSection:section];
}

@end
