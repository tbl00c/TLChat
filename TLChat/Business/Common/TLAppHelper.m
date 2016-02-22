//
//  TLAppHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAppHelper.h"

static TLAppHelper *helper;

@implementation TLAppHelper

+ (TLAppHelper *)sharedHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[TLAppHelper alloc] init];
    });
    return helper;
}

- (NSString *)version
{
    if (_version == nil) {
        _version = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
    }
    return _version;
}

@end
