//
//  ZZCollectionViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZCollectionViewChainModel;
@interface ZZCollectionViewChainModel : ZZBaseViewChainModel<ZZCollectionViewChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ collectionViewLayout)(UICollectionViewLayout *collectionViewLayout);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ delegate)(id<UICollectionViewDelegate> delegate);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ dataSource)(id<UICollectionViewDataSource> dataSource);

ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ allowsSelection)(BOOL allowsSelection);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ allowsMultipleSelection)(BOOL allowsMultipleSelection);

#pragma mark - UIScrollView
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ contentSize)(CGSize contentSize);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ contentOffset)(CGPoint contentOffset);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ contentInset)(UIEdgeInsets contentInset);

ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ bounces)(BOOL bounces);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ pagingEnabled)(BOOL pagingEnabled);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ scrollEnabled)(BOOL scrollEnabled);

ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

ZZFLEX_CHAIN_PROPERTY ZZCollectionViewChainModel *(^ scrollsToTop)(BOOL scrollsToTop);

@end

ZZFLEX_EX_INTERFACE(UICollectionView, ZZCollectionViewChainModel)
