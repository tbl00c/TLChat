//
//  ZZFlexibleLayoutViewModel.m
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/27.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"

@implementation ZZFlexibleLayoutViewModel
@synthesize viewSize = _viewSize;
@synthesize dataModel = _dataModel;

- (instancetype)initWithViewClass:(Class)viewClass
{
    return [self initWithViewClass:viewClass andDataModel:nil];
}

- (instancetype)initWithViewClass:(Class)viewClass andDataModel:(id)dataModel
{
    return [self initWithViewClass:viewClass andDataModel:dataModel viewTag:0];
}

- (instancetype)initWithViewClass:(Class)viewClass andDataModel:(id)dataModel viewTag:(NSInteger)viewTag
{
    return [self initWithViewClass:viewClass andDataModel:dataModel viewSize:CGSizeZero viewTag:viewTag];
}

- (instancetype)initWithViewClass:(Class)viewClass andDataModel:(id)dataModel viewSize:(CGSize)viewSize viewTag:(NSInteger)viewTag
{
    if (self = [super init]) {
        _viewSize = viewSize;
        _dataModel = dataModel;
        _viewClass = viewClass;
        _className = NSStringFromClass(viewClass);
        _viewTag = viewTag;
        [self updateViewSize];
    }
    return self;
}

- (void)setDataModel:(id)dataModel
{
    _dataModel = dataModel;
    [self updateViewSize];
}

- (void)setViewClass:(Class)viewClass
{
    _viewClass = viewClass;
    _className = viewClass ? NSStringFromClass(viewClass) : nil;
    [self updateViewSize];
}

- (void)setViewSize:(CGSize)viewSize
{
    if (CGSizeEqualToSize(_viewSize, CGSizeZero)) {
        _viewSize = viewSize;
    }
}

- (void)updateViewSize
{
    if (self.viewClass) {
        id dataModel = _dataModel;
        if ([(id<ZZFlexibleLayoutViewProtocol>)self.viewClass respondsToSelector:@selector(viewSizeByDataModel:)]) {
            _viewSize = [(id<ZZFlexibleLayoutViewProtocol>)self.viewClass viewSizeByDataModel:dataModel];
        }
        else if ([(id<ZZFlexibleLayoutViewProtocol>)self.viewClass respondsToSelector:@selector(viewHeightByDataModel:)]) {
            CGFloat height = [(id<ZZFlexibleLayoutViewProtocol>)self.viewClass viewHeightByDataModel:dataModel];
            _viewSize = CGSizeMake(-1, height);
        }
    }
}

@end
