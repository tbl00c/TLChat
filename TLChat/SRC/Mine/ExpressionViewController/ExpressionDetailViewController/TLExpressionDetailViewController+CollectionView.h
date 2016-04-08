//
//  TLExpressionDetailViewController+CollectionView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailViewController.h"

@interface TLExpressionDetailViewController (CollectionView) <UICollectionViewDelegate, UICollectionViewDataSource>

- (void)registerCellForCollectionView:(UICollectionView *)collectionView;

@end
