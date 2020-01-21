//
//  TLBaseRequest+Private.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLBaseRequest+Private.h"
#import "TLNetworkConfig.h"
#import "TLNetworkSerializer.h"
#import "TLNetworkUtility.h"
#import "NSString+TLNetwork.h"

@implementation TLBaseRequest (Private)

- (NSString *)requestMethodString
{
    return [TLNetworkUtility requestMethodStringByMethod:self.requestMethod];
}

- (NSString *)requestURL
{
    NSString *requestURL = self.url;
    NSURL *url = requestURL.toURL;
    
    // 处理不完整的url
    if (!(url && url.host && url.scheme)) {
        if (self.baseURL.length > 0 && ![self.baseURL hasSuffix:@"/"]) {
            requestURL = [url URLByAppendingPathComponent:@""].absoluteString;
        }
        else {
            requestURL = [NSURL URLWithString:self.url relativeToURL:url].absoluteString;
        }
    }
    
    // 使用mock接口
    if (self.useMock) {
        NSString *apiName = url.lastPathComponent;
        requestURL = [NSString stringWithFormat:@"%@/%@", [TLNetworkConfig sharedConfig].mockBaseURL, apiName];
    }
    
    // https相关
    if ([[TLNetworkConfig sharedConfig].mainScheme isEqualToString:TLURLSchemeHTTPS]) {
        requestURL = [url.absoluteString httpsUrl];
    }
    else if ([[TLNetworkConfig sharedConfig].mainScheme isEqualToString:TLURLSchemeHTTPS]) {
        requestURL = [url.absoluteString httpsUrl];
    }
    
    return [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSURLRequest *)customURLRequest
{
    NSError * __autoreleasing requestSerializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:self.requestMethodString URLString:self.requestURL parameters:self.parameters error:&requestSerializationError];;
    if (requestSerializationError) {
        NSLog(@"TLNetwork: TLBaseRequest序列化失败");
    }
    
    NSString *sharedCookie = [TLNetworkUtility sharedCookie];
    if (sharedCookie.length > 0) {
        [request addValue:sharedCookie forHTTPHeaderField:@"Cookie"];
    }

    return request;
}

- (NSString *)baseURL
{
    return [TLNetworkConfig sharedConfig].baseURL;
}

- (AFHTTPRequestSerializer *)requestSerializer
{
    AFHTTPRequestSerializer *requestSerializer = [TLNetworkSerializer requestSerializerWithType:self.requestSerializerType];
    requestSerializer.timeoutInterval = self.timeoutInterval;
    requestSerializer.allowsCellularAccess = !self.disableCellularAccess;
    for (NSString *key in self.headerField.allKeys) {
        NSString *value = [self.headerField valueForKey:key];
        [requestSerializer setValue:value forHTTPHeaderField:key];
    }
    
    return requestSerializer;
}

@end
