//
//  TLExpressionPublicViewController+CollectionView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionPublicViewController.h"

@interface TLExpressionPublicViewController (CollectionView) <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void)registerCellForCollectionView:(UICollectionView *)collectionView;

@end
