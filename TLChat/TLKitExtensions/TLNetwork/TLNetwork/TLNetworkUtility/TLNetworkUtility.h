//
//  TLNetworkUtility.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLBaseRequest.h"

@interface TLNetworkUtility : NSObject

+ (NSString *)requestMethodStringByMethod:(TLRequestMethod)method;

+ (NSString *)sharedCookie;

@end
