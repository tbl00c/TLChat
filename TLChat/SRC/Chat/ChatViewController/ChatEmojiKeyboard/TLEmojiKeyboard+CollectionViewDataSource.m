//
//  TLEmojiKeyboard+CollectionViewDataSource.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard+CollectionViewDataSource.h"

@implementation TLEmojiKeyboard (CollectionViewDataSource)

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

@end
