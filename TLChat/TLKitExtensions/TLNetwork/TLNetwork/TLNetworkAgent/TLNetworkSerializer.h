//
//  TLNetworkSerializer.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "TLRequestMacros.h"

@interface TLNetworkSerializer : NSObject

+ (TLNetworkSerializer *)sharedInstance;

/// 所有响应码
@property (nonatomic, strong, readonly) NSIndexSet *allStatusCodes;

#pragma mark - Request
@property (nonatomic, strong, readonly) AFHTTPRequestSerializer *httpRequestSerializer;

@property (nonatomic, strong, readonly) AFJSONRequestSerializer *jsonRequestSerializer;

@property (nonatomic, strong, readonly) AFPropertyListRequestSerializer *plistRequestSerializer;

+ (AFHTTPRequestSerializer *)requestSerializerWithType:(TLRequestSerializerType)type;

#pragma mark - Response
@property (nonatomic, strong, readonly) AFHTTPResponseSerializer *httpResponseSerializer;

@property (nonatomic, strong, readonly) AFJSONResponseSerializer *jsonResponseSerializer;

@property (nonatomic, strong, readonly) AFXMLParserResponseSerializer *xmlResponseSerializer;

@property (nonatomic, strong, readonly) AFPropertyListResponseSerializer *plistResponseSerializer;

+ (AFHTTPResponseSerializer *)responseSerializerWithType:(TLResponseSerializerType)type;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
