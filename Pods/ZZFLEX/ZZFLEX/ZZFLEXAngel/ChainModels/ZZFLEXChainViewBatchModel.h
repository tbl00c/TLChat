//
//  ZZFLEXChainViewBatchModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

/**
 *  向section中批量添加cells
 */

#import <Foundation/Foundation.h>

#pragma mark - ## ZZFLEXChainViewBatchBaseModel (批量，基类)
@interface ZZFLEXChainViewBatchBaseModel<ZZFLEXReturnType> : NSObject

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

/// 框架内部使用
- (id)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData;

/// 手动配置cell Action
- (ZZFLEXReturnType (^)(void ((^)(__kindof UIView *itemView, id dataModel))))configAction;

@end

#pragma mark - ## ZZFLEXChainViewBatchModel (批量，添加)
@class ZZFLEXChainViewBatchModel;
@interface ZZFLEXChainViewBatchModel : ZZFLEXChainViewBatchBaseModel<ZZFLEXChainViewBatchModel *>

@end

#pragma mark - ## ZZFLEXChainViewBatchInsertModel (批量，插入)
@class ZZFLEXChainViewBatchInsertModel;
@interface ZZFLEXChainViewBatchInsertModel : ZZFLEXChainViewBatchBaseModel<ZZFLEXChainViewBatchInsertModel *>

/// 插入到指定Index
- (ZZFLEXChainViewBatchInsertModel *(^)(NSInteger index))toIndex;

/// 插入到某个cell前
- (ZZFLEXChainViewBatchInsertModel *(^)(NSInteger sectionTag))beforeCell;

/// 插入到某个cell后
- (ZZFLEXChainViewBatchInsertModel *(^)(NSInteger sectionTag))afterCell;

@end
