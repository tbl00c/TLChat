//
//  ZZFlexibleLayoutViewController+Kernel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFlexibleLayoutViewController+Kernel.h"
#import "ZZFlexibleLayoutViewModel+UICollectionView.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFLEXMacros.h"

/*
 *  注册cells 到 UICollectionView
 */
void RegisterCollectionViewCell(UICollectionView *collectionView, NSString *cellName)
{
    [collectionView registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
}

/*
 *  注册ReusableView 到 UICollectionView
 */
void RegisterCollectionViewReusableView(UICollectionView *collectionView, NSString *kind, NSString *viewName)
{
    [collectionView registerClass:NSClassFromString(viewName) forSupplementaryViewOfKind:kind withReuseIdentifier:viewName];
}

@implementation ZZFlexibleLayoutViewController (Kernel)

#pragma mark - # Kernal
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return [sectionModel count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:indexPath.row];
    UICollectionViewCell *cell = [viewModel collectionViewCellForPageControler:self collectionView:collectionView sectionCount:sectionModel.count indexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = nil;
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFlexibleLayoutViewModel *viewModel = [kind isEqual:UICollectionElementKindSectionHeader] ? sectionModel.headerViewModel : sectionModel.footerViewModel;
    if (viewModel) {
        view = [viewModel collectionViewHeaderFooterViewForPageControler:self collectionView:collectionView kind:kind indexPath:indexPath];
    }
    else {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZZFlexibleLayoutEmptyHeaderFooterView" forIndexPath:indexPath];
    }
    
    return view;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    [viewModel excuteSelectedActionForHostView:collectionView];
    
    if (indexPath.section < self.data.count && [self respondsToSelector:@selector(collectionViewDidSelectItem:sectionTag:cellTag:className:indexPath:)]) {
        ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
        [self collectionViewDidSelectItem:viewModel.dataModel sectionTag:sectionModel.sectionTag cellTag:viewModel.viewTag className:viewModel.className indexPath:indexPath];
    }
}

//MARK: ZZFlexibleLayoutFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    CGSize size = [viewModel visableSizeForHostView:collectionView];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *viewModel = sectionModel.headerViewModel;
    CGSize size = [viewModel visableSizeForHostView:collectionView];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *viewModel = sectionModel.footerViewModel;
    CGSize size = [viewModel visableSizeForHostView:collectionView];
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.sectionInsets;
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout colorForSectionAtIndex:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.backgroundColor ? sectionModel.backgroundColor : collectionView.backgroundColor;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionHeaderPinToVisibleBounds:(NSInteger)section
{
    if (self.sectionHeadersPinToVisibleBounds) {
        return YES;
    }
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionFooterPinToVisibleBounds:(NSInteger)section
{
    if (self.sectionFootersPinToVisibleBounds) {
        return YES;
    }
    return NO;
}

#pragma mark - # Private API
- (ZZFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section
{
    return section < self.data.count ? self.data[section] : nil;
}

- (ZZFlexibleLayoutSectionModel *)sectionModelForTag:(NSInteger)sectionTag
{
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if (sectionModel.sectionTag == sectionTag) {
            return sectionModel;
        }
    }
    return nil;
}

- (ZZFlexibleLayoutViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath) {
        return nil;
    }
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    return [sectionModel objectAtIndex:indexPath.row];
}

- (NSArray<ZZFlexibleLayoutViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in indexPaths) {
        ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
        if (viewModel) {
            [data addObject:viewModel];
        }
    }
    return data;
}

@end
