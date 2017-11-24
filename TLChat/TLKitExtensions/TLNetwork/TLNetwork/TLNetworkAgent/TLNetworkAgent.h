//
//  TLNetworkAgent.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

/**
 * 网络请求代理人
 *
 * 所有网络请求由它发起
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define     TLNetworkQueueName      "com.lbk.TLKit.TLNetwork.networkQueue"

@class TLBaseRequest;
@interface TLNetworkAgent : NSObject

+ (instancetype)sharedAgent;

/**
 * 添加新的网络请求
 */
- (void)addRequest:(__kindof TLBaseRequest *)request;

/**
 * 取消网络请求
 */
- (void)cancelRequest:(__kindof TLBaseRequest *)request;

/**
 * 取消所有网络请求
 */
- (void)cancelAllRequests;

/// 所有网络请求
@property (nonatomic, strong, readonly) NSArray<__kindof TLBaseRequest *> *allRequests;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
