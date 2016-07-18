//
//  TLEmojiKeyboard+CollectionView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard+CollectionView.h"
#import "TLEmojiKeyboard+EmojiGroupControl.h"

@implementation TLEmojiKeyboard (CollectionView)

#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.collectionView registerClass:[TLEmojiItemCell class] forCellWithReuseIdentifier:@"TLEmojiItemCell"];
    [self.collectionView registerClass:[TLEmojiFaceItemCell class] forCellWithReuseIdentifier:@"TLEmojiFaceItemCell"];
    [self.collectionView registerClass:[TLEmojiImageItemCell class] forCellWithReuseIdentifier:@"TLEmojiImageItemCell"];
    [self.collectionView registerClass:[TLEmojiImageTitleItemCell class] forCellWithReuseIdentifier:@"TLEmojiImageTitleItemCell"];
}

/**
 *  转换index
 *
 *  @param index collectionView中的Index
 *
 *  @return model中的Index
 */
- (NSUInteger)transformModelIndex:(NSInteger)index
{
    NSUInteger page = index / self.curGroup.pageItemCount;
    index = index % self.curGroup.pageItemCount;
    NSUInteger x = index / self.curGroup.rowNumber;
    NSUInteger y = index % self.curGroup.rowNumber;
    return self.curGroup.colNumber * y + x + page * self.curGroup.pageItemCount;
}

- (NSUInteger)transformCellIndex:(NSInteger)index
{
    NSUInteger page = index / self.curGroup.pageItemCount;
    index = index % self.curGroup.pageItemCount;
    NSUInteger x = index / self.curGroup.colNumber;
    NSUInteger y = index % self.curGroup.colNumber;
    return self.curGroup.rowNumber * y + x + page * self.curGroup.pageItemCount;
}

- (void)resetCollectionSize
{
    float cellHeight;
    float cellWidth;
    float topSpace = 0;
    float btmSpace = 0;
    float hfSpace = 0;
    if (self.curGroup.type == TLEmojiTypeFace || self.curGroup.type == TLEmojiTypeEmoji) {
        cellWidth = cellHeight = (HEIGHT_EMOJIVIEW / self.curGroup.rowNumber) * 0.55;
        topSpace = 11;
        btmSpace = 19;
        hfSpace = (WIDTH_SCREEN - cellWidth * self.curGroup.colNumber) / (self.curGroup.colNumber + 1) * 1.4;
    }
    else if (self.curGroup.type == TLEmojiTypeImageWithTitle){
        cellHeight = (HEIGHT_EMOJIVIEW / self.curGroup.rowNumber) * 0.96;
        cellWidth = cellHeight * 0.8;
        hfSpace = (WIDTH_SCREEN - cellWidth * self.curGroup.colNumber) / (self.curGroup.colNumber + 1) * 1.2;
    }
    else {
        cellWidth = cellHeight = (HEIGHT_EMOJIVIEW / self.curGroup.rowNumber) * 0.72;
        topSpace = 8;
        btmSpace = 16;
        hfSpace = (WIDTH_SCREEN - cellWidth * self.curGroup.colNumber) / (self.curGroup.colNumber + 1) * 1.2;
    }
    
    cellSize = CGSizeMake(cellWidth, cellHeight);
    minimumLineSpacing = (WIDTH_SCREEN - hfSpace * 2 - cellWidth * self.curGroup.colNumber) / (self.curGroup.colNumber - 1);
    minimumInteritemSpacing = (HEIGHT_EMOJIVIEW - topSpace - btmSpace - cellHeight * self.curGroup.rowNumber) / (self.curGroup.rowNumber - 1);
    sectionInsets = UIEdgeInsetsMake(topSpace, hfSpace, btmSpace, hfSpace);
}

#pragma mark - Delegate -
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.curGroup.pageNumber;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.curGroup.pageItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.section * self.curGroup.pageItemCount + indexPath.row;
    TLEmojiBaseCell *cell;
    if (self.curGroup.type == TLEmojiTypeEmoji) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiItemCell" forIndexPath:indexPath];
    }
    else if (self.curGroup.type == TLEmojiTypeFace) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiFaceItemCell" forIndexPath:indexPath];
    }
    else if (self.curGroup.type == TLEmojiTypeImageWithTitle) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiImageTitleItemCell" forIndexPath:indexPath];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiImageItemCell" forIndexPath:indexPath];
    }
    NSUInteger tIndex = [self transformModelIndex:index];  // 矩阵坐标转置
    TLEmoji *emojiItem = self.curGroup.count > tIndex ? [self.curGroup objectAtIndex:tIndex] : nil;
    [cell setEmojiItem:emojiItem];
    return cell;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.section * self.curGroup.pageItemCount + indexPath.row;
    NSUInteger tIndex = [self transformModelIndex:index];  // 矩阵坐标转置
    if (tIndex < self.curGroup.count) {
        TLEmoji *item = [self.curGroup objectAtIndex:tIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(emojiKeyboard:didSelectedEmojiItem:)]) {
            //FIXME: 表情类型
            item.type = self.curGroup.type;
            [self.delegate emojiKeyboard:self didSelectedEmojiItem:item];
        }
    }
    [self updateSendButtonStatus];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return sectionInsets;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:(int)(scrollView.contentOffset.x / WIDTH_SCREEN)];
}

@end
