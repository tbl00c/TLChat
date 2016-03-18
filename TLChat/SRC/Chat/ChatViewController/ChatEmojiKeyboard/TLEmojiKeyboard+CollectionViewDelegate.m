//
//  TLEmojiKeyboard+CollectionViewDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard+CollectionViewDelegate.h"
#import "TLEmojiKeyboard+CollectionViewDataSource.h"
#import "TLEmojiKeyboard+GroupControlDelegate.h"

@implementation TLEmojiKeyboard (CollectionViewDelegate)

#pragma mark - Public Methods -
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
    headerReferenceSize = CGSizeMake(hfSpace, HEIGHT_EMOJIVIEW);
    footerReferenceSize = CGSizeMake(hfSpace, HEIGHT_EMOJIVIEW);
    minimumLineSpacing = (WIDTH_SCREEN - hfSpace * 2 - cellWidth * self.curGroup.colNumber) / (self.curGroup.colNumber - 1);
    minimumInteritemSpacing = (HEIGHT_EMOJIVIEW - topSpace - btmSpace - cellHeight * self.curGroup.rowNumber) / (self.curGroup.rowNumber - 1);
    sectionInsets = UIEdgeInsetsMake(topSpace, 0, btmSpace, 0);
}


#pragma mark - Delegate -
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:(int)(scrollView.contentOffset.x / WIDTH_SCREEN)];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return headerReferenceSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return footerReferenceSize;
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

@end
