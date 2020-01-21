//
//  ZZFLEXAngelViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

/**
 *  向section中添加视图(cell/header/footer)
 */

#import <Foundation/Foundation.h>

#pragma mark - ## ZZFLEXAngelViewBaseChainModel (单个，基类)
typedef NS_ENUM(NSInteger, ZZFLEXAngelViewType) {
    ZZFLEXAngelViewTypeCell,
    ZZFLEXAngelViewTypeHeader,
    ZZFLEXAngelViewTypeFooter,
};

@class ZZFlexibleLayoutViewModel;
@interface ZZFLEXAngelViewBaseChainModel<ZZFLEXReturnType> : NSObject

/// 将cell添加到某个section
- (ZZFLEXReturnType (^)(NSInteger section))toSection;

/// cell的数据源
- (ZZFLEXReturnType (^)(id dataModel))withDataModel;

/// cell内部事件deledate，与blcok二选一即可
- (ZZFLEXReturnType (^)(id delegate))delegate;
/// cell内部事件block，与deledate二选一即可
- (ZZFLEXReturnType (^)(id ((^)(NSInteger actionType, id data))))eventAction;

/// cell selected事件
- (ZZFLEXReturnType (^)(void ((^)(id data))))selectedAction;

/// cell tag
- (ZZFLEXReturnType (^)(NSInteger viewTag))viewTag;

/// 手动配置cell Action
- (ZZFLEXReturnType (^)(void ((^)(__kindof UIView *itemView, id dataModel))))configAction;

/// 手动配置cell大小，cell实现viewSizeByDataModel:或viewHeightByDataModel:后此设置失效
- (ZZFLEXReturnType (^)(CGSize size))viewSize;
/// 手动配置cell高度，cell实现viewSizeByDataModel:或viewHeightByDataModel:后此设置失效
- (ZZFLEXReturnType (^)(CGFloat height))viewHeight;

/// 框架内部使用
@property (nonatomic, assign, readonly) ZZFLEXAngelViewType type;
- (id)initWithListData:(NSMutableArray *)listData viewModel:(ZZFlexibleLayoutViewModel *)viewModel andType:(ZZFLEXAngelViewType)type;

@end

#pragma mark - ## ZZFLEXAngelViewChainModel （单个，添加）
@class ZZFLEXAngelViewChainModel;
@interface ZZFLEXAngelViewChainModel : ZZFLEXAngelViewBaseChainModel <ZZFLEXAngelViewChainModel *>

@end

#pragma mark - ## ZZFLEXAngelViewInsertChainModel （单个，插入）
@class ZZFLEXAngelViewInsertChainModel;
@interface ZZFLEXAngelViewInsertChainModel : ZZFLEXAngelViewBaseChainModel <ZZFLEXAngelViewInsertChainModel *>

/// 插入到指定Index
- (ZZFLEXAngelViewInsertChainModel *(^)(NSInteger index))toIndex;

/// 插入到某个cell前
- (ZZFLEXAngelViewInsertChainModel *(^)(NSInteger viewTag))beforeCell;

/// 插入到某个cell后
- (ZZFLEXAngelViewInsertChainModel *(^)(NSInteger viewTag))afterCell;

@end
