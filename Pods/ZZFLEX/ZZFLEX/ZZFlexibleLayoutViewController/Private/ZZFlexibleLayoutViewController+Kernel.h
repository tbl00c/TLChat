//
//  ZZFlexibleLayoutViewController+Kernel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFlexibleLayoutFlowLayout.h"
#import "ZZFlexibleLayoutViewModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

#define     CELL_SEPEARTOR          @"ZZFlexibleLayoutSeperatorCell"

void RegisterCollectionViewCell(UICollectionView *collectionView, NSString *cellName);
void RegisterCollectionViewReusableView(UICollectionView *collectionView, NSString *kind, NSString *viewName);

@class ZZFlexibleLayoutSectionModel;
@interface ZZFlexibleLayoutViewController (Kernel) <
UICollectionViewDataSource,
UICollectionViewDelegate,
ZZFlexibleLayoutFlowLayoutDelegate
>

- (ZZFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section;

/// 根据tag获取sectionModel
- (ZZFlexibleLayoutSectionModel *)sectionModelForTag:(NSInteger)sectionTag;

- (ZZFlexibleLayoutViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<ZZFlexibleLayoutViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
