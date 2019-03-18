//
//  ZZFlexibleLayoutSectionModel.m
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/27.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import "ZZFlexibleLayoutSectionModel.h"

@implementation ZZFlexibleLayoutSectionModel

- (id)init
{
    if (self = [super init]) {
        _itemsArray = [[NSMutableArray alloc] init];
        self.minimumLineSpacing = 0.0f;
        self.minimumInteritemSpacing = 0.0f;
        self.sectionInsets = UIEdgeInsetsZero;
    }
    return self;
}

#pragma mark - # Section Header
- (CGSize)headerViewSize
{
    return [self.headerViewModel viewSize];
}

#pragma mark - # Section Footer
- (CGSize)footerViewSize
{
    return [self.footerViewModel viewSize];
}

#pragma mark - # Items
- (NSUInteger)count
{
    return self.itemsArray.count;
}

- (void)addObject:(ZZFlexibleLayoutViewModel *)object
{
    if (!object) {
        return;
    }
    [self.itemsArray addObject:object];
}

- (void)addObjectsFromArray:(NSArray<ZZFlexibleLayoutViewModel *> *)otherArray
{
    if (otherArray) {
        [self.itemsArray addObjectsFromArray:otherArray];
    }
}

- (void)insertObject:(ZZFlexibleLayoutViewModel *)object atIndex:(NSUInteger)objectIndex;
{
    if (!object) {
        return;
    }
    [self.itemsArray insertObject:object atIndex:objectIndex];
}

- (void)insertObjects:(NSArray<ZZFlexibleLayoutViewModel *> *)objects atIndexes:(NSIndexSet *)indexes
{
    if (objects) {
        [self.itemsArray insertObjects:objects atIndexes:indexes];
    }
}

- (id)objectAtIndex:(NSUInteger)index
{
    return index < self.itemsArray.count ? self.itemsArray[index] : nil;
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    index < self.itemsArray.count ? [self.itemsArray removeObjectAtIndex:index] : nil;
}

- (void)removeObject:(ZZFlexibleLayoutViewModel *)object
{
    if ([self.itemsArray containsObject:object]) {
        [self.itemsArray removeObject:object];
    }
}

- (id)dataModelAtIndex:(NSUInteger)index
{
    ZZFlexibleLayoutViewModel *viewModel = [self objectAtIndex:index];
    return viewModel.dataModel;
}

@end

