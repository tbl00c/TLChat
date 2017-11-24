//
//  NSMutableURLRequest+TLNetwork.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "NSMutableURLRequest+TLNetwork.h"
#import <AFNetworking/AFNetworking.h>

@implementation NSMutableURLRequest (TLNetwork)

+ (NSMutableURLRequest *)tt_mutableURLRequestWithSerializer:(AFHTTPRequestSerializer *)serializer
                                                     method:(NSString *)method
                                                  URLString:(NSString *)urlString
                                                 parameters:(id)parameters
                                  constructingBodyWithBlock:(TLConstructingBlock)constructingBodyWithBlock
                                                      error:(NSError *__autoreleasing *)error;
{
    NSMutableURLRequest *request;
    if (constructingBodyWithBlock) {
        request = [serializer multipartFormRequestWithMethod:method
                                                   URLString:urlString
                                                  parameters:parameters
                                   constructingBodyWithBlock:constructingBodyWithBlock
                                                       error:error];
    } else {
        request = [serializer requestWithMethod:method
                                      URLString:urlString
                                     parameters:parameters
                                          error:error];
    }
    return request;
}

@end
