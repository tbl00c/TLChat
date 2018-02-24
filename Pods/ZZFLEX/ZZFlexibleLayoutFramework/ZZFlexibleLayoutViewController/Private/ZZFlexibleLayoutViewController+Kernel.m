//
//  ZZFlexibleLayoutViewController+Kernel.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController+Kernel.h"
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
    ZZFlexibleLayoutViewModel *model = [sectionModel objectAtIndex:indexPath.row];
    
    UICollectionViewCell<ZZFlexibleLayoutViewProtocol> *cell;
    if (!model || !model.viewClass) {
        ZZFLEXLog(@"!!!!! CollectionViewCell不存在，将使用空白Cell：%@", model.className);
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_SEPEARTOR forIndexPath:indexPath];
        [cell setTag:model.viewTag];
        return cell;
    }
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:model.className forIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(setViewDataModel:)]) {
        [cell setViewDataModel:model.dataModel];
    }
    if ([cell respondsToSelector:@selector(setViewDelegate:)]) {
        [cell setViewDelegate:model.delegate ? model.delegate : self];
    }
    if ([cell respondsToSelector:@selector(setViewEventAction:)]) {
        [cell setViewEventAction:model.eventAction];
    }
    if ([cell respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
        [cell viewIndexPath:indexPath sectionItemCount:sectionModel.count];
    }
    [cell setTag:model.viewTag];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView<ZZFlexibleLayoutViewProtocol> *view = nil;
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if([kind isEqual:UICollectionElementKindSectionHeader]) {
        if (sectionModel.headerViewModel && sectionModel.headerViewModel.viewClass) {
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.headerViewModel.className forIndexPath:indexPath];

            if ([view respondsToSelector:@selector(setViewDataModel:)]) {
                [view setViewDataModel:sectionModel.headerViewModel.dataModel];
            }
            if ([view respondsToSelector:@selector(setViewEventAction:)]) {
                [view setViewEventAction:sectionModel.headerViewModel.eventAction];
            }
            if ([view respondsToSelector:@selector(setViewDelegate:)]) {
                [view setViewDelegate:sectionModel.headerViewModel.delegate ? sectionModel.headerViewModel.delegate : self];
            }
            [view setTag:sectionModel.headerViewModel.viewTag];
        }
    }
    else {
        if (sectionModel.footerViewModel && sectionModel.footerViewModel.viewClass) {
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.footerViewModel.className forIndexPath:indexPath];
    
            if ([view respondsToSelector:@selector(setViewDataModel:)]) {
                [view setViewDataModel:sectionModel.footerViewModel.dataModel];
            }
            if ([view respondsToSelector:@selector(setViewEventAction:)]) {
                [view setViewEventAction:sectionModel.headerViewModel.eventAction];
            }
            if ([view respondsToSelector:@selector(setViewDelegate:)]) {
                [view setViewDelegate:sectionModel.footerViewModel.delegate ? sectionModel.footerViewModel.delegate : self];
            }
            [view setTag:sectionModel.footerViewModel.viewTag];
        }
    }
    if (view) {
        if ([view respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
            [view viewIndexPath:indexPath sectionItemCount:sectionModel.count];
        }
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
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    if (viewModel.selectedAction) {
        viewModel.selectedAction(viewModel.dataModel);
    }
    if (indexPath.section < self.data.count && [self respondsToSelector:@selector(collectionViewDidSelectItem:sectionTag:cellTag:className:indexPath:)]) {
        [self collectionViewDidSelectItem:viewModel.dataModel sectionTag:sectionModel.sectionTag cellTag:viewModel.viewTag className:viewModel.className indexPath:indexPath];
    }
}

//MARK: ZZFlexibleLayoutFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutViewModel *model = [self viewModelAtIndexPath:indexPath];
    CGSize size = model ? model.viewSize : CGSizeZero;
    size.width = size.width < 0 ? collectionView.frame.size.width * -size.width : size.width;
    size.height = size.height < 0 ? collectionView.frame.size.height * -size.height : size.height;
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *model = sectionModel.headerViewModel;
    CGSize size = model ? model.viewSize : CGSizeZero;
    size.width = size.width < 0 ? collectionView.frame.size.width * -size.width : size.width;
    size.height = size.height < 0 ? collectionView.frame.size.height * -size.height : size.height;
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *model = sectionModel.footerViewModel;
    CGSize size = model ? model.viewSize : CGSizeZero;
    size.width = size.width < 0 ? collectionView.frame.size.width * -size.width : size.width;
    size.height = size.height < 0 ? collectionView.frame.size.height * -size.height : size.height;
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
    return sectionModel.backgroundColor ? sectionModel.backgroundColor : self.collectionView.backgroundColor;
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
