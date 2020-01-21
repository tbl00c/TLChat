//
//  ZZFlexibleLayoutViewModel+UICollectionView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel+UICollectionView.h"
#import "ZZFLEXMacros.h"

@implementation ZZFlexibleLayoutViewModel (UICollectionView)

- (UICollectionViewCell *)collectionViewCellForPageControler:(id)pageController
                                              collectionView:(UICollectionView *)collectionView
                                                sectionCount:(NSInteger)sectionCount
                                                   indexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell<ZZFlexibleLayoutViewProtocol> *cell;
    if (!self || !self.viewClass) {
        ZZFLEXLog(@"!!!!! CollectionViewCell不存在，将使用空白Cell：%@", self.className);
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZFlexibleLayoutSeperatorCell" forIndexPath:indexPath];
        [cell setTag:self.viewTag];
        return cell;
    }
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.className forIndexPath:indexPath];
    [self excuteConfigActionForPageControler:pageController hostView:collectionView itemView:cell sectionCount:sectionCount indexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionViewHeaderFooterViewForPageControler:(id)pageController
                                                              collectionView:(UICollectionView *)collectionView
                                                                        kind:(NSString *)kind
                                                                   indexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView<ZZFlexibleLayoutViewProtocol> *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:self.className forIndexPath:indexPath];
    [self excuteConfigActionForPageControler:pageController hostView:collectionView itemView:view sectionCount:indexPath.section indexPath:indexPath];
    return view;
}

@end
