//
//  ZZFLEXChainViewModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFLEXChainViewModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

#pragma mark - ## ZZFLEXChainViewBaseModel （单个，基类）
@interface ZZFLEXChainViewBaseModel()

@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) ZZFlexibleLayoutViewModel *viewModel;

@end

@implementation ZZFLEXChainViewBaseModel

- (id)initWithListData:(NSMutableArray *)listData viewModel:(ZZFlexibleLayoutViewModel *)viewModel andType:(ZZFLEXChainViewType)type;
{
    if (self = [super init]) {
        _type = type;
        self.listData = listData;
        self.viewModel = viewModel;
    }
    return self;
}

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                if (self.type == ZZFLEXChainViewTypeCell) {
                    [sectionModel addObject:self.viewModel];
                }
                else if (self.type == ZZFLEXChainViewTypeHeader) {
                    [sectionModel setHeaderViewModel:self.viewModel];
                }
                else if (self.type == ZZFLEXChainViewTypeFooter) {
                    [sectionModel setFooterViewModel:self.viewModel];
                }
                break;
            }
        }
        return self;
    };
}

- (id (^)(id dataModel))withDataModel
{
    return ^(id dataModel) {
        [self.viewModel setDataModel:dataModel];
        return self;
    };
}

- (id (^)(id delegate))delegate
{
    return ^(id delegate) {
        [self.viewModel setDelegate:delegate];
        return self;
    };
}

- (id (^)(id ((^)(NSInteger actionType, id data))))eventAction
{
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self.viewModel setEventAction:eventAction];
        return self;
    };
}

- (id (^)(NSInteger viewTag))viewTag
{
    return ^(NSInteger viewTag) {
        self.viewModel.viewTag = viewTag;
        return self;
    };
}

- (id (^)(void ((^)(id data))))selectedAction
{
    return ^(void ((^eventAction)(id data))) {
        [self.viewModel setSelectedAction:eventAction];
        return self;
    };
}

- (id (^)(void ((^)(__kindof UIView *itemView, id dataModel))))configAction
{
    return ^(void ((^configAction)(__kindof UIView *itemView, id dataModel))) {
        [self.viewModel setConfigAction:configAction];
        return self;
    };
}

@end

#pragma mark - ## ZZFLEXChainViewModel（单个，添加）
@implementation ZZFLEXChainViewModel

@end

#pragma mark - ## ZZFLEXChainViewInsertModel（单个，插入）
typedef NS_OPTIONS(NSInteger, ZZFLEXInsertDataStatus) {
    ZZFLEXInsertDataStatusIndex = 1 << 0,
    ZZFLEXInsertDataStatusBefore = 1 << 1,
    ZZFLEXInsertDataStatusAfter = 1 << 2,
};
@interface ZZFLEXChainViewInsertModel ()

@property (nonatomic, strong) ZZFlexibleLayoutSectionModel *sectionModel;

@property (nonatomic, assign) NSInteger insertTag;

@property (nonatomic, assign) ZZFLEXInsertDataStatus status;

@end

@implementation ZZFLEXChainViewInsertModel

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (ZZFlexibleLayoutSectionModel *model in self.listData) {
            if (model.sectionTag == section) {
                self.sectionModel = model;
            }
        }
        
        [self p_tryInsertCell];
        return self;
    };
}

- (ZZFLEXChainViewInsertModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        self.status |= ZZFLEXInsertDataStatusIndex;
        self.insertTag = index;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (ZZFLEXChainViewInsertModel *(^)(NSInteger sectionTag))beforeCell
{
    return ^(NSInteger sectionTag) {
        self.status |= ZZFLEXInsertDataStatusBefore;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (ZZFLEXChainViewInsertModel *(^)(NSInteger sectionTag))afterCell
{
    return ^(NSInteger sectionTag) {
        self.status |= ZZFLEXInsertDataStatusAfter;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (void)p_tryInsertCell
{
    if (!self.sectionModel) {
        return;
    }
    NSInteger index = -1;
    if (self.status & ZZFLEXInsertDataStatusIndex) {
        index = self.insertTag;
    }
    else if ((self.status & ZZFLEXInsertDataStatusBefore)|| (self.status & ZZFLEXInsertDataStatusAfter)) {
        for (NSInteger i = 0; i < self.sectionModel.itemsArray.count; i++) {
            ZZFlexibleLayoutViewModel *viewModel = [self.sectionModel objectAtIndex:i];
            if (viewModel.viewTag == self.insertTag) {
                index = (self.status & ZZFLEXInsertDataStatusBefore) ? i : i + 1;
                break;
            }
        }
    }
    
    if (index >= 0 && index < self.sectionModel.count) {
        [self.sectionModel insertObject:self.viewModel atIndex:index];
        self.status = 0;
    }
}

@end
