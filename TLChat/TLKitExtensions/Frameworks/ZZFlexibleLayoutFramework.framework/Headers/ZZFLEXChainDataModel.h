//
//  ZZFLEXChainDataModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZFLEXChainDataModel : NSObject

- (id (^)(NSInteger cellTag))cellModelByCellTag;
- (id (^)(NSInteger sectionTag, NSInteger cellTag))cellModelBySectionTagAndCellTag;
- (id (^)(NSIndexPath *indexPath))cellModelByIndexPath;

- (NSArray *(^)(NSInteger cellTag))cellsModelArrayByCellTag;
- (NSArray *(^)(NSInteger sectionTag, NSInteger cellTag))cellsModelArrayBySectionTagAndCellTag;
- (NSArray *(^)(NSArray<NSIndexPath *> *indexPathArray))cellModelArrayByIndexPaths;

- (id (^)(NSInteger setionTag))sectionHeaderModelByTag;
- (id (^)(NSInteger setionTag))sectionFotterModelByTag;
- (NSArray *(^)(NSInteger sectionTag))cellsModelArrayForSection;

- (NSArray *)allCellsModelArray;

#pragma mark - 框架内部使用
- (instancetype)initWithListData:(NSArray *)listData;

@end
