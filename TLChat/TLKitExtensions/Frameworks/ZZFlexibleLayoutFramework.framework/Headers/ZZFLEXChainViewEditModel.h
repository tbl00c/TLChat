//
//  ZZFLEXChainViewEditModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

/**
 *  cell删除，仅删除满足条件的第一个
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZFLEXChainViewEditType) {
    ZZFLEXChainViewEditTypeDelete,
    ZZFLEXChainViewEditTypeUpdate,
    ZZFLEXChainViewEditTypeDataModel,
    ZZFLEXChainViewEditTypeHas,
};

#pragma mark - ## ZZFLEXChainViewEditModel (单个)
@interface ZZFLEXChainViewEditModel : NSObject

/// 根据cellTag
- (id (^)(NSInteger viewTag))byViewTag;

/// 根据数据源
- (id (^)(id dataModel))byViewDataModel;

/// 根据类名
- (id (^)(NSString *className))byViewClassName;

/// 根据indexPath
- (id (^)(NSIndexPath *indexPath))atIndexPath;

/// 根据sectionTag和cellTag
- (id (^)(NSInteger sectionTag, NSInteger viewTag))bySectionTagAndViewTag;

/// 框架内部使用
- (instancetype)initWithType:(ZZFLEXChainViewEditType)type andListData:(NSArray *)listData;

@end

#pragma mark - ## ZZFLEXChainViewBatchEditModel (批量)
@interface ZZFLEXChainViewBatchEditModel : NSObject

/// 所有
- (NSArray *(^)(void))all;

/// 根据cellTag
- (NSArray *(^)(NSInteger viewTag))byViewTag;

/// 根据数据源
- (NSArray *(^)(id dataModel))byViewDataModel;

/// 根据类名
- (NSArray *(^)(NSString *className))byViewClassName;

/// 根据sectionTag和cellTag
- (NSArray *(^)(NSInteger sectionTag, NSInteger viewTag))bySectionTagAndViewTag;

/// 框架内部使用
- (instancetype)initWithType:(ZZFLEXChainViewEditType)type andListData:(NSArray *)listData;

@end
