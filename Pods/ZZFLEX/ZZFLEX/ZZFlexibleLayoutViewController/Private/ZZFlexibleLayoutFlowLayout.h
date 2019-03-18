//
//  ZZFlexibleLayoutFlowLayout.h
//  zhuanzhuan
//
//  Created by lbk on 2017/5/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 支持为section设计背景色
 */
@protocol ZZFlexibleLayoutFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

/// section背景色
- (UIColor *)collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     colorForSectionAtIndex:(NSInteger)section;

/// header是否悬浮
- (BOOL)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
didSectionHeaderPinToVisibleBounds:(NSInteger)section;

/// footer是否悬浮（暂未实现）
- (BOOL)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
didSectionFooterPinToVisibleBounds:(NSInteger)section;

@end


@interface ZZFlexibleLayoutFlowLayout : UICollectionViewFlowLayout

/// header悬浮偏移量，默认0
@property (nonatomic, assign) CGFloat headerVisibleBoundsOffset;

@end
