//
//  TLResponse.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLResponse.h"
#import "NSHTTPURLResponse+TLNetwork.h"
#import "TLNetworkSerializer.h"

@implementation TLResponse

- (id)initWithRequest:(__kindof TLBaseRequest *)request responseData:(id)responseData error:(NSError *)error
{
    if (self = [super init]) {
        _request = request;
        _responseData = responseData;
        _responseString = responseData;
        _error = error;
        
        if (error || !responseData) {
            _success = NO;
        }
        else {
            _success = YES;
        }
        if ([responseData isKindOfClass:[NSData class]]) {
            _responseString = [[NSString alloc] initWithData:responseData encoding:self.customResponse.stringEncoding];
            AFHTTPResponseSerializer *serializer = [TLNetworkSerializer responseSerializerWithType:request.responseSerializerType];
            _responseData = [serializer responseObjectForResponse:self.customResponse data:responseData error:&error];
            _error = error;
            _success = (!self.error && self.statusCode / 100 == 2);
        }
    }
    return self;
}

#pragma mark - # Getters
- (NSURLSessionTask *)requestTask
{
    return self.request.requestTask;
}

- (NSHTTPURLResponse *)customResponse
{
    return (NSHTTPURLResponse *)self.requestTask.response;
}

- (NSInteger)statusCode
{
    return self.customResponse.statusCode;
}

- (NSDictionary *)headerFields
{
    return self.customResponse.allHeaderFields;
}

- (NSInteger)tag
{
    return self.request.tag;
}

- (id)userInfo
{
    return self.request.userInfo;
}

- (id)responseObject
{
    if (!_responseObject) {
        return self.responseData;
    }
    return _responseObject;
}

@end
