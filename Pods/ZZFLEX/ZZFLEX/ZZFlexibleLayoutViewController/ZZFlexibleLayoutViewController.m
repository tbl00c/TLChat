//
//  ZZFlexibleLayoutViewController.m
//  zhuanzhuan
//
//  Created by lbk on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFlexibleLayoutViewController+Kernel.h"
#import "ZZFlexibleLayoutViewController+OldAPI.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFlexibleLayoutSeperatorCell.h"
#import "ZZFLEXMacros.h"

@implementation ZZFlexibleLayoutViewController

- (id)init
{
    if (self = [super init]) {
        _data = [[NSMutableArray alloc] init];
        _scrollDirection = UICollectionViewScrollDirectionVertical;
        
        ZZFlexibleLayoutFlowLayout *layout = [[ZZFlexibleLayoutFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        [self.collectionView setDataSource:self];
        [self.collectionView setDelegate:self];
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        [self.collectionView setAlwaysBounceVertical:YES];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.collectionView setFrame:self.view.bounds];
    [self.view addSubview:self.collectionView];
    RegisterCollectionViewCell(self.collectionView, CELL_SEPEARTOR);        // 注册空白cell
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, @"ZZFlexibleLayoutEmptyHeaderFooterView");
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, @"ZZFlexibleLayoutEmptyHeaderFooterView");
}

- (void)dealloc
{
    ZZFLEXLog(@"Dealloc: %@", NSStringFromClass([self class]));
}

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//
//    if (!CGRectEqualToRect(self.view.bounds, self.collectionView.frame)) {
//        [self.collectionView setFrame:self.view.bounds];
//        self.updateCells.all();
//        [self reloadView];
//    }
//}

#pragma mark - # API
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    [(ZZFlexibleLayoutFlowLayout *)self.collectionView.collectionViewLayout setScrollDirection:scrollDirection];
}

#pragma mark 页面刷新
/// 刷新页面
- (void)reloadView
{
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
}

#pragma mark - # 整体
- (BOOL (^)(void))clear
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        [self.data removeAllObjects];
        return YES;
    };
}


- (BOOL (^)(void))clearAllCells
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
            [sectionModel.itemsArray removeAllObjects];
        }
        return YES;
    };
}

/// 更新所有元素
- (BOOL (^)(void))upadte
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
            [sectionModel.headerViewModel updateViewHeight];
            [sectionModel.footerViewModel updateViewHeight];
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                [viewModel updateViewHeight];
            }
        }
        return YES;
    };
}

/// 更新所有Cell
- (BOOL (^)(void))upadteAllCells
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                [viewModel updateViewHeight];
            }
        }
        return YES;
    };
}

#pragma mark - # Section操作
/// 添加section
- (ZZFLEXChainSectionModel *(^)(NSInteger tag))addSection
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        if (self.hasSection(tag)) {
            ZZFLEXLog(@"!!!!! 重复添加Section：%ld", (long)tag);
        }
        
        ZZFlexibleLayoutSectionModel *sectionModel = [[ZZFlexibleLayoutSectionModel alloc] init];
        sectionModel.sectionTag = tag;
        
        [self.data addObject:sectionModel];
        ZZFLEXChainSectionModel *chainSectionModel = [[ZZFLEXChainSectionModel alloc] initWithSectionModel:sectionModel];
        return chainSectionModel;
    };
}

- (ZZFLEXChainSectionInsertModel *(^)(NSInteger tag))insertSection
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        if (self.hasSection(tag)) {
            ZZFLEXLog(@"!!!!! 重复添加Section：%ld", (long)tag);
        }
        
        ZZFlexibleLayoutSectionModel *sectionModel = [[ZZFlexibleLayoutSectionModel alloc] init];
        sectionModel.sectionTag = tag;

        ZZFLEXChainSectionInsertModel *chainSectionModel = [[ZZFLEXChainSectionInsertModel alloc] initWithSectionModel:sectionModel listData:self.data];
        return chainSectionModel;
    };
}

/// 获取section
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))sectionForTag
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        ZZFlexibleLayoutSectionModel *sectionModel = nil;
        for (sectionModel in self.data) {
            if (sectionModel.sectionTag == tag) {
                ZZFLEXChainSectionEditModel *chainSectionModel = [[ZZFLEXChainSectionEditModel alloc] initWithSectionModel:sectionModel];
                return chainSectionModel;
            }
        }
        return [[ZZFLEXChainSectionEditModel alloc] initWithSectionModel:nil];
    };
}

/// 删除section
- (BOOL (^)(NSInteger tag))deleteSection
{
    @weakify(self);
    return ^(NSInteger tag) {
        @strongify(self);
        ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
        if (sectionModel) {
            [self.data removeObject:sectionModel];
            return YES;
        }
        return NO;
    };
}

/// 判断section是否存在
- (BOOL (^)(NSInteger tag))hasSection
{
    @weakify(self);
    return ^(NSInteger tag) {
        @strongify(self);
        BOOL hasSection = [self sectionModelForTag:tag] ? YES : NO;
        return hasSection;
    };
}

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

- (BOOL)deleteAllItemsForSection:(NSInteger)tag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        sectionModel.headerViewModel = nil;
        sectionModel.footerViewModel = nil;
        [sectionModel.itemsArray removeAllObjects];
        return YES;
    }
    return NO;
}

- (BOOL)deleteAllCellsForSection:(NSInteger)tag {
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        [sectionModel.itemsArray removeAllObjects];
        return YES;
    }
    return NO;
}

#pragma mark - # Section View 操作
//MARK: Header
- (ZZFLEXChainViewModel *(^)(NSString *className))setHeader
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        ZZFlexibleLayoutViewModel *viewModel;
        if (className) {
            viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
            viewModel.className = className;
            RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, className);
        }
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeHeader];
        return chainViewModel;
    };
}

//MARK: Footer
- (ZZFLEXChainViewModel *(^)(NSString *className))setFooter
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        ZZFlexibleLayoutViewModel *viewModel;
        if (className) {
            viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
            viewModel.className = className;
            RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, className);
        }
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeFooter];
        return chainViewModel;
    };
}

#pragma mark - # Cell 操作
/// 添加cell
- (ZZFLEXChainViewModel *(^)(NSString *className))addCell
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        RegisterCollectionViewCell(self.collectionView, className);
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
        viewModel.className = className;
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeCell];
        return chainViewModel;
    };
}

/// 批量添加cell
- (ZZFLEXChainViewBatchModel *(^)(NSString *className))addCells
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        RegisterCollectionViewCell(self.collectionView, className);
        ZZFLEXChainViewBatchModel *viewModel = [[ZZFLEXChainViewBatchModel alloc] initWithClassName:className listData:self.data];
        return viewModel;
    };
}

/// 添加空白cell
- (ZZFLEXChainViewModel *(^)(CGSize size, UIColor *color))addSeperatorCell;
{
    @weakify(self);
    return ^(CGSize size, UIColor *color) {
        @strongify(self);
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
        viewModel.className = CELL_SEPEARTOR;
        viewModel.dataModel = [[ZZFlexibleLayoutSeperatorModel alloc] initWithSize:size andColor:color];
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeCell];
        return chainViewModel;
    };
}

/// 插入cell
- (ZZFLEXChainViewInsertModel *(^)(NSString *className))insertCell
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        RegisterCollectionViewCell(self.collectionView, className);
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
        viewModel.className = className;
        ZZFLEXChainViewInsertModel *chainViewModel = [[ZZFLEXChainViewInsertModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeCell];
        return chainViewModel;
    };
}

/// 批量插入cells
- (ZZFLEXChainViewBatchInsertModel *(^)(NSString *className))insertCells
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        RegisterCollectionViewCell(self.collectionView, className);
        ZZFLEXChainViewBatchInsertModel *viewModel = [[ZZFLEXChainViewBatchInsertModel alloc] initWithClassName:className listData:self.data];
        return viewModel;
    };
}

/// 删除cell
- (ZZFLEXChainViewEditModel *)deleteCell
{
    ZZFLEXChainViewEditModel *deleteModel = [[ZZFLEXChainViewEditModel alloc] initWithType:ZZFLEXChainViewEditTypeDelete andListData:self.data];
    return deleteModel;
}

/// 批量删除cell
- (ZZFLEXChainViewBatchEditModel *)deleteCells
{
    ZZFLEXChainViewBatchEditModel *deleteModel = [[ZZFLEXChainViewBatchEditModel alloc] initWithType:ZZFLEXChainViewEditTypeDelete andListData:self.data];
    return deleteModel;
}

/// 更新cell
- (ZZFLEXChainViewEditModel *)updateCell
{
    ZZFLEXChainViewEditModel *deleteModel = [[ZZFLEXChainViewEditModel alloc] initWithType:ZZFLEXChainViewEditTypeUpdate andListData:self.data];
    return deleteModel;
}

/// 批量更新cell
- (ZZFLEXChainViewBatchEditModel *)updateCells
{
    ZZFLEXChainViewBatchEditModel *deleteModel = [[ZZFLEXChainViewBatchEditModel alloc] initWithType:ZZFLEXChainViewEditTypeUpdate andListData:self.data];
    return deleteModel;
}

/// 包含cell
- (ZZFLEXChainViewEditModel *)hasCell
{
    ZZFLEXChainViewEditModel *deleteModel = [[ZZFLEXChainViewEditModel alloc] initWithType:ZZFLEXChainViewEditTypeHas andListData:self.data];
    return deleteModel;
}

#pragma mark - # DataModel 数据源获取
/// 数据源获取
- (ZZFLEXChainViewEditModel *)dataModel
{
    ZZFLEXChainViewEditModel *dataModel = [[ZZFLEXChainViewEditModel alloc] initWithType:ZZFLEXChainViewEditTypeDataModel andListData:self.data];
    return dataModel;
}

/// 批量获取数据源
- (ZZFLEXChainViewBatchEditModel *)dataModelArray
{
    ZZFLEXChainViewBatchEditModel *dataModel = [[ZZFLEXChainViewBatchEditModel alloc] initWithType:ZZFLEXChainViewEditTypeDataModel andListData:self.data];
    return dataModel;
}

@end

#pragma mark - ## ZZFlexibleLayoutViewController (View)
@implementation ZZFlexibleLayoutViewController (View)
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

@end
