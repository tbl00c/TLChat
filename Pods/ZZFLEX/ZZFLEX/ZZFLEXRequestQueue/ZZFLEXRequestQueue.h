//
//  ZZFLEXRequestQueue.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/28.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFLEXRequestModel.h"

/**
 *  网络数据请求队列
 *
 *  用于支持同时发起网络请求，顺序处理（根据队列顺序）请求结果的业务场景
 */
@interface ZZFLEXRequestQueue : NSObject

/// 是否正在请求中
@property (nonatomic, assign, readonly) BOOL isRuning;

/// 请求队列元素个数
@property (nonatomic, assign, readonly) NSInteger requestCount;

- (void)addRequestModel:(ZZFLEXRequestModel *)model;

- (void)runAllRequestsWithCompleteAction:(void (^)(NSArray *data, NSInteger successCount, NSInteger failureCount))completeAction;

- (void)cancelAllRequests;

@end
