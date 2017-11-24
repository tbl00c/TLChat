//
//  TLResponse.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLBaseRequest.h"

@interface TLResponse : NSObject

/// 是否成功
@property (nonatomic, assign, readonly) BOOL success;

/// 状态码
@property (nonatomic, assign, readonly) NSInteger statusCode;

/// 响应头
@property (nonatomic, strong, readonly) NSDictionary *headerFields;

/// 响应体模型
@property (nonatomic, strong) id responseObject;

/// 响应体（已经序列化）
@property (nonatomic, strong, readonly) id responseData;

/// 响应体->字符串
@property (nonatomic, strong, readonly) NSString *responseString;

/// 错误信息
@property (nonatomic, strong, readonly) NSError *error;

#pragma mark - Request相关
/// request模型
@property (nonatomic, strong, readonly) __kindof TLBaseRequest *request;
/// 请求标识（Request）
@property (nonatomic, assign, readonly) NSInteger tag;
/// 用户自定义信息（Request）
@property (nonatomic, strong, readonly) id userInfo;

#pragma mark - 私有响应参数
/// 请求任务sessionTask（从TLBaseRequest中获取）
@property (nonatomic, strong, readonly) NSURLSessionTask *requestTask;
/// 系统网络请求响应模型
@property (nonatomic, strong, readonly) NSHTTPURLResponse *customResponse;

/**
 * 初始化
 *
 * @param request 网络请求模型
 * @param responseData 请求响应体（未经处理）
 * @param error 错误信息
 */
- (id)initWithRequest:(__kindof TLBaseRequest *)request responseData:(id)responseData error:(NSError *)error;

@end
