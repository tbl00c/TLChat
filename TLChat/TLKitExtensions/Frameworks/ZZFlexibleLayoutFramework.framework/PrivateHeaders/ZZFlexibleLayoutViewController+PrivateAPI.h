//
//  ZZFlexibleLayoutViewController+PrivateAPI.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"

#define     CELL_SEPEARTOR          @"ZZFlexibleLayoutSeperatorCell"

void RegisterCollectionViewCell(UICollectionView *collectionView, NSString *cellName);
void RegisterCollectionViewReusableView(UICollectionView *collectionView, NSString *kind, NSString *viewName);

@class ZZFlexibleLayoutSectionModel;
@interface ZZFlexibleLayoutViewController (PrivateAPI)

@property (nonatomic, assign) BOOL isReloading;

- (ZZFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section;

/// 根据tag获取sectionModel
- (ZZFlexibleLayoutSectionModel *)sectionModelForTag:(NSInteger)sectionTag;

- (ZZFlexibleLayoutViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<ZZFlexibleLayoutViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
