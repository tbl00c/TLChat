//
//  TLNetworkUtility.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLNetworkUtility.h"

@implementation TLNetworkUtility

+ (NSString *)requestMethodStringByMethod:(TLRequestMethod)method
{
    switch (method) {
        case TLRequestMethodGET:
            return @"GET";
        case TLRequestMethodPOST:
            return @"POST";
        case TLRequestMethodPUT:
            return @"PUT";
        case TLRequestMethodHEAD:
            return @"HEAD";
        case TLRequestMethodPATCH:
            return @"PATCH";
        case TLRequestMethodDELETE:
            return @"DELETE";
        case TLRequestMethodOPTIONS:
            return @"OPTIONS";
        case TLRequestMethodCONNECT:
            return @"CONNECT";
        case TLRequestMethodTRACE:
            return @"TRACE";
        default:
            break;
    }
    return @"GET";
}

+ (NSString *)sharedCookie
{
    return nil;
}


@end
