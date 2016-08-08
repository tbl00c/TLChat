//
//  TLHost.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLHost.h"

#ifdef  DEBUG_LOCAL_SERVER
#define     HOST_URL        @"http://127.0.0.1:8000/"            // 本地测试服务器
#else
#define     HOST_URL        @"http://121.42.29.15:8000/"         // 远程线上服务器
#endif

@implementation TLHost

+ (NSString *)clientInitInfoURL
{
    return [HOST_URL stringByAppendingString:@"client/getClientInitInfo/"];
}

+ (NSString *)expressionURLWithEid:(NSString *)eid
{
    return [NSString stringWithFormat:@"%@expre/downloadsuo.do?pId=%@", IEXPRESSION_HOST_URL, eid];
}

+ (NSString *)expressionDownloadURLWithEid:(NSString *)eid
{
    return [NSString stringWithFormat:@"%@expre/download.do?pId=%@", IEXPRESSION_HOST_URL, eid];
}

@end
