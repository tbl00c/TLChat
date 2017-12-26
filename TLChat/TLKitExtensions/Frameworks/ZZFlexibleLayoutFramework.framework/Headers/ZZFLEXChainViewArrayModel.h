//
//  ZZFLEXChainViewArrayModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

/**
 *  向section中批量添加cells
 */

#import <Foundation/Foundation.h>

#pragma mark - ## ZZFLEXChainViewArrayBaseModel
@interface ZZFLEXChainViewArrayBaseModel<ZZFLEXReturnType> : NSObject

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

#pragma mark - 框架内部使用
- (id)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData;

@end

#pragma mark - ## ZZFLEXChainViewArrayModel
@class ZZFLEXChainViewArrayModel;
@interface ZZFLEXChainViewArrayModel : ZZFLEXChainViewArrayBaseModel<ZZFLEXChainViewArrayModel *>


@end

#pragma mark - ## ZZFLEXChainViewArrayInsertModel
@class ZZFLEXChainViewArrayInsertModel;
@interface ZZFLEXChainViewArrayInsertModel : ZZFLEXChainViewArrayBaseModel<ZZFLEXChainViewArrayInsertModel *>

/// 插入到指定Index
- (ZZFLEXChainViewArrayInsertModel *(^)(NSInteger index))atIndex;

/// 插入到某个cell前
- (ZZFLEXChainViewArrayInsertModel *(^)(NSInteger sectionTag))beforeCell;

/// 插入到某个cell后
- (ZZFLEXChainViewArrayInsertModel *(^)(NSInteger sectionTag))afterCell;


@end
