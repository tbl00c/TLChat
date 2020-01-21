//
//  ZZFLEXAngelViewBatchChainModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

/**
 *  向section中批量添加cells
 */

#import <Foundation/Foundation.h>

#pragma mark - ## ZZFLEXAngelViewBaseBatchChainModel (批量，基类)
@interface ZZFLEXAngelViewBaseBatchChainModel<ZZFLEXReturnType> : NSObject

/// 将cells添加到某个section
- (ZZFLEXReturnType (^)(NSInteger section))toSection;

/// cells的数据源
- (ZZFLEXReturnType (^)(NSArray *dataModelArray))withDataModelArray;

/// cells内部事件deledate，与blcok二选一即可
- (ZZFLEXReturnType (^)(id delegate))delegate;
/// cells内部事件block，与deledate二选一即可
- (ZZFLEXReturnType (^)(id ((^)(NSInteger actionType, id data))))eventAction;

/// cells selected事件
- (ZZFLEXReturnType (^)(void ((^)(id data))))selectedAction;

/// cells tag
- (ZZFLEXReturnType (^)(NSInteger viewTag))viewTag;

/// 手动配置cell Action
- (ZZFLEXReturnType (^)(void ((^)(__kindof UIView *itemView, id dataModel))))configAction;

/// 手动配置cell大小，cell实现viewSizeByDataModel:或viewHeightByDataModel:后此设置失效
- (ZZFLEXReturnType (^)(CGSize size))viewSize;
/// 手动配置cell高度，cell实现viewSizeByDataModel:或viewHeightByDataModel:后此设置失效
- (ZZFLEXReturnType (^)(CGFloat height))viewHeight;

#pragma mark - 框架内部使用
- (instancetype)initWithViewClass:(Class)viewClass listData:(NSMutableArray *)listData;

@end

#pragma mark - ## ZZFLEXAngelViewBatchChainModel (批量，添加)
@class ZZFLEXAngelViewBatchChainModel;
@interface ZZFLEXAngelViewBatchChainModel : ZZFLEXAngelViewBaseBatchChainModel<ZZFLEXAngelViewBatchChainModel *>

@end

#pragma mark - ## ZZFLEXAngelViewBatchInsertChainModel (批量，插入)
@class ZZFLEXAngelViewBatchInsertChainModel;
@interface ZZFLEXAngelViewBatchInsertChainModel : ZZFLEXAngelViewBaseBatchChainModel<ZZFLEXAngelViewBatchInsertChainModel *>

/// 插入到指定Index
- (ZZFLEXAngelViewBatchInsertChainModel *(^)(NSInteger index))toIndex;

/// 插入到某个cell前
- (ZZFLEXAngelViewBatchInsertChainModel *(^)(NSInteger sectionTag))beforeCell;

/// 插入到某个cell后
- (ZZFLEXAngelViewBatchInsertChainModel *(^)(NSInteger sectionTag))afterCell;

@end
