//
//  ZZFLEXChainViewBatchModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFLEXChainViewBatchModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

#pragma mark - ## ZZFLEXChainViewBatchBaseModel （批量，基类）
@interface ZZFLEXChainViewBatchBaseModel()

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic, strong) NSMutableArray *viewModelArray;
@property (nonatomic, strong) ZZFlexibleLayoutSectionModel *sectionModel;
@property (nonatomic, weak) id itemsDelegate;
@property (nonatomic, copy) id (^itemsEventAction)(NSInteger actionType, id data);
@property (nonatomic, copy) void (^itemsSelectedAction)(id data);
@property (nonatomic, copy) void (^itemsConfigAction)(__kindof UIView *itemView, id data);
@property (nonatomic, assign) NSInteger tag;

@end

@implementation ZZFLEXChainViewBatchBaseModel

- (id)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData
{
    if (self = [super init]) {
        self.viewModelArray = [[NSMutableArray alloc] init];
        self.className = className;
        self.listData = listData;
    }
    return self;
}

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                self.sectionModel = sectionModel;
                if (self.viewModelArray.count > 0) {
                    [sectionModel addObjectsFromArray:self.viewModelArray];
                }
                break;
            }
        }
        return self;
    };
}

- (id (^)(NSArray *dataModelArray))withDataModelArray
{
    return ^(NSArray *dataModelArray) {
        for (id model in dataModelArray) {
            ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
            [viewModel setClassName:self.className];
            [viewModel setDataModel:model];
            [viewModel setViewTag:self.tag];
            [viewModel setDelegate:self.itemsDelegate];
            [viewModel setEventAction:self.itemsEventAction];
            [viewModel setSelectedAction:self.itemsSelectedAction];
            [viewModel setConfigAction:self.itemsConfigAction];
            [self.viewModelArray addObject:viewModel];
        }
        if (self.sectionModel) {
            [self.sectionModel addObjectsFromArray:self.viewModelArray];
        }
        return self;
    };
}

- (id (^)(id delegate))delegate
{
    return ^(id delegate) {
        [self setItemsDelegate:delegate];
        return self;
    };
}

- (id (^)(id ((^)(NSInteger actionType, id data))))eventAction
{
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self setItemsEventAction:eventAction];
        return self;
    };
}

- (id (^)(void ((^)(id data))))selectedAction
{
    return ^(void ((^selectedAction)(id data))) {
        [self setItemsSelectedAction:selectedAction];
        return self;
    };
}

- (id (^)(void ((^)(__kindof UIView *itemView, id dataModel))))configAction
{
    return ^(void ((^configAction)(__kindof UIView *itemView, id dataModel))) {
        [self setItemConfigAction:configAction];
        return self;
    };
}

- (id (^)(NSInteger viewTag))viewTag
{
    return ^(NSInteger viewTag) {
        [self setTag:viewTag];
        return self;
    };
}

#pragma mark - # Setters
- (void)setItemsDelegate:(id)itemsDelegate
{
    _itemsDelegate = itemsDelegate;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setDelegate:itemsDelegate];
    }
}

- (void)setItemsEventAction:(id (^)(NSInteger, id))itemsEventAction
{
    _itemsEventAction = itemsEventAction;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setEventAction:itemsEventAction];
    }
}

- (void)setItemsSelectedAction:(void (^)(id))itemsSelectedAction
{
    _itemsSelectedAction = itemsSelectedAction;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setSelectedAction:itemsSelectedAction];
    }
}

- (void)setItemConfigAction:(void (^)(__kindof UIView *view, id dataModel))itemConfigAction
{
    _itemsConfigAction = itemConfigAction;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setConfigAction:itemConfigAction];
    }
}

- (void)setTag:(NSInteger)tag
{
    _tag = tag;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setViewTag:tag];
    }
}

@end

#pragma mark - ## ZZFLEXChainViewBatchModel （批量，添加）
@implementation ZZFLEXChainViewBatchModel

@end

#pragma mark - ## ZZFLEXChainViewBatchInsertModel （批量，插入）
typedef NS_OPTIONS(NSInteger, ZZFLEXInsertArrayDataStatus) {
    ZZFLEXInsertArrayDataStatusIndex = 1 << 0,
    ZZFLEXInsertArrayDataStatusBefore = 1 << 1,
    ZZFLEXInsertArrayDataStatusAfter = 1 << 2,
};

@interface ZZFLEXChainViewBatchInsertModel ()

@property (nonatomic, assign) ZZFLEXInsertArrayDataStatus status;

@property (nonatomic, assign) NSInteger insertTag;

@end

@implementation ZZFLEXChainViewBatchInsertModel

- (id (^)(NSArray *dataModelArray))withDataModelArray
{
    return ^(NSArray *dataModelArray) {
        for (id model in dataModelArray) {
            ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
            [viewModel setClassName:self.className];
            [viewModel setDataModel:model];
            [viewModel setViewTag:self.tag];
            [viewModel setDelegate:self.itemsDelegate];
            [viewModel setEventAction:self.itemsEventAction];
            [viewModel setSelectedAction:self.itemsSelectedAction];
            [self.viewModelArray addObject:viewModel];
        }
        
        [self p_tryInsertCells];
        return self;
    };
}

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                self.sectionModel = sectionModel;
                break;
            }
        }
        
        [self p_tryInsertCells];
        return self;
    };
}


- (ZZFLEXChainViewBatchInsertModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        self.status |= ZZFLEXInsertArrayDataStatusIndex;
        self.insertTag = index;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (ZZFLEXChainViewBatchInsertModel *(^)(NSInteger sectionTag))beforeCell
{
    return ^(NSInteger sectionTag) {
        self.status |= ZZFLEXInsertArrayDataStatusBefore;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (ZZFLEXChainViewBatchInsertModel *(^)(NSInteger sectionTag))afterCell
{
    return ^(NSInteger sectionTag) {
        self.status |= ZZFLEXInsertArrayDataStatusAfter;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (void)p_tryInsertCells
{
    if (!self.sectionModel || self.viewModelArray.count == 0) {
        return;
    }
    NSInteger index = -1;
    if (self.status & ZZFLEXInsertArrayDataStatusIndex) {
        index = self.insertTag;
    }
    else if ((self.status & ZZFLEXInsertArrayDataStatusBefore)|| (self.status & ZZFLEXInsertArrayDataStatusAfter)) {
        for (NSInteger i = 0; i < self.sectionModel.itemsArray.count; i++) {
            ZZFlexibleLayoutViewModel *viewModel = [self.sectionModel objectAtIndex:i];
            if (viewModel.viewTag == self.insertTag) {
                index = (self.status & ZZFLEXInsertArrayDataStatusBefore) ? i : i + 1;
                break;
            }
        }
    }
    
    if (index >= 0 && index < self.sectionModel.count) {
        NSRange range = NSMakeRange(index, [self.viewModelArray count]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.sectionModel insertObjects:self.viewModelArray atIndexes:indexSet];
        self.status = 0;
    }
}

@end

