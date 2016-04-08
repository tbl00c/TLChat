//
//  TLExpressionDetailViewController+CollectionView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailViewController+CollectionView.h"
#import "TLExpressionDetailCell.h"

@implementation TLExpressionDetailViewController (CollectionView)

- (void)registerCellForCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[TLExpressionDetailCell class] forCellWithReuseIdentifier:@"TLExpressionDetailCell"];
}

#pragma mark - # Delegate -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLExpressionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLExpressionDetailCell" forIndexPath:indexPath];
    TLEmoji *emoji = [self.data objectAtIndex:indexPath.row];
    [cell setEmoji:emoji];
    return cell;
}

@end
