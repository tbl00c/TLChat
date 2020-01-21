//
//  ZZFLEXAngel.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/14.
//  Copyright © 2017年 lbk. All rights reserved.
//

/**
*  ZZFLEXAngel列表控制器
*
*  支持UITableView和UICollectionView，列表视图模块化解决方案
*  无需实现任何代理方法，像搭积木一样实现你想要的列表
*
*  注意：
*  1、sectionTag是Section的表示，建议设置（如果涉及UI的刷新则必须设置），同时建议SectionTag唯一
*  2、viewTag为cell/header/footer的标识，需要时设置，能够结合SectionTag取到DataModel，可以不唯一
*/

#import <Foundation/Foundation.h>
#import "ZZFLEXAngelSectionChainModel.h"
#import "ZZFLEXAngelViewChainModel.h"
#import "ZZFLEXAngelViewBatchChainModel.h"
#import "ZZFLEXAngelViewEditChainModel.h"

#define     ZZFLEX_CHAINAPI_TYPE            @property (nonatomic, copy, readonly)

@protocol ZZFLEXAngelAPIProtocol <NSObject>

/// 数据源
@property (nonatomic, strong, readonly) NSMutableArray *data;

/// 宿主，可以是tableView或者collectionView
@property (nonatomic, weak, readonly) __kindof UIScrollView *hostView;

/**
 * 刷新宿主View
 */
- (void)reloadView;

#pragma mark - # 整体
/// 删除所有元素
ZZFLEX_CHAINAPI_TYPE BOOL (^clear)(void);

/// 删除所有Cell、Header、Fotter
ZZFLEX_CHAINAPI_TYPE BOOL (^clearAllItems)(void);

/// 删除所有Cell
ZZFLEX_CHAINAPI_TYPE BOOL (^clearAllCells)(void);

/// 更新所有元素
ZZFLEX_CHAINAPI_TYPE BOOL (^upadte)(void);

/// 更新所有Cell、Header、Fotter
ZZFLEX_CHAINAPI_TYPE BOOL (^upadteAllItems)(void);

/// 更新所有Cell
ZZFLEX_CHAINAPI_TYPE BOOL (^upadteAllCells)(void);

/// 是不是空列表
ZZFLEX_CHAINAPI_TYPE BOOL (^isEmpty)(void);

#pragma mark - # Section操作
/// 添加section
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelSectionChainModel *(^addSection)(NSInteger tag);

/// 插入section
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelSectionInsertChainModel *(^insertSection)(NSInteger tag);

/// 获取/编辑section （可清空、获取数据源等）
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelSectionEditChainModel *(^sectionForTag)(NSInteger tag);

/// 删除section
ZZFLEX_CHAINAPI_TYPE BOOL (^deleteSection)(NSInteger tag);

/// 判断section是否存在
ZZFLEX_CHAINAPI_TYPE BOOL (^hasSection)(NSInteger tag);


#pragma mark - # Section HeaderFooter 操作
/// 为section添加headerView，传入nil将删除header
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewChainModel *(^setHeader)(Class viewClass);
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewChainModel *(^setXibHeader)(Class viewClass);
/// 为section添加footerView，传入nil将删除footer
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewChainModel *(^setFooter)(Class viewClass);
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewChainModel *(^setXibFooter)(Class viewClass);

#pragma mark - # Section Cell 操作
/// 添加Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewChainModel *(^ addCell)(Class viewClass);
/// 添加Xib Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewChainModel *(^ addXibCell)(Class viewClass);
/// 批量添加Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewBatchChainModel *(^ addCells)(Class viewClass);
/// 批量添加Xib Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewBatchChainModel *(^ addXibCells)(Class viewClass);

/// 添加空白Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewChainModel *(^ addSeperatorCell)(CGSize size, UIColor *color);

/// 插入Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewInsertChainModel *(^ insertCell)(Class viewClass);
/// 插入Xib Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewInsertChainModel *(^ insertXibCell)(Class viewClass);
/// 批量插入Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewBatchInsertChainModel *(^ insertCells)(Class viewClass);
/// 批量插入Xib Cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewBatchInsertChainModel *(^ insertXibCells)(Class viewClass);

/// 删除符合条件的cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewEditChainModel *deleteCell;
/// 删除所有符合条件的cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewBatchEditChainModel *deleteCells;

/// 更新符合条件的cell高度
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewEditChainModel *updateCell;
/// 更新所有符合条件的cell高度
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewBatchEditChainModel *updateCells;


/// 是否包含cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewEditChainModel *hasCell;


/// cell数据源获取
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewEditChainModel *dataModel;
/// 批量cell数据源获取(注意，dataModel为nil的元素，在数组中以NSNull存在)
ZZFLEX_CHAINAPI_TYPE ZZFLEXAngelViewBatchEditChainModel *dataModelArray;

@end

#pragma mark - ## ZZFLEXAngel
@interface ZZFLEXAngel : NSObject <ZZFLEXAngelAPIProtocol>

/// 数据源
@property (nonatomic, strong, readonly) NSMutableArray *data;

/// 宿主，可以是tableView或者collectionView，可以修改
@property (nonatomic, weak) __kindof UIScrollView *hostView;

/**
 * 根据宿主View初始化
 */
- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView;

@end
