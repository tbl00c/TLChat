//
//  TLNetworkConfig.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLNetworkConfig.h"
#import <SDWebImage/SDWebImageManager.h>
#import <AFNetworking/AFNetworking.h>
#import "NSString+TLNetwork.h"

@implementation TLNetworkConfig

+ (TLNetworkConfig *)sharedConfig
{
    static TLNetworkConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

- (id)init
{
    if (self = [super init]) {
        _baseURL = @"";
        _mockBaseURL = @"";
        
        _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionConfiguration.timeoutIntervalForRequest = TLNetworkRequestTimeoutInterval;
        
        _requestSerializerType = TLRequestSerializerTypeJSON;
        _responseSerializerType = TLResponseSerializerTypeJSON;
        
        _headerField = @{@"content-type" : @"text/html",
                         @"User-Agent" : @"test"};
        
        [self downgradeToHTTP];
    }
    return self;
}

- (void)downgradeToHTTP
{
    // 设定SDWebImageManager图片存储url key规则
    [[SDWebImageManager sharedManager] setCacheKeyFilter:nil];
    
    _mainScheme = TLURLSchemeHTTP;
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = YES;
    _securityPolicy = securityPolicy;
}

- (void)upgradeToHTTPS
{
    // 设定SDWebImageManager图片存储url key规则
    [[SDWebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url) {
        return [url.absoluteString httpsUrl];
    }];
    
    _mainScheme = TLURLSchemeHTTPS;
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = NO;
    securityPolicy.validatesDomainName = YES;
    _securityPolicy = securityPolicy;
}

#pragma mark - # Getters
- (NSTimeInterval)timeoutIntervalForRequest
{
    return self.sessionConfiguration.timeoutIntervalForRequest;
}

@end
