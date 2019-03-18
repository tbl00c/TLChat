//
//  ZZFlexibleLayoutViewController+OldAPI.m
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFlexibleLayoutViewController+OldAPI.h"
#import "ZZFlexibleLayoutViewController+Kernel.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutSeperatorCell.h"
#import "ZZFLEXMacros.h"

@implementation ZZFlexibleLayoutViewController (OldAPI)

- (BOOL)deleteAllItems
{
    [self.data removeAllObjects];
    return YES;
}

#pragma mark - # section 操作
- (NSInteger)addSectionWithTag:(NSInteger)tag
{
    return [self addSectionWithTag:tag minimumLineSpacing:0];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumLineSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:sectionInsets];
}


- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumInteritemSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:sectionInsets backgroundColor:nil];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumLineSpacing:0 backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:minimumLineSpacing backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumLineSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:sectionInsets backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    if ([self hasSection:tag]) {
        ZZFLEXLog(@"!!!!! 重复添加Section：%ld", (long)tag);
    }
    ZZFlexibleLayoutSectionModel *sectionModel = [[ZZFlexibleLayoutSectionModel alloc] init];
    sectionModel.sectionTag = tag;
    sectionModel.minimumInteritemSpacing = minimumInteritemSpacing;
    sectionModel.minimumLineSpacing = minimumLineSpacing;
    sectionModel.sectionInsets = sectionInsets;
    sectionModel.backgroundColor = backgroundColor;
    [self.data addObject:sectionModel];
    return self.data.count - 1;
}

- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index
{
    return [self insertSectionWithTag:tag toIndex:index minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:UIEdgeInsetsMake(0, 0, 0, 0) backgroundColor:nil];
}

- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    if ([self hasSection:tag]) {
        ZZFLEXLog(@"!!!!! 重复添加Section：%ld", (long)tag);
    }
    if (index > self.data.count) {
        ZZFLEXLog(@"!!!!! 插入section：index越界");
        return -1;
    }
    ZZFlexibleLayoutSectionModel *sectionModel = [[ZZFlexibleLayoutSectionModel alloc] init];
    sectionModel.sectionTag = tag;
    sectionModel.minimumInteritemSpacing = minimumInteritemSpacing;
    sectionModel.minimumLineSpacing = minimumLineSpacing;
    sectionModel.sectionInsets = sectionInsets;
    sectionModel.backgroundColor = backgroundColor;
    [self.data insertObject:sectionModel atIndex:index];
    return index;
}

- (BOOL)hasSection:(NSInteger)tag
{
    return [self sectionModelForTag:tag] ? YES : NO;
}

- (BOOL)deleteSection:(NSInteger)tag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        [self.data removeObject:sectionModel];
        return YES;
    }
    return NO;
}

#pragma mark - # Header Footer
- (BOOL)setSectionHeaderViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, className);
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model];
        sectionModel.headerViewModel = viewModel;
        return YES;
    }
    ZZFLEXLog(@"!!!!! section不存在: %ld", (long)sectionTag);
    return NO;
}

- (id)dataModelForSectionHeader:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return sectionModel.headerViewModel.dataModel;
}

- (BOOL)setSectionFooterViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, className);
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model];
        sectionModel.footerViewModel = viewModel;
        return YES;
    }
    ZZFLEXLog(@"!!!!! section不存在: %ld", (long)sectionTag);
    return NO;
}

- (id)dataModelForSectionFooter:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return sectionModel.footerViewModel.dataModel;
}

#pragma mark - # Cell 操作
/// 为指定section添加cell
- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    return [self addCellWithModel:model forSection:sectionTag className:className tag:TAG_CELL_NONE];
}

- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag
{
    NSArray *indexPaths = [self addCellsWithModelArray:@[(model ? model : [NSNull null])] forSection:sectionTag className:className tag:tag];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

/// 为指定section批量添加cell
- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className
{
    return [self addCellsWithModelArray:modelArray forSection:sectionTag className:className tag:TAG_CELL_NONE];
}

- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        return [self p_addCellsWithModelArray:modelArray forSection:sectionModel className:className tag:tag];
    }
    [self addSectionWithTag:sectionTag];
    return [self addCellsWithModelArray:modelArray forSection:sectionTag className:className tag:tag];
}

- (NSArray<NSIndexPath *> *)p_addCellsWithModelArray:(NSArray *)modelArray forSection:(ZZFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className tag:(NSInteger)tag
{
    RegisterCollectionViewCell(self.collectionView, className);
    if (modelArray.count == 0 || !sectionModel) {
        return nil;
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger section = [self.data indexOfObject:sectionModel];
    NSInteger row = sectionModel.itemsArray.count;
    for (id model in modelArray) {
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model viewTag:tag];
        [sectionModel addObject:viewModel];
        [indexPaths addObject:[NSIndexPath indexPathForItem:row++ inSection:section]];
    }
    return indexPaths.count > 0 ? indexPaths : nil;
}

/// 为指定section插入cell（失败返回nil）
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos
{
    return [self insertCellWithModel:model forSection:sectionTag className:className tag:TAG_CELL_NONE pos:pos];
}

- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    NSArray *indexPaths = [self insertCellsWithModelArray:@[(model ? model : [NSNull null])] forSection:sectionTag className:className tag:tag pos:pos];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

/// 为指定section批量添加
- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos
{
    return [self insertCellsWithModelArray:modelArray forSection:sectionTag className:className tag:TAG_CELL_NONE pos:pos];
}

- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel && pos <= sectionModel.itemsArray.count) {
        return [self p_insertCellsWithModelArray:modelArray forSection:sectionModel className:className tag:tag pos:pos];
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)p_insertCellsWithModelArray:(NSArray *)modelArray forSection:(ZZFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    RegisterCollectionViewCell(self.collectionView, className);
    if (modelArray.count == 0 || !sectionModel) {
        return nil;
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger section = [self.data indexOfObject:sectionModel];
    if (pos <= sectionModel.count) {
        for (id model in modelArray) {
            ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model viewTag:tag];
            [sectionModel insertObject:viewModel atIndex:pos];
            [indexPaths addObject:[NSIndexPath indexPathForItem:pos++ inSection:section]];
        }
        return indexPaths.count > 0 ? indexPaths : nil;
    }
    return nil;
}

/// 根据indexPath删除cell
- (BOOL)deleteCellAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel && sectionModel.count > indexPath.row) {
        [sectionModel removeObjectAtIndex:indexPath.row];
        return YES;
    }
    return NO;
}

- (BOOL)deleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    if (indexPaths.count > 0) {
        BOOL ok = NO;
        NSArray *deleteModels = [self viewModelsAtIndexPaths:indexPaths];
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
            NSArray *items = [sectionModel.itemsArray copy];
            for (ZZFlexibleLayoutViewModel *viewModel in items) {
                if ([deleteModels containsObject:viewModel]) {
                    [sectionModel removeObject:viewModel];
                    ok = YES;
                }
            }
        }
        return ok;
    }
    return NO;
}

/// 根据cellTag删除cell
- (BOOL)deleteCellByCellTag:(NSInteger)tag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForCellTag:tag];
    if (indexPaths.count > 0) {
        return [self deleteCellAtIndexPath:indexPaths[0]];
    }
    return NO;
}

- (BOOL)deleteCellForSection:(NSInteger)sectionTag tag:(NSInteger)tag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:tag];
    if (indexPaths.count > 0) {
        return [self deleteCellAtIndexPath:indexPaths[0]];
    }
    return NO;
}

/// 根据cellTag批量删除cell
- (BOOL)deleteAllCellsByCellTag:(NSInteger)tag
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:tag];
    return [self deleteCellsAtIndexPaths:indexPaths];
}

- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag tag:(NSInteger)tag
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:tag];
    return [self deleteCellsAtIndexPaths:indexPaths];
}

/// 根据数据源删除cell
- (BOOL)deleteCellByModel:(id)model
{
    BOOL ok = NO;
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if ([self p_deleteCellForSection:sectionModel model:model deleteAll:NO]) {
            return YES;
        }
    }
    return ok;
}

- (BOOL)deleteCellForSection:(NSInteger)sectionTag model:(id)model
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel model:model deleteAll:NO];
}

/// 根据数据源删除找到的所有cell
- (BOOL)deleteAllCellsByModel:(id)model
{
    BOOL ok = NO;
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if ([self p_deleteCellForSection:sectionModel model:model deleteAll:YES]) {
            return YES;
        }
    }
    return ok;
}

- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag model:(id)model
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel model:model deleteAll:YES];
}

- (BOOL)p_deleteCellForSection:(ZZFlexibleLayoutSectionModel *)sectionModel model:(id)model deleteAll:(BOOL)all
{
    BOOL ok = NO;
    if (sectionModel) {
        NSArray *data = sectionModel.itemsArray.mutableCopy;
        for (ZZFlexibleLayoutViewModel *viewMdoel in data) {
            if (viewMdoel.dataModel == model) {
                [sectionModel removeObject:viewMdoel];
                ok = YES;
                if (!all) {
                    break;
                }
            }
        }
    }
    return ok;
}

/// 根据类名删除cell
- (BOOL)deleteCellsByClassName:(NSString *)className
{
    BOOL ok = NO;
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if ([self p_deleteCellForSection:sectionModel className:className]) {
            ok = YES;
        }
    }
    return ok;
}

- (BOOL)deleteCellsForSection:(NSInteger)sectionTag className:(NSString *)className
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel className:className];
}

- (BOOL)p_deleteCellForSection:(ZZFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className
{
    BOOL ok = NO;
    if (sectionModel) {
        NSArray *data = sectionModel.itemsArray.mutableCopy;
        for (ZZFlexibleLayoutViewModel *viewMdoel in data) {
            if ([viewMdoel.className isEqualToString:className]) {
                [sectionModel removeObject:viewMdoel];
                ok = YES;
            }
        }
    }
    return ok;
}

- (void)updateSectionForTag:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    [sectionModel.headerViewModel updateViewHeight];
    [sectionModel.footerViewModel updateViewHeight];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        [viewModel updateViewHeight];
    }
}

- (void)updateCellsForCellTag:(NSInteger)cellTag
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:cellTag];
    [self updateCellsAtIndexPaths:indexPaths];
}

- (void)updateCellsForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    [self updateCellsAtIndexPaths:indexPaths];
}

- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath) {
        [self updateCellsAtIndexPaths:@[indexPath]];
    }
}

- (void)updateCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSArray<ZZFlexibleLayoutViewModel *> *viewModels = [self viewModelsAtIndexPaths:indexPaths];
    for (ZZFlexibleLayoutViewModel *viewModel in viewModels) {
        [viewModel updateViewHeight];
    }
}

/// 是否存在cell
- (BOOL)hasCell:(NSInteger)tag
{
    return [self cellIndexPathForCellTag:tag].count > 0;
}

- (BOOL)hasCellWithDataModel:(id)dataModel
{
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
            if (viewModel == dataModel) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)hasCellAtSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    return [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag].count > 0;
}

- (BOOL)hasCellAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel && sectionModel.count > indexPath.row) {
        return YES;
    }
    return NO;
}

- (NSArray<NSIndexPath *> *)cellIndexPathForCellTag:(NSInteger)cellTag
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (int section = 0; section < self.data.count; section++) {
        ZZFlexibleLayoutSectionModel *sectionModel = self.data[section];
        for (int row = 0; row < sectionModel.itemsArray.count; row++) {
            ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:row];
            if (viewModel.viewTag == cellTag) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
                [data addObject:indexPath];
            }
        }
    }
    return data.count > 0 ? data : nil;
}

- (NSArray<NSIndexPath *> *)cellIndexPathForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSInteger sectionIndex = [self sectionIndexForTag:sectionTag];
    ZZFlexibleLayoutSectionModel *sectionModel = self.data[sectionIndex];
    for (int row = 0; row < sectionModel.itemsArray.count; row++) {
        ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:row];
        if (viewModel.viewTag == cellTag) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:sectionIndex];
            [data addObject:indexPath];
        }
    }
    return data.count > 0 ? data : nil;
}


#pragma mark 数据操作
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    return viewModel ? viewModel.dataModel : nil;
}

- (id)dataModelForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    if (indexPaths.count > 0) {
        return [self dataModelAtIndexPath:indexPaths[0]];
    }
    return nil;
}

- (id)dataModelForSection:(NSInteger)sectionTag className:(NSString *)className
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        if ([viewModel.className isEqualToString:className]) {
            return viewModel.dataModel;
        }
    }
    return nil;
}

- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        [data addObject:viewModel.dataModel];
    }
    return data;
}

- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        if (viewModel.viewTag == cellTag) {
            [data addObject:viewModel.dataModel];
        }
    }
    return data;
}

- (NSArray *)allDataModelArray
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        NSMutableArray *sectionData = [[NSMutableArray alloc] init];
        for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
            [sectionData addObject:viewModel.dataModel];
        }
        [data addObject:sectionData];
    }
    return data;
}


@end

#pragma mark - ## ZZFlexibleLayoutViewController (OldSeperatorAPI)
@implementation ZZFlexibleLayoutViewController (OldSeperatorAPI)

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag
{
    return [self addSeperatorCellForSection:sectionTag withSize:DEFAULT_SEPERATOR_SIZE];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size
{
    return [self addSeperatorCellForSection:sectionTag withSize:size andColor:DEFAULT_SEPERATOR_COLOR];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withColor:(UIColor *)color
{
    return [self addSeperatorCellForSection:sectionTag withSize:DEFAULT_SEPERATOR_SIZE andColor:color];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size andColor:(UIColor *)color
{
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if (sectionModel.sectionTag == sectionTag) {
            return [self p_addSeperatorCellForSection:sectionModel withSize:size andColor:color];
        }
    }
    [self addSectionWithTag:sectionTag];
    return [self addSeperatorCellForSection:sectionTag withSize:size andColor:color];
}

#pragma mark - # Private Methods
- (NSIndexPath *)p_addSeperatorCellForSection:(ZZFlexibleLayoutSectionModel *)section withSize:(CGSize)size andColor:(UIColor *)color
{
    ZZFlexibleLayoutSeperatorModel *model = [[ZZFlexibleLayoutSeperatorModel alloc] initWithSize:size andColor:color];
    NSArray *indexPaths = [self p_addCellsWithModelArray:@[model] forSection:section className:CELL_SEPEARTOR tag:TAG_CELL_SEPERATOR];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

@end

