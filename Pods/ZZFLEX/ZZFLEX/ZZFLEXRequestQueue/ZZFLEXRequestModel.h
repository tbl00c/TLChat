//
//  ZZFLEXRequestModel.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by 李伯坤 on 2016/12/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络数据请求Model，用于ZZFLEXRequestQueue中
 *
 *  主要原理是干预网络请求成功方法的调用时机
 *  指定网络请求的方法（并在网络请求的回调里统一调用executeRequestCompleteMethodWithSuccess: data:）和UI更新方法，然后在网络请求中将自动调用
 *  支持action方式和block方式
 */

#define     FUNC(target, sel, data)     

@interface ZZFLEXRequestModel : NSObject

@property (nonatomic, assign, readonly) NSInteger tag;

/// 请求是否成功
@property (nonatomic, assign, readonly) BOOL success;
/// 请求结果数据
@property (nonatomic, strong, readonly) id data;

@property (nonatomic, strong) id userInfo;

#pragma mark - # Action 方式
@property (nonatomic, weak, readonly) id target;

/// Method，数据请求方法
@property (nonatomic, assign, readonly) SEL requestMethod;

/// Method，请求完成调用
@property (nonatomic, assign, readonly) SEL requestCompleteMethod;

#pragma mark - # Block 方式
@property (nonatomic, copy, readonly) void (^requestAction)(ZZFLEXRequestModel *);

@property (nonatomic, copy, readonly) void (^requestCompleteAction)(ZZFLEXRequestModel *);

#pragma mark - # 队列用
@property (nonatomic, weak) id queueTarget;

@property (nonatomic, assign) SEL queueMethod;

#pragma mark - # 公开方法
+ (ZZFLEXRequestModel *)requestModelWithTag:(NSInteger)tag
                                   target:(id)target
                            requestMethod:(SEL)requestMethod
                    requestCompleteMethod:(SEL)requestCompleteMethod;

+ (ZZFLEXRequestModel *)requestModelWithTag:(NSInteger)tag
                            requestAction:(void (^)(ZZFLEXRequestModel *requestModel))requestAction
                    requestCompleteAction:(void (^)(ZZFLEXRequestModel *requestModel))requestCompleteAction;

/**
 *  执行网络请求方法
 */
- (void)executeRequestMethod;

/**
 *  执行网络请求完成方法
 */
- (void)executeRequestCompleteMethodWithSuccess:(BOOL)success data:(id)data;

@end
