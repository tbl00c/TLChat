//
//  TLBaseRequest.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLBaseRequest.h"
#import "TLNetworkConfig.h"
#import "TLNetworkAgent.h"
#import "TLResponse.h"

#define     TL_NSURLSessionTaskPriorityHigh         0.75
#define     TL_NSURLSessionTaskPriorityLow          0.25
#define     TL_NSURLSessionTaskPriorityDefault      0.50

@implementation TLBaseRequest

+ (instancetype)requestWithMethod:(TLRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters
{
    return [[self alloc] initWithMethod:method url:url parameters:parameters];
}

- (instancetype)initWithMethod:(TLRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters
{
    if (self = [super init]) {
        self.requestMethod = method;
        self.url = url;
        self.parameters = parameters;
        self.requestPriority = TLRequestPriorityDefault;
        
        self.timeoutInterval = [TLNetworkConfig sharedConfig].timeoutIntervalForRequest;
        self.requestSerializerType = [TLNetworkConfig sharedConfig].requestSerializerType;
        self.responseSerializerType = [TLNetworkConfig sharedConfig].responseSerializerType;
        self.headerField = [TLNetworkConfig sharedConfig].headerField;
    }
    return self;
}

#pragma mark - # Public Methods
- (void)startRequestWithSuccessAction:(TLRequestCompletionBlock)successAction failureAction:(TLRequestCompletionBlock)failureAction
{
    [self setSuccessAction:successAction];
    [self setFailureAction:failureAction];
    [self startRequest];
}

- (void)startRequest
{
    [[TLNetworkAgent sharedAgent] addRequest:self];
}

- (void)cancelRequest
{
    [[TLNetworkAgent sharedAgent] cancelRequest:self];
}

- (void)setRequestTask:(NSURLSessionTask *)requestTask
{
    _requestTask = requestTask;
    
    // 在iOS8的一些系统上，直接使用NSURLSessionTaskPriorityHigh／Low／Default等值，由于编译器等的优化，会出现莫名其妙的崩溃，rdar地址：http://www.openradar.me/23956486 , 所以我们直接使用其float值
    if ([requestTask respondsToSelector:@selector(priority)]) {
        switch (self.requestPriority) {
            case TLRequestPriorityHigh:
                self.requestTask.priority = TL_NSURLSessionTaskPriorityHigh;
                break;
            case TLRequestPriorityLow:
                self.requestTask.priority = TL_NSURLSessionTaskPriorityLow;
                break;
            case TLRequestPriorityDefault:
                self.requestTask.priority = TL_NSURLSessionTaskPriorityDefault;
                break;
            default:
                self.requestTask.priority = TL_NSURLSessionTaskPriorityDefault;
                break;
        }
    }
}

#pragma mark - # Getters
- (TLRequestState)state
{
    if (!self.requestTask) {
        return TLRequestStateSuspended;
    }
    switch (self.requestTask.state) {
        case NSURLSessionTaskStateRunning:
            return TLRequestStateRunning;
        case NSURLSessionTaskStateSuspended:
            return TLRequestStateSuspended;
        case NSURLSessionTaskStateCanceling:
            return TLRequestStateCanceling;
        case NSURLSessionTaskStateCompleted:
            return TLRequestStateCompleted;
        default:
            break;
    }
    return TLRequestStateSuspended;
}

@end
