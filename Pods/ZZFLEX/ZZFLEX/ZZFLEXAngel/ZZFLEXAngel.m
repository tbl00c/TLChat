
//
//  ZZFLEXAngel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXAngel.h"
#import "ZZFLEXAngel+Private.h"
#import "ZZFLEXAngel+UITableView.h"
#import "ZZFLEXAngel+UICollectionView.h"
#import "ZZFlexibleLayoutSeperatorCell.h"
#import "ZZFLEXTableViewEmptyCell.h"
#import "ZZFLEXMacros.h"

/*
 *  注册cells 到 hostView
 */
void RegisterHostViewCell(__kindof UIScrollView *hostView, NSString *cellName)
{
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
    }
    else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
    }
}

/*
 *  注册ReusableView 到 hostView
 */
void RegisterHostViewReusableView(__kindof UIScrollView *hostView, NSString *kind, NSString *viewName)
{
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerClass:NSClassFromString(viewName) forHeaderFooterViewReuseIdentifier:viewName];
    }
    else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerClass:NSClassFromString(viewName) forSupplementaryViewOfKind:kind withReuseIdentifier:viewName];
    }
}

@implementation ZZFLEXAngel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView
{
    if (self = [self init]) {
        [self setHostView:hostView];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        _data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setHostView:(__kindof UIScrollView *)hostView
{
    _hostView = hostView;
    if ([_hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)_hostView setDataSource:self];
        [(UITableView *)_hostView setDelegate:self];
        RegisterHostViewCell(_hostView, @"ZZFLEXTableViewEmptyCell");
    }
    else if ([_hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)_hostView setDataSource:self];
        [(UICollectionView *)_hostView setDelegate:self];
        RegisterHostViewCell(_hostView, @"ZZFlexibleLayoutSeperatorCell");        // 注册空白cell
        RegisterHostViewReusableView(_hostView, UICollectionElementKindSectionHeader, @"ZZFlexibleLayoutEmptyHeaderFooterView");
        RegisterHostViewReusableView(_hostView, UICollectionElementKindSectionFooter, @"ZZFlexibleLayoutEmptyHeaderFooterView");
    }
}

- (void)reloadView
{
    [(UITableView *)self.hostView reloadData];
}

@end


#pragma mark - ## ZZFLEXAngel (API)
@implementation ZZFLEXAngel (API)

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

- (BOOL (^)(void))isEmpty
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
            if(sectionModel.itemsArray.count > 0) {
                return NO;
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
        }
        RegisterHostViewReusableView(self.hostView, UICollectionElementKindSectionHeader, className);
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
        }
        RegisterHostViewReusableView(self.hostView, UICollectionElementKindSectionFooter, className);
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
        RegisterHostViewCell(self.hostView, className);
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
        RegisterHostViewCell(self.hostView, className);
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
        viewModel.className = [self.hostView isKindOfClass:[UITableView class]] ? NSStringFromClass([ZZFLEXTableViewEmptyCell class]) : NSStringFromClass([ZZFlexibleLayoutSeperatorCell class]);
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
        RegisterHostViewCell(self.hostView, className);
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
        RegisterHostViewCell(self.hostView, className);
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
