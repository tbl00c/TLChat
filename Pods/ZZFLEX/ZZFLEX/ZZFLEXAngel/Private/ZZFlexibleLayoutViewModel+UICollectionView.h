//
//  ZZFlexibleLayoutViewModel+UICollectionView.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel+HostView.h"

@interface ZZFlexibleLayoutViewModel (UICollectionView)

- (UICollectionViewCell *)collectionViewCellForPageControler:(id)pageController
                                              collectionView:(UICollectionView *)collectionView
                                                sectionCount:(NSInteger)sectionCount
                                                   indexPath:(NSIndexPath *)indexPath;

- (UICollectionReusableView *)collectionViewHeaderFooterViewForPageControler:(id)pageController
                                                              collectionView:(UICollectionView *)collectionView
                                                                        kind:(NSString *)kind
                                                                   indexPath:(NSIndexPath *)indexPath;

@end
