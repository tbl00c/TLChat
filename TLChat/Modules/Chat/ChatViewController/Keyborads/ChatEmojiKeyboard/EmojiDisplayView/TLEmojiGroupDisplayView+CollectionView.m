//
//  TLEmojiGroupDisplayView+CollectionView.m
//  TLChat
//
//  Created by 李伯坤 on 16/9/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiGroupDisplayView+CollectionView.h"
#import "TLEmojiFaceItemCell.h"
#import "TLEmojiImageItemCell.h"
#import "TLEmojiImageTitleItemCell.h"

@implementation TLEmojiGroupDisplayView (CollectionView)

- (void)registerCellClass
{
    [self.collectionView registerClass:[TLEmojiFaceItemCell class] forCellWithReuseIdentifier:@"TLEmojiFaceItemCell"];
    [self.collectionView registerClass:[TLEmojiImageItemCell class] forCellWithReuseIdentifier:@"TLEmojiImageItemCell"];
    [self.collectionView registerClass:[TLEmojiImageTitleItemCell class] forCellWithReuseIdentifier:@"TLEmojiImageTitleItemCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

- (NSUInteger)transformModelByRowCount:(NSInteger)rowCount colCount:(NSInteger)colCount andIndex:(NSInteger)index
{
    NSUInteger x = index / rowCount;
    NSUInteger y = index % rowCount;
    return colCount * y + x;
}

#pragma mark - # Delegate
//MARK: UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.displayData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    TLEmojiGroupDisplayModel *group = self.displayData[section];
    return group.pageItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLEmojiGroupDisplayModel *group = self.displayData[indexPath.section];
    NSInteger index = [self transformModelByRowCount:group.rowNumber colCount:group.colNumber andIndex:indexPath.row];
    TLExpressionModel *emoji = [group objectAtIndex:index];
    TLEmojiBaseCell *cell;
    if (group.type == TLEmojiTypeEmoji || group.type == TLEmojiTypeFace) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiFaceItemCell" forIndexPath:indexPath];
    }
    else if (group.type == TLEmojiTypeImageWithTitle) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiImageTitleItemCell" forIndexPath:indexPath];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiImageItemCell" forIndexPath:indexPath];
    }
    [cell setEmojiItem:emoji];
    return cell;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLEmojiGroupDisplayModel *group = self.displayData[indexPath.section];
    NSInteger index = [self transformModelByRowCount:group.rowNumber colCount:group.colNumber andIndex:indexPath.row];
    TLExpressionModel *emoji = [group objectAtIndex:index];
    if (emoji) {
        if ([emoji.eId isEqualToString:@"-1"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(emojiGroupDisplayViewDeleteButtonPressed:)]) {
                [self.delegate emojiGroupDisplayViewDeleteButtonPressed:self];
            }
        }
        else if (self.delegate && [self.delegate respondsToSelector:@selector(emojiGroupDisplayView:didClickedEmoji:)]) {
            //FIXME: 表情类型
            emoji.type = group.type;
            [self.delegate emojiGroupDisplayView:self didClickedEmoji:emoji];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLEmojiGroupDisplayModel *group = self.displayData[indexPath.section];
    return group.cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    TLEmojiGroupDisplayModel *group = self.displayData[section];
    return group.sectionInsets;
}

//MARK: UIScrollViewDelegate
static float lastX = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = (scrollView.contentOffset.x + 2.0) / scrollView.width;
    if (scrollView.contentOffset.x < lastX) {       // 右滑坐标修复
        page += (scrollView.contentOffset.x - scrollView.width * page > 3.0) ? 1 : 0;
    }
    lastX = scrollView.contentOffset.x;
    
    if (self.curPageIndex != page) {
        self.curPageIndex = page;
        if (page >= 0 && page < self.displayData.count && self.delegate && [self.delegate respondsToSelector:@selector(emojiGroupDisplayView:didScrollToPageIndex:forGroupIndex:)]) {
            TLEmojiGroupDisplayModel *group = self.displayData[page];
            [self.delegate emojiGroupDisplayView:self didScrollToPageIndex:group.pageIndex forGroupIndex:group.emojiGroupIndex];
        }
    }
}

@end
