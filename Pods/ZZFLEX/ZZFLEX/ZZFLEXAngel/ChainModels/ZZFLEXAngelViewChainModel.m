//
//  ZZFLEXAngelViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFLEXAngelViewChainModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

#pragma mark - ## ZZFLEXAngelViewBaseChainModel （单个，基类）
@interface ZZFLEXAngelViewBaseChainModel()

@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) ZZFlexibleLayoutViewModel *viewModel;

@end

@implementation ZZFLEXAngelViewBaseChainModel

- (id)initWithListData:(NSMutableArray *)listData viewModel:(ZZFlexibleLayoutViewModel *)viewModel andType:(ZZFLEXAngelViewType)type;
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
                if (self.type == ZZFLEXAngelViewTypeCell) {
                    [sectionModel addObject:self.viewModel];
                }
                else if (self.type == ZZFLEXAngelViewTypeHeader) {
                    [sectionModel setHeaderViewModel:self.viewModel];
                }
                else if (self.type == ZZFLEXAngelViewTypeFooter) {
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

- (id (^)(CGSize size))viewSize
{
    return ^(CGSize size) {
        [self.viewModel setViewSize:size];
        return self;
    };
}

- (id (^)(CGFloat height))viewHeight
{
    return ^(CGFloat height) {
        [self.viewModel setViewSize:CGSizeMake(-1, height)];
        return self;
    };
}

@end

#pragma mark - ## ZZFLEXAngelViewChainModel（单个，添加）
@implementation ZZFLEXAngelViewChainModel

@end

#pragma mark - ## ZZFLEXAngelViewInsertChainModel（单个，插入）
typedef NS_OPTIONS(NSInteger, ZZFLEXInsertDataStatus) {
    ZZFLEXInsertDataStatusIndex = 1 << 0,
    ZZFLEXInsertDataStatusBefore = 1 << 1,
    ZZFLEXInsertDataStatusAfter = 1 << 2,
};
@interface ZZFLEXAngelViewInsertChainModel ()

@property (nonatomic, strong) ZZFlexibleLayoutSectionModel *sectionModel;

@property (nonatomic, assign) NSInteger insertTag;

@property (nonatomic, assign) ZZFLEXInsertDataStatus status;

@end

@implementation ZZFLEXAngelViewInsertChainModel

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

- (ZZFLEXAngelViewInsertChainModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        self.status |= ZZFLEXInsertDataStatusIndex;
        self.insertTag = index;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (ZZFLEXAngelViewInsertChainModel *(^)(NSInteger viewTag))beforeCell
{
    return ^(NSInteger viewTag) {
        self.status |= ZZFLEXInsertDataStatusBefore;
        self.insertTag = viewTag;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (ZZFLEXAngelViewInsertChainModel *(^)(NSInteger viewTag))afterCell
{
    return ^(NSInteger viewTag) {
        self.status |= ZZFLEXInsertDataStatusAfter;
        self.insertTag = viewTag;
        
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
