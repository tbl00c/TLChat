//
//  TLExpressionDetailViewController+CollectionView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailViewController.h"
#import "TLExpressionDetailCell.h"

@interface TLExpressionDetailViewController (CollectionView) <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TLExpressionDetailCellDelegate>

- (void)registerCellForCollectionView:(UICollectionView *)collectionView;

- (void)didLongPressScreen:(UILongPressGestureRecognizer *)sender;

- (void)didTap5TimesScreen:(UITapGestureRecognizer *)sender;


@end
