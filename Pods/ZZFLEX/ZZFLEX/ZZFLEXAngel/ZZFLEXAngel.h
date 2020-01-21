//
//  ZZFLEXAngel.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/14.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFLEXChainSectionModel.h"
#import "ZZFLEXChainViewModel.h"
#import "ZZFLEXChainViewBatchModel.h"
#import "ZZFLEXChainViewEditModel.h"

#define     ZZFLEX_CHAINAPI_TYPE            @property (nonatomic, copy, readonly)

@interface ZZFLEXAngel : NSObject

/// 数据源
@property (nonatomic, strong) NSMutableArray *data;

/// 宿主，可以是tableView或者collectionView
@property (nonatomic, weak) __kindof UIScrollView *hostView;

/**
 * 根据宿主View初始化
 */
- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView;

/**
 * 刷新宿主View
 */
- (void)reloadView;

@end

#pragma mark - ## ZZFLEXAngel (API)
@interface ZZFLEXAngel (API)

#pragma mark - # 整体
/// 删除所有元素
ZZFLEX_CHAINAPI_TYPE BOOL (^clear)(void);

/// 删除所有Cell
ZZFLEX_CHAINAPI_TYPE BOOL (^clearAllCells)(void);

/// 更新所有元素
ZZFLEX_CHAINAPI_TYPE BOOL (^upadte)(void);

/// 更新所有Cell
ZZFLEX_CHAINAPI_TYPE BOOL (^upadteAllCells)(void);

/// 是不是空列表
ZZFLEX_CHAINAPI_TYPE BOOL (^isEmpty)(void);

#pragma mark - # Section操作
/// 添加section
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionModel *(^addSection)(NSInteger tag);

/// 插入section
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionInsertModel *(^insertSection)(NSInteger tag);

/// 获取/编辑section （可清空、获取数据源等）
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionEditModel *(^sectionForTag)(NSInteger tag);

/// 删除section
ZZFLEX_CHAINAPI_TYPE BOOL (^deleteSection)(NSInteger tag);

/// 判断section是否存在
ZZFLEX_CHAINAPI_TYPE BOOL (^hasSection)(NSInteger tag);


#pragma mark - # Section HeaderFooter 操作
/// 为section添加headerView，传入nil将删除header
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^setHeader)(NSString *className);

/// 为section添加footerView，传入nil将删除footer
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^setFooter)(NSString *className);


#pragma mark - # Section Cell 操作
/// 添加cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^ addCell)(NSString *className);
/// 批量添加cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchModel *(^ addCells)(NSString *className);
/// 添加空白cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^ addSeperatorCell)(CGSize size, UIColor *color);


/// 插入cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewInsertModel *(^ insertCell)(NSString *className);
/// 批量插入cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchInsertModel *(^ insertCells)(NSString *className);


/// 删除符合条件的cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *deleteCell;
/// 删除所有符合条件的cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchEditModel *deleteCells;


/// 更新符合条件的cell高度
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *updateCell;
/// 更新所有符合条件的cell高度
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchEditModel *updateCells;


/// 是否包含cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *hasCell;


/// cell数据源获取
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *dataModel;
/// 批量cell数据源获取(注意，dataModel为nil的元素，在数组中以NSNull存在)
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchEditModel *dataModelArray;

@end
