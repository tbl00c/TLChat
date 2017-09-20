
//
//  TLSDKManager.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLSDKManager.h"
#import <AFNetworking.h>
#import <JSPatchPlatform/JSPatch.h>
#import "TLSDKConfigKey.h"

@implementation TLSDKManager

+ (TLSDKManager *)sharedInstance
{
    static TLSDKManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)launchInWindow:(UIWindow *)window
{
    // 友盟统计
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH channelId:APP_CHANNEL];
    
    // 网络环境监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // JSPatch
#ifdef DEBUG_JSPATCH
    [JSPatch testScriptInBundle];
#else
    [JSPatch startWithAppKey:JSPATCH_APPKEY];
    [JSPatch sync];
#endif
    
    // Mob SMS
    //    [SMSSDK registerApp:MOB_SMS_APPKEY withSecret:MOB_SMS_SECRET];
    
    // 日志
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];

}

@end
