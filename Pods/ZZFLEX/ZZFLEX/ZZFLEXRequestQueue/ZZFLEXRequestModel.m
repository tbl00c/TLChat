//
//  ZZFLEXRequestModel.m
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/28.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import "ZZFLEXRequestModel.h"

@implementation ZZFLEXRequestModel
#pragma mark - 初始化方法

+ (id)requestModelWithTag:(NSInteger)tag target:(id)target requestMethod:(SEL)requestMethod requestCompleteMethod:(SEL)requestCompleteMethod
{
    ZZFLEXRequestModel *result = [[ZZFLEXRequestModel alloc] initWithTag:tag target:target requestMethod:requestMethod requestCompleteMethod:requestCompleteMethod];
    return result;
}

+ (ZZFLEXRequestModel *)requestModelWithTag:(NSInteger)tag
                            requestAction:(void (^)(ZZFLEXRequestModel *requestModel))requestAction
                    requestCompleteAction:(void (^)(ZZFLEXRequestModel *requestModel))requestCompleteAction
{
    ZZFLEXRequestModel *result = [[ZZFLEXRequestModel alloc] initWithTag:tag requestAction:requestAction requestCompleteAction:requestCompleteAction];
    return result;
}

- (id)initWithTag:(NSInteger)tag target:(id)target requestMethod:(SEL)requestMethod requestCompleteMethod:(SEL)requestCompleteMethod
{
    if (self = [super init]) {
        _tag = tag;
        _target = target;
        _requestMethod = requestMethod;
        _requestCompleteMethod = requestCompleteMethod;
    }
    return self;
}

- (id)initWithTag:(NSInteger)tag requestAction:(void (^)(ZZFLEXRequestModel *))requestAction requestCompleteAction:(void (^)(ZZFLEXRequestModel *))requestCompleteAction
{
    if (self = [super init]) {
        _tag = tag;
        _requestAction = requestAction;
        _requestCompleteAction = requestCompleteAction;
    }
    return self;
}

#pragma mark - 网络请求方法
- (void)executeRequestMethod
{
    if (self.target && self.requestMethod && [self.target respondsToSelector:self.requestMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [self.target performSelector:self.requestMethod withObject:self];
#pragma clang diagnostic pop
    }
    else if (self.requestAction) {
        self.requestAction(self);
    }
}

- (void)executeRequestCompleteMethodWithSuccess:(BOOL)success data:(id)data
{
    _success = success;
    _data = data;

    if (self.target && self.requestCompleteMethod && [self.target respondsToSelector:self.requestCompleteMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [self.target performSelector:self.requestCompleteMethod withObject:self];
#pragma clang diagnostic pop
    }
    else if (self.requestCompleteAction) {
        self.requestCompleteAction(self);
    }
}

@end
