//
//  ZZFlexibleLayoutViewController+OldAPI.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

/**
 * 已淘汰的API，不再建议使用
 */

#import "ZZFlexibleLayoutViewController.h"

@interface ZZFlexibleLayoutViewController (OldAPI)

/// 删除所有元素
- (BOOL)deleteAllItems;

/// 添加section
- (NSInteger)addSectionWithTag:(NSInteger)tag;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;
- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets;

- (NSInteger)addSectionWithTag:(NSInteger)tag backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor;
- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor;

/// 插入section
- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index;
- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor;

/// 判断section是否存在
- (BOOL)hasSection:(NSInteger)tag;

/// 删除section
- (BOOL)deleteSection:(NSInteger)tag;


/// 为section添加headerView
- (BOOL)setSectionHeaderViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className;
/// 获取header数据源
- (id)dataModelForSectionHeader:(NSInteger)sectionTag;
/// 为section添加footerView
- (BOOL)setSectionFooterViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className;
/// 获取footer数据源
- (id)dataModelForSectionFooter:(NSInteger)sectionTag;


/// 为指定section添加cell（若section不存在将自动添加）
- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className;
- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag;

/// 为指定section批量添加cell(相同class，若section不存在将自动添加)
- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className;
- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag;

/// 插入cell
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos;
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos;

/// 批量插入cell
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

/// 更新cell信息，将重新计算高度，但不会reload
- (void)updateCellsForCellTag:(NSInteger)cellTag;
- (void)updateCellsForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/// 判断cell是否存在
- (BOOL)hasCell:(NSInteger)tag;
- (BOOL)hasCellWithDataModel:(id)dataModel;
- (BOOL)hasCellAtSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (BOOL)hasCellAtIndexPath:(NSIndexPath *)indexPath;

/// 获取cell的IndexPaths
- (NSArray<NSIndexPath *> *)cellIndexPathForCellTag:(NSInteger)cellTag;
- (NSArray<NSIndexPath *> *)cellIndexPathForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;

/// 获取单个数据源
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;
- (id)dataModelForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (id)dataModelForSection:(NSInteger)sectionTag className:(NSString *)className;

/// 批量获取数据源
- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag;
- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;

/// 列表所有的数据源（如添加cell时未指定或传nil，则表现为[NSNull null]）
- (NSArray *)allDataModelArray;

@end


#pragma mark - ## ZZFlexibleLayoutViewController (OldSeperatorAPI)
@interface ZZFlexibleLayoutViewController (OldSeperatorAPI)

/// 添加默认的分割线cell（SCREENWIDTH，10）
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag;
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size;
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withColor:(UIColor *)color;
- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size andColor:(UIColor *)color;

@end
