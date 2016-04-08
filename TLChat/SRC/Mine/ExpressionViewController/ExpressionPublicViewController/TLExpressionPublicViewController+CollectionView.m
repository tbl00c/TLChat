//
//  TLExpressionPublicViewController+CollectionView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionPublicViewController+CollectionView.h"
#import "TLExpressionDetailViewController.h"
#import "TLExpressionPublicCell.h"

@implementation TLExpressionPublicViewController (CollectionView)

- (void)registerCellForCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[TLExpressionPublicCell class] forCellWithReuseIdentifier:@"TLExpressionPublicCell"];
}

#pragma mark - # Delegate -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLExpressionPublicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLExpressionPublicCell" forIndexPath:indexPath];
    TLEmojiGroup *emojiGroup = [self.data objectAtIndex:indexPath.row];
    [cell setGroup:emojiGroup];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLEmojiGroup *group = [self.data objectAtIndex:indexPath.row];
    TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] init];
    [detailVC setGroup:group];
    [self.parentViewController setHidesBottomBarWhenPushed:YES];
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

@end
