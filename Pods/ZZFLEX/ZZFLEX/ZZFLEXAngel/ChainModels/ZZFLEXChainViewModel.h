//
//  ZZFLEXChainViewModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

/**
 *  向section中添加视图(cell/header/footer)
 */

#import <Foundation/Foundation.h>

#pragma mark - ## ZZFLEXChainViewBaseModel (单个，基类)
typedef NS_ENUM(NSInteger, ZZFLEXChainViewType) {
    ZZFLEXChainViewTypeCell,
    ZZFLEXChainViewTypeHeader,
    ZZFLEXChainViewTypeFooter,
};

@class ZZFlexibleLayoutViewModel;
@interface ZZFLEXChainViewBaseModel<ZZFLEXReturnType> : NSObject

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

/// 框架内部使用
@property (nonatomic, assign, readonly) ZZFLEXChainViewType type;
- (id)initWithListData:(NSMutableArray *)listData viewModel:(ZZFlexibleLayoutViewModel *)viewModel andType:(ZZFLEXChainViewType)type;

@end

#pragma mark - ## ZZFLEXChainViewModel （单个，添加）
@class ZZFLEXChainViewModel;
@interface ZZFLEXChainViewModel : ZZFLEXChainViewBaseModel <ZZFLEXChainViewModel *>

@end

#pragma mark - ## ZZFLEXChainViewInsertModel （单个，插入）
@class ZZFLEXChainViewInsertModel;
@interface ZZFLEXChainViewInsertModel : ZZFLEXChainViewBaseModel <ZZFLEXChainViewInsertModel *>

/// 插入到指定Index
- (ZZFLEXChainViewInsertModel *(^)(NSInteger index))toIndex;

/// 插入到某个cell前
- (ZZFLEXChainViewInsertModel *(^)(NSInteger sectionTag))beforeCell;

/// 插入到某个cell后
- (ZZFLEXChainViewInsertModel *(^)(NSInteger sectionTag))afterCell;

@end
