//
//  ZZFLEXChainSectionModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
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

#pragma mark - 框架内部使用
- (instancetype)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel;

@end

#pragma mark - ## ZZFLEXChainSectionModel （添加）
@class ZZFLEXChainSectionModel;
@interface ZZFLEXChainSectionModel : ZZFLEXChainSectionBaseModel <ZZFLEXChainSectionModel *>

@end

#pragma mark - ## ZZFLEXChainSectionEditModel （编辑）
@class ZZFLEXChainSectionEditModel;
@interface ZZFLEXChainSectionEditModel : ZZFLEXChainSectionBaseModel <ZZFLEXChainSectionEditModel *>

/// 清空所有视图和cell
- (ZZFLEXChainSectionEditModel *(^)(void))clear;

/// 清空所有cell
- (ZZFLEXChainSectionEditModel *(^)(void))clearAllCells;

/// 删除指定tag的cell
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))deleteCellForTag;

/// 批量删除指定tag的cell（所有该tag的cell）
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))deleteAllCellsForTag;

/// 更新视图和cell高度
- (ZZFLEXChainSectionEditModel *(^)(void))update;

/// 更新cell高度
- (ZZFLEXChainSectionEditModel *(^)(void))updateAllCells;

/// 更新指定tag的cell高度
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))updateCellForTag;

/// 批量更新指定tag的cell高度（所有该tag的cell）
- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))updateAllCellsForTag;

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

