//
//  ZZCollectionViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZCollectionViewChainModel.h"

#define     ZZFLEX_CHAIN_COLLECTIONVIEW_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZCollectionViewChainModel *, UICollectionView)
#define     ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZCollectionViewChainModel *, UICollectionView)

@implementation ZZCollectionViewChainModel

ZZFLEX_CHAIN_COLLECTIONVIEW_IMPLEMENTATION(collectionViewLayout, UICollectionViewLayout *)
ZZFLEX_CHAIN_COLLECTIONVIEW_IMPLEMENTATION(delegate, id<UICollectionViewDelegate>)
ZZFLEX_CHAIN_COLLECTIONVIEW_IMPLEMENTATION(dataSource, id<UICollectionViewDataSource>)

ZZFLEX_CHAIN_COLLECTIONVIEW_IMPLEMENTATION(allowsSelection, BOOL)
ZZFLEX_CHAIN_COLLECTIONVIEW_IMPLEMENTATION(allowsMultipleSelection, BOOL)

#pragma mark - UIScrollView
ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentSize, CGSize)
ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentOffset, CGPoint)
ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(contentInset, UIEdgeInsets)

ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(bounces, BOOL)
ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceVertical, BOOL)
ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(alwaysBounceHorizontal, BOOL)

ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(pagingEnabled, BOOL)
ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollEnabled, BOOL)

ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsHorizontalScrollIndicator, BOOL)
ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(showsVerticalScrollIndicator, BOOL)

ZZFLEX_CHAIN_SCROLLVIEW_IMPLEMENTATION(scrollsToTop, BOOL)

@end

ZZFLEX_EX_IMPLEMENTATION(UICollectionView, ZZCollectionViewChainModel)
