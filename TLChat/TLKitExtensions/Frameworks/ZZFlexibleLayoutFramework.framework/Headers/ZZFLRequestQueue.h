//
//  ZZFLRequestQueue.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by 李伯坤 on 2016/12/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFLRequestModel.h"

/**
 *  网络数据请求队列
 *
 *  用于支持同时发起网络请求，顺序处理（根据队列顺序）请求结果的业务场景
 */
@interface ZZFLRequestQueue : NSObject

@property (nonatomic, assign, readonly) BOOL isRuning;

@property (nonatomic, assign, readonly) NSInteger requestCount;

- (void)addRequestModel:(ZZFLRequestModel *)model;

- (void)runAllRequestsWithCompleteAction:(void (^)(NSArray *data, NSInteger successCount, NSInteger failureCount))completeAction;

- (void)cancelAllRequests;

@end
