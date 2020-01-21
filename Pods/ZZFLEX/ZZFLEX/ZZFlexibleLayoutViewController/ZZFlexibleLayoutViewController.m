//
//  ZZFlexibleLayoutViewController.m
//  zhuanzhuan
//
//  Created by lbk on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFlexibleLayoutViewController+Kernel.h"
#import "ZZFLEXMacros.h"
#import "UIView+ZZFLEX.h"

#define     ZZFLEXVC_ANGEL_CHAIN_METHOD(methodName, returnType, paramType)  \
- (returnType (^)(paramType))methodName \
{   \
    return self.angel.methodName;   \
}

#define     ZZFLEXVC_ANGEL_METHOD(methodName, returnType)  \
- (returnType)methodName \
{   \
    return [self.angel methodName];   \
}

@implementation ZZFlexibleLayoutViewController

- (id)init
{
    if (self = [super init]) {
        _scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = UICollectionView.zz_create(1).backgroundColor([UIColor clearColor]).showsHorizontalScrollIndicator(NO).alwaysBounceVertical(YES).view;
        _angel = [[ZZFLEXAngel alloc] initWithHostView:_collectionView];
        [self.collectionView setDataSource:self];
        [self.collectionView setDelegate:self];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.collectionView setFrame:self.view.bounds];
    [self.view addSubview:self.collectionView];
}

- (void)dealloc
{
    ZZFLEXLog(@"Dealloc: %@", NSStringFromClass([self class]));
}

#pragma mark - # Setter
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    [(ZZFlexibleLayoutFlowLayout *)self.collectionView.collectionViewLayout setScrollDirection:scrollDirection];
}

#pragma mark 页面刷新
/// 刷新页面
- (void)reloadView
{
    [self.angel reloadView];
}

#pragma mark - # 整体
ZZFLEXVC_ANGEL_CHAIN_METHOD(clear, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(clearAllItems, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(clearAllCells, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(upadte, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(upadteAllItems, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(upadteAllCells, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(isEmpty, BOOL, void)

#pragma mark - # Section操作
ZZFLEXVC_ANGEL_CHAIN_METHOD(addSection, ZZFLEXAngelSectionChainModel *, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(insertSection, ZZFLEXAngelSectionInsertChainModel *, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(sectionForTag, ZZFLEXAngelSectionEditChainModel *, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(deleteSection, BOOL, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(hasSection, BOOL, NSInteger)

#pragma mark - # Section View 操作
ZZFLEXVC_ANGEL_CHAIN_METHOD(setHeader, ZZFLEXAngelViewChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(setXibHeader, ZZFLEXAngelViewChainModel *, Class)

ZZFLEXVC_ANGEL_CHAIN_METHOD(setFooter, ZZFLEXAngelViewChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(setXibFooter, ZZFLEXAngelViewChainModel *, Class)

#pragma mark - # Cell 操作
ZZFLEXVC_ANGEL_CHAIN_METHOD(addCell, ZZFLEXAngelViewChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(addXibCell, ZZFLEXAngelViewChainModel *, Class)

ZZFLEXVC_ANGEL_CHAIN_METHOD(addCells, ZZFLEXAngelViewBatchChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(addXibCells, ZZFLEXAngelViewBatchChainModel *, Class)

- (ZZFLEXAngelViewChainModel *(^)(CGSize size, UIColor *color))addSeperatorCell;
{
    return self.angel.addSeperatorCell;
}

ZZFLEXVC_ANGEL_CHAIN_METHOD(insertCell, ZZFLEXAngelViewInsertChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(insertXibCell, ZZFLEXAngelViewInsertChainModel *, Class)

ZZFLEXVC_ANGEL_CHAIN_METHOD(insertCells, ZZFLEXAngelViewBatchInsertChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(insertXibCells, ZZFLEXAngelViewBatchInsertChainModel *, Class)

ZZFLEXVC_ANGEL_METHOD(deleteCell, ZZFLEXAngelViewEditChainModel *)
ZZFLEXVC_ANGEL_METHOD(deleteCells, ZZFLEXAngelViewBatchEditChainModel *)

ZZFLEXVC_ANGEL_METHOD(updateCell, ZZFLEXAngelViewEditChainModel *)
ZZFLEXVC_ANGEL_METHOD(updateCells, ZZFLEXAngelViewBatchEditChainModel *)

ZZFLEXVC_ANGEL_METHOD(hasCell, ZZFLEXAngelViewEditChainModel *)

#pragma mark - # DataModel 数据源获取
ZZFLEXVC_ANGEL_METHOD(dataModel, ZZFLEXAngelViewEditChainModel *)
ZZFLEXVC_ANGEL_METHOD(dataModelArray, ZZFLEXAngelViewBatchEditChainModel *)

#pragma mark - # View & data
ZZFLEXVC_ANGEL_METHOD(hostView, __kindof UIScrollView *)
ZZFLEXVC_ANGEL_METHOD(data, NSMutableArray *)

@end

#pragma mark - ## ZZFlexibleLayoutViewController (Scroll)
@implementation ZZFlexibleLayoutViewController (Scroll)
- (void)scrollToTop:(BOOL)animated
{
    [self.collectionView setContentOffset:CGPointZero animated:animated];
}

- (void)scrollToBottom:(BOOL)animated
{
    CGFloat y = self.collectionView.contentSize.height - self.collectionView.frame.size.height;
    [self.collectionView setContentOffset:CGPointMake(0, y) animated:animated];
}

- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (self.hasSection(sectionTag)) {
        NSInteger section = [self sectionIndexForTag:sectionTag];
        NSUInteger sectionCount = [self.collectionView numberOfSections];
        if (sectionCount > section) {
            NSUInteger itemCount = [self.collectionView numberOfItemsInSection:section];
            if (itemCount > 0) {
                NSInteger index = 0;
                if (scrollPosition == UICollectionViewScrollPositionBottom || scrollPosition == UICollectionViewScrollPositionRight) {
                    scrollPosition = itemCount - 1;
                }
                else if (scrollPosition == UICollectionViewScrollPositionCenteredVertically || scrollPosition == UICollectionViewScrollPositionCenteredHorizontally) {
                    scrollPosition = itemCount / 2.0;
                }
                
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section] atScrollPosition:scrollPosition animated:animated];
            }
        }
    }
}

- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    if (indexPaths.count > 0) {
        NSIndexPath *indexPath = indexPaths[0];
        [self scrollToIndexPath:indexPath position:scrollPosition animated:animated];
    }
}

- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:cellTag];
    if (indexPaths.count > 0) {
        NSIndexPath *indexPath = indexPaths[0];
        [self scrollToIndexPath:indexPath position:scrollPosition animated:animated];
    }
}

- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (sectionIndex < self.data.count) {
        [self scrollToIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionIndex] position:scrollPosition animated:animated];
    }
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (self.hasCell.atIndexPath(indexPath)) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    }
}

#pragma mark - # Private
- (NSInteger)sectionIndexForTag:(NSInteger)sectionTag
{
    for (int section = 0; section < self.data.count; section++) {
        ZZFlexibleLayoutSectionModel *sectionModel = self.data[section];
        if (sectionModel.sectionTag == sectionTag) {
            return section;
        }
    }
    return 0;
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

@end
