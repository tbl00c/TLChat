//
//  ZZFLEXAngelSectionChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFLEXAngelSectionChainModel.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFLEXMacros.h"

#pragma mark - ## ZZFLEXAngelSectionBaseChainModel (基类)
@interface ZZFLEXAngelSectionBaseChainModel ()

@property (nonatomic, strong) ZZFlexibleLayoutSectionModel *sectionModel;

@end

@implementation ZZFLEXAngelSectionBaseChainModel

- (instancetype)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel
{
    if (self = [super init]) {
        self.sectionModel = sectionModel;
    }
    return self;
}

- (id (^)(CGFloat minimumLineSpacing))minimumLineSpacing
{
    return ^(CGFloat minimumLineSpacing) {
        [self.sectionModel setMinimumLineSpacing:minimumLineSpacing];
        return self;
    };
}

- (id (^)(CGFloat minimumInteritemSpacing))minimumInteritemSpacing
{
    return ^(CGFloat minimumInteritemSpacing) {
        [self.sectionModel setMinimumInteritemSpacing:minimumInteritemSpacing];
        return self;
    };
}

- (id (^)(UIEdgeInsets sectionInsets))sectionInsets
{
    return ^(UIEdgeInsets sectionInsets) {
        [self.sectionModel setSectionInsets:sectionInsets];
        return self;
    };
}

- (id (^)(UIColor *backgrounColor))backgrounColor
{
    return ^(UIColor *backgrounColor) {
        [self.sectionModel setBackgroundColor:backgrounColor];
        return self;
    };
}

@end

#pragma mark - ## ZZFLEXAngelSectionChainModel （添加）
@implementation ZZFLEXAngelSectionChainModel

@end

#pragma mark - ## ZZFLEXAngelSectionInsertChainModel （插入）
@interface ZZFLEXAngelSectionInsertChainModel()

@property (nonatomic, strong) NSMutableArray *listData;

@end

@implementation ZZFLEXAngelSectionInsertChainModel

- (instancetype)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel listData:(NSMutableArray *)listData
{
    if (self = [super initWithSectionModel:sectionModel]) {
        self.listData = listData;
    }
    return self;
}

- (ZZFLEXAngelSectionInsertChainModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        [self p_insertToListDataAtIndex:index];
        return self;
    };
}

- (ZZFLEXAngelSectionInsertChainModel *(^)(NSInteger sectionTag))beforeSection
{
    return ^(NSInteger sectionTag) {
        for (int i = 0; i < self.listData.count; i++) {
            ZZFlexibleLayoutSectionModel *model = self.listData[i];
            if (model.sectionTag == sectionTag) {
                [self p_insertToListDataAtIndex:i];
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXAngelSectionInsertChainModel *(^)(NSInteger sectionTag))afterSection
{
    return ^(NSInteger sectionTag) {
        for (int i = 0; i < self.listData.count; i++) {
            ZZFlexibleLayoutSectionModel *model = self.listData[i];
            if (model.sectionTag == sectionTag) {
                [self p_insertToListDataAtIndex:i + 1];
                break;
            }
        }
        return self;
    };
}

- (BOOL)p_insertToListDataAtIndex:(NSInteger)index
{
    if (self.listData && index >= 0 && index < self.listData.count) {
        [self.listData insertObject:self.sectionModel atIndex:index];
        self.listData = nil;
        return YES;
    }
    ZZFLEXLog(@"!!!!! section插入失败");
    return NO;
}

@end

#pragma mark - ## ZZFLEXAngelSectionEditChainModel （编辑）
@implementation ZZFLEXAngelSectionEditChainModel

#pragma mark 获取数据源
- (NSArray *)dataModelArray
{
    NSArray *viewModelArray = self.sectionModel.itemsArray;
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:viewModelArray.count];
    for (ZZFlexibleLayoutViewModel *viewModel in viewModelArray) {
        if (viewModel.dataModel) {
            [data addObject:viewModel.dataModel];
        }
        else {
            [data addObject:[NSNull null]];
        }
    }
    return data;
}

- (id)dataModelForHeader
{
    return self.sectionModel.headerViewModel.dataModel;
}

- (id)dataModelForFooter
{
    return self.sectionModel.footerViewModel.dataModel;
}

/// 根据viewTag获取数据源
- (id (^)(NSInteger viewTag))dataModelByViewTag
{
    return ^(NSInteger viewTag) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == viewTag) {
                return viewModel.dataModel;
            }
        }
        if (self.sectionModel.headerViewModel.viewTag == viewTag) {
            return self.sectionModel.headerViewModel.dataModel;
        }
        else if (self.sectionModel.footerViewModel.viewTag == viewTag) {
            return self.sectionModel.footerViewModel.dataModel;
        }
        return (id)nil;
    };
}

/// 根据viewTag批量获取数据源
- (NSArray *(^)(NSInteger viewTag))dataModelArrayByViewTag
{
    return ^(NSInteger viewTag) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == viewTag) {
                if (viewModel.dataModel) {
                    [data addObject:viewModel.dataModel];
                }
                else {
                    [data addObject:[NSNull null]];
                }
            }
        }
        if (self.sectionModel.headerViewModel.viewTag == viewTag) {
            if (self.sectionModel.headerViewModel.dataModel) {
                [data addObject:self.sectionModel.headerViewModel.dataModel];
            }
            else {
                [data addObject:[NSNull null]];
            }
        }
        if (self.sectionModel.footerViewModel.viewTag == viewTag) {
            if (self.sectionModel.footerViewModel.dataModel) {
                [data addObject:self.sectionModel.footerViewModel.dataModel];
            }
            else {
                [data addObject:[NSNull null]];
            }
        }
        return data;
    };
}

#pragma mark 删除
- (ZZFLEXAngelSectionEditChainModel *(^)(void))clear
{
    return ^(void) {
        self.sectionModel.headerViewModel = nil;
        self.sectionModel.footerViewModel = nil;
        [self.sectionModel.itemsArray removeAllObjects];
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))clearItems
{
    return ^(void) {
        self.sectionModel.headerViewModel = nil;
        [self.sectionModel.itemsArray removeAllObjects];
        self.sectionModel.footerViewModel = nil;
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))clearCells
{
    return ^(void) {
        [self.sectionModel.itemsArray removeAllObjects];
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))deleteHeader
{
    return ^(void) {
        self.sectionModel.headerViewModel = nil;
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))deleteFooter
{
    return ^(void) {
        self.sectionModel.footerViewModel = nil;
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(NSInteger tag))deleteCellByTag
{
    return ^(NSInteger tag) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [self.sectionModel removeObject:viewModel];
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(NSInteger tag))deleteAllCellsByTag
{
    return ^(NSInteger tag) {
        NSMutableArray *deleteData = @[].mutableCopy;
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [deleteData addObject:viewModel];
            }
        }
        for (ZZFlexibleLayoutViewModel *viewModel in deleteData) {
            [self.sectionModel removeObject:viewModel];
        }
        return self;
    };
}

#pragma mark 刷新
- (ZZFLEXAngelSectionEditChainModel *(^)(void))update
{
    return ^(void) {
        [self.sectionModel.headerViewModel updateViewSize];
        [self.sectionModel.footerViewModel updateViewSize];
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            [viewModel updateViewSize];
        }
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))updateItems
{
    return ^(void) {
        [self.sectionModel.headerViewModel updateViewSize];
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            [viewModel updateViewSize];
        }
        [self.sectionModel.footerViewModel updateViewSize];
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))updateCells
{
    return ^(void) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            [viewModel updateViewSize];
        }
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))updateHeader
{
    return ^(void) {
        [self.sectionModel.headerViewModel updateViewSize];
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(void))updateFooter
{
    return ^(void) {
        [self.sectionModel.footerViewModel updateViewSize];
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(NSInteger tag))updateCellByTag
{
    return ^(NSInteger tag) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [viewModel updateViewSize];
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXAngelSectionEditChainModel *(^)(NSInteger tag))updateAllCellsByTag
{
    return ^(NSInteger tag) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [viewModel updateViewSize];
            }
        }
        return self;
    };
}

@end
