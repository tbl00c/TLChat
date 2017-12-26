//
//  ZZFLEXChainAllCellsEditModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

/**
 *  cell删除，删除所有满足条件的cells
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZFLEXChainAllCellsEditType) {
    ZZFLEXChainAllCellsEditTypeDelete,
    ZZFLEXChainAllCellsEditTypeUpdate,
};

@interface ZZFLEXChainAllCellsEditModel : NSObject

/// 删除所有cell
- (BOOL)all;

/// 根据cellTag删除cell
- (BOOL (^)(NSInteger cellTag))byCellTag;

/// 根据数据源删除cell
- (BOOL (^)(id dataModel))byModel;

/// 根据类名删除cell
- (BOOL (^)(NSString *className))byClassName;

/// 根据sectionTag和cellTag删除cell
- (BOOL (^)(NSInteger sectionTag, NSInteger cellTag))bySectionTagAndCellTag;

#pragma mark - 框架内部使用
- (instancetype)initWithType:(ZZFLEXChainAllCellsEditType)type andListData:(NSArray *)listData;

@end
