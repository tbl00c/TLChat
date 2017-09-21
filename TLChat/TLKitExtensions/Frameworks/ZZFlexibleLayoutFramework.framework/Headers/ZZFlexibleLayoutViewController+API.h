//
//  ZZFlexibleLayoutViewController+API.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"

@interface ZZFlexibleLayoutViewController (API)

#pragma mark # 页面刷新
/// 刷新页面
- (void)reloadView;

/// 刷新指定的Section
- (void)reloadSectionForTag:(NSInteger)sectionTag;
- (void)reloadSectionForIndex:(NSInteger)sectionIndex;

/// 刷新指定的cell
- (void)reloadCellsForCellTag:(NSInteger)cellTag;
- (void)reloadCellsForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/// 删除所有元素
- (BOOL)deleteAllItems;

#pragma mark - # 页面重新布局
/// 更新section信息
- (void)updateSectionForTag:(NSInteger)sectionTag;
/// 更新cell信息，将重新计算高度，但不会reload
- (void)updateCellsForCellTag:(NSInteger)cellTag;
- (void)updateCellsForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

#pragma mark - # 数据获取操作
/// 获取指定单个数据源
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;
- (id)dataModelForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (id)dataModelForSection:(NSInteger)sectionTag className:(NSString *)className;
- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag;
- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
/// 列表所有的数据源（如添加cell时未指定或传nil，则表现为[NSNull null]）
- (NSArray *)allDataModelArray;

#pragma mark - # Section操作
/// 添加section
- (ZZFLEXChainSectionModel *(^)(NSInteger tag))addSection;

/// 编辑section属性，若section不存在将自动创建
- (ZZFLEXChainSectionModel *(^)(NSInteger tag))sectionForTag;

/// 插入section
- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index;
- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor;

/// 删除section
- (BOOL)deleteSection:(NSInteger)tag;
/// 删除section的所有元素（cell,header,footer）
- (BOOL)deleteAllItemsForSection:(NSInteger)tag;
/// 删除section的所有cell（不包括header,footer）
- (BOOL)deleteAllCellsForSection:(NSInteger)tag;

/// 判断section是否存在
- (BOOL)hasSection:(NSInteger)tag;
/// 判断section index是否存在
- (BOOL)hasSectionAtIndex:(NSInteger)sectionIndex;

#pragma mark - # Section View 操作
/// 为section添加headerView
- (ZZFLEXChainViewModel *(^)(NSString *className))setHeader;
- (id)dataModelForSectionHeader:(NSInteger)sectionTag;
- (BOOL)deleteSectionHeaderView:(NSInteger)sectionTag;

/// 为section添加footerView
- (ZZFLEXChainViewModel *(^)(NSString *className))setFooter;
- (id)dataModelForSectionFooter:(NSInteger)sectionTag;
- (BOOL)deleteSectionFooterView:(NSInteger)sectionTag;

#pragma mark - # Section Cell 操作
/// 添加cell
- (ZZFLEXChainViewModel *(^)(NSString *className))addCell;
/// 批量添加cell
- (ZZFLEXChainViewArrayModel *(^)(NSString *className))addCells;
/// 添加空白cell
- (ZZFLEXChainViewModel *(^)(CGSize size, UIColor *color))addSeperatorCell;

/// 为指定section插入cell，非必须不建议使用，建议单独section+addCell代替（失败返回nil）
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos;
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos;

/// 为指定section批量添加，非必须不建议使用，建议单独section+addCell代替（失败返回nil）
- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos;
- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos;

/// 根据indexPath删除cell
- (BOOL)deleteCellAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)deleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/// 根据tag删除cell，仅删除找到的第一个
- (BOOL)deleteCellByCellTag:(NSInteger)tag;
- (BOOL)deleteCellForSection:(NSInteger)sectionTag tag:(NSInteger)tag;

/// 根据tag删除cell，删除所有
- (BOOL)deleteAllCellsByCellTag:(NSInteger)tag;
- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag tag:(NSInteger)tag;

/// 根据数据源删除cell
- (BOOL)deleteCellByModel:(id)model;
- (BOOL)deleteCellForSection:(NSInteger)sectionTag model:(id)model;

/// 根据数据源删除找到的所有cell
- (BOOL)deleteAllCellsByModel:(id)model;
- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag model:(id)model;

/// 根据类名删除cell
- (BOOL)deleteCellsByClassName:(NSString *)className;
- (BOOL)deleteCellsForSection:(NSInteger)sectionTag className:(NSString *)className;

/// 判断cell是否存在
- (BOOL)hasCell:(NSInteger)tag;
- (BOOL)hasCellWithDataModel:(id)dataModel;
- (BOOL)hasCellAtSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (BOOL)hasCellAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - # Index获取
/// 获取section index
- (NSInteger)sectionIndexForTag:(NSInteger)sectionTag;

/// 获取cell的IndexPaths
- (NSArray<NSIndexPath *> *)cellIndexPathForCellTag:(NSInteger)cellTag;
- (NSArray<NSIndexPath *> *)cellIndexPathForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;

#pragma mark - # 滚动操作
- (void)scrollToTop:(BOOL)animated;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end

