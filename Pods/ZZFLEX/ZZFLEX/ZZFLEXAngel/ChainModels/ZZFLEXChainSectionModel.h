//
//  ZZFLEXChainSectionModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

/**
 *  向列表中添加Section
 */

#import <UIKit/UIKit.h>

@class ZZFlexibleLayoutSectionModel;

#pragma mark - ## ZZFLEXChainSectionBaseModel (基类)
@interface ZZFLEXChainSectionBaseModel<ZZFLEXReturnType> : NSObject

/// 最小行间距
- (ZZFLEXReturnType (^)(CGFloat minimumLineSpacing))minimumLineSpacing;
/// 最小元素间距
- (ZZFLEXReturnType (^)(CGFloat minimumInteritemSpacing))minimumInteritemSpacing;
/// sectionInsets
- (ZZFLEXReturnType (^)(UIEdgeInsets sectionInsets))sectionInsets;
/// backgrounColor
- (ZZFLEXReturnType (^)(UIColor *backgrounColor))backgrounColor;

/// 初始化，框架内部使用
- (instancetype)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel;

@end

#pragma mark - ## ZZFLEXChainSectionModel （添加）
@class ZZFLEXChainSectionModel;
@interface ZZFLEXChainSectionModel : ZZFLEXChainSectionBaseModel <ZZFLEXChainSectionModel *>

@end

#pragma mark - ## ZZFLEXChainSectionInsertModel （插入）
@class ZZFLEXChainSectionInsertModel;
@interface ZZFLEXChainSectionInsertModel : ZZFLEXChainSectionBaseModel <ZZFLEXChainSectionInsertModel *>

/// 插入到指定Index
- (ZZFLEXChainSectionInsertModel *(^)(NSInteger index))toIndex;

/// 插入到某个section前
- (ZZFLEXChainSectionInsertModel *(^)(NSInteger sectionTag))beforeSection;

/// 插入到某个section后
- (ZZFLEXChainSectionInsertModel *(^)(NSInteger sectionTag))afterSection;

/// 框架内部使用
- (instancetype)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel listData:(NSMutableArray *)listData;

@end

#pragma mark - ## ZZFLEXChainSectionEditModel （编辑）
@class ZZFLEXChainSectionEditModel;
@interface ZZFLEXChainSectionEditModel : ZZFLEXChainSectionBaseModel <ZZFLEXChainSectionEditModel *>

#pragma mark 获取数据源
/// 所有cell数据源
@property (nonatomic, strong, readonly) NSArray *dataModelArray;
/// header数据源
@property (nonatomic, strong, readonly) id dataModelForHeader;
/// footer数据源
@property (nonatomic, strong, readonly) id dataModelForFooter;

/// 根据viewTag获取数据源
- (id (^)(NSInteger viewTag))dataModelByViewTag;
/// 根据viewTag批量获取数据源
- (NSArray *(^)(NSInteger viewTag))dataModelArrayByViewTag;

#pragma mark 删除
/// 清空所有视图和cell
- (ZZFLEXChainSectionEditModel *(^)(void))clear;
/// 清空所有cell
- (ZZFLEXChainSectionEditModel *(^)(void))clearCells;

/// 删除SectionHeader
- (ZZFLEXChainSectionEditModel *(^)(void))deleteHeader;
/// 删除SectionFooter
- (ZZFLEXChainSectionEditModel *(^)(void))deleteFooter;

/// 删除指定tag的cell
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))deleteCellByTag;
/// 批量删除指定tag的cell（所有该tag的cell）
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))deleteAllCellsByTag;

#pragma mark 刷新
/// 更新视图和cell高度
- (ZZFLEXChainSectionEditModel *(^)(void))update;
/// 更新cell高度
- (ZZFLEXChainSectionEditModel *(^)(void))updateCells;

/// 更新SectionHeader高度
- (ZZFLEXChainSectionEditModel *(^)(void))updateHeader;
/// 更新SectionFooter高度
- (ZZFLEXChainSectionEditModel *(^)(void))updateFooter;

/// 更新指定tag的cell高度
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))updateCellByTag;
/// 批量更新指定tag的cell高度（所有该tag的cell）
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))updateAllCellsByTag;

@end
