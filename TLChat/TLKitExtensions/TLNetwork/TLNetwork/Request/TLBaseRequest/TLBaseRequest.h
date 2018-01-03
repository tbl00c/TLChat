//
//  TLBaseRequest.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLRequestMacros.h"

@class TLResponse;
@interface TLBaseRequest : NSObject

#pragma mark - 基本请求参数
/// 请求的url，可以不包含域名（域名在TLNetworkConfig中指定）
@property (nonatomic, strong) NSString *url;

/// 请求方式
@property (nonatomic, assign) TLRequestMethod requestMethod;

/// 参数
@property (nonatomic, strong) id parameters;
/// header
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *headerField;

/// 请求成功回调
@property (nonatomic, copy) TLRequestCompletionBlock successAction;
/// 请求失败回调
@property (nonatomic, copy) TLRequestCompletionBlock failureAction;
/// 请求回调
@property (nonatomic, weak) id<TLRequestDelegate> delegate;

#pragma mark - 参数序列化类型
/// 请求参数序列化类型
@property (nonatomic, assign) TLRequestSerializerType requestSerializerType;
/// 响应参数序列化类型
@property (nonatomic, assign) TLResponseSerializerType responseSerializerType;

#pragma mark - 网络请求配置
/// 优先级
@property (nonatomic, assign) TLRequestPriority requestPriority;
/// 超时时间，默认获取TLNetworkConfig中的设置（30s）
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/// 不允许蜂窝数据访问
@property (nonatomic, assign) BOOL disableCellularAccess;

#pragma mark - 公开参数
/// 请求标识
@property (nonatomic, assign) NSInteger tag;
/// 用户自定义信息
@property (nonatomic, strong) id userInfo;
/// 网络请求状态
@property (nonatomic, assign, readonly) TLRequestState state;

/// 请求任务sessionTask
@property (nonatomic, strong) NSURLSessionTask *requestTask;

#pragma mark - MOCK
@property (nonatomic, assign) BOOL useMock;

#pragma mark - 初始化Request
/**
 * 初始化
 *
 * @param method 请求方式
 * @param url    url地址
 * @param parameters 请求参数
 */
- (instancetype)initWithMethod:(TLRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters;
/**
 * 类初始化方法
 */
+ (instancetype)requestWithMethod:(TLRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters;
- (instancetype)init __attribute__((unavailable("请使用 initWithMethod:url:params: 或者 requestWithMethod:url:params:")));

#pragma mark - 请求发起与终止
/**
 * 发起网络请求
 *
 * @param successAction 成功回调
 * @param failureAction 失败回调
 */
- (void)startRequestWithSuccessAction:(TLRequestCompletionBlock)successAction
                        failureAction:(TLRequestCompletionBlock)failureAction;

/**
 * 发起网络请求
 */
- (void)startRequest;

/**
 * 取消网络请求
 */
- (void)cancelRequest;

@end
