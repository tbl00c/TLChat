//
//  ZZFlexibleLayoutSectionModel.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/27.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFlexibleLayoutViewModel.h"

/**
 * 仅框架内部使用
 *
 * 用于collectionView每个Section的Model
 */

@interface ZZFlexibleLayoutSectionModel : NSObject

/// section标识
@property (nonatomic, assign) NSInteger sectionTag;

/// section背景色
@property (nonatomic, strong) UIColor *backgroundColor;

#pragma mark - # Section Header
/// section头部视图Model
@property (nonatomic, strong) ZZFlexibleLayoutViewModel *headerViewModel;
/// section头部视图Size
@property (nonatomic, assign, readonly) CGSize headerViewSize;

#pragma mark - # Section Footer
/// section尾部视图Model
@property (nonatomic, strong) ZZFlexibleLayoutViewModel *footerViewModel;
/// section尾部视图Size
@property (nonatomic, assign, readonly) CGSize footerViewSize;

#pragma mark - # Section Parameters
/// section最小行距，默认0
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/// section最小间距，默认0
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
/// section边缘间隔，默认UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

#pragma mark - # Items
/// section元素Model数组
@property (nonatomic, strong, readonly) NSMutableArray<ZZFlexibleLayoutViewModel *> *itemsArray;
/// section元素个数
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 * 为section添加元素
 */
- (void)addObject:(ZZFlexibleLayoutViewModel *)object;
- (void)addObjectsFromArray:(NSArray<ZZFlexibleLayoutViewModel *> *)otherArray;

/**
 * 为section插入元素
 */
- (void)insertObject:(ZZFlexibleLayoutViewModel *)object atIndex:(NSUInteger)objectIndex;
- (void)insertObjects:(NSArray<ZZFlexibleLayoutViewModel *> *)objects atIndexes:(NSIndexSet *)indexes;

/*
 * 获取section的第index个元素
 */
- (id)objectAtIndex:(NSUInteger)index;

/**
 * 根据index删除item
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 * 删除item
 */
- (void)removeObject:(ZZFlexibleLayoutViewModel *)object;

/*
 * 获取section的第index个元素的dataModel
 */
- (id)dataModelAtIndex:(NSUInteger)index;


@end
