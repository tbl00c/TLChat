//
//  TLChatBackgroundSelectViewController+CollectionView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBackgroundSelectViewController.h"

@interface TLChatBackgroundSelectViewController (CollectionView) <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (void)registerCellForCollectionView:(UICollectionView *)collectionView;

@end
