//
//  TLMoreKeyboard+CollectionViewDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMoreKeyboard+CollectionViewDelegate.h"
#import "TLMoreKeyboardCell.h"

@implementation TLMoreKeyboard (CollectionViewDelegate)

#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.collectionView registerClass:[TLMoreKeyboardCell class] forCellWithReuseIdentifier:@"TLMoreKeyboardCell"];
}

#pragma mark - Delegate -
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.chatMoreKeyboardData.count / 8 + (self.chatMoreKeyboardData.count % 8 == 0 ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLMoreKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLMoreKeyboardCell" forIndexPath:indexPath];
    NSUInteger index = indexPath.section * 8 + indexPath.row;
    NSUInteger tIndex = [self p_transformIndex:index];  // 矩阵坐标转置
    if (tIndex >= self.chatMoreKeyboardData.count) {
        [cell setItem:nil];
    }
    else {
        [cell setItem:self.chatMoreKeyboardData[tIndex]];
    }
    __weak typeof(self) weakSelf = self;
    [cell setClickBlock:^(TLMoreKeyboardItem *sItem) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(moreKeyboard:didSelectedFunctionItem:)]) {
            [self.delegate moreKeyboard:weakSelf didSelectedFunctionItem:sItem];
        }
    }];
    return cell;
}

//Mark: UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:(int)(scrollView.contentOffset.x / WIDTH_SCREEN)];
}

#pragma mark - Private Methods -
- (NSUInteger)p_transformIndex:(NSUInteger)index
{
    NSUInteger page = index / 8;
    index = index % 8;
    NSUInteger x = index / 2;
    NSUInteger y = index % 2;
    return 4 * y + x + page * 8;
}

@end
