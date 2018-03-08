
//
//  TLSDKManager.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLSDKManager.h"
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
    [[UMAnalyticsConfig sharedInstance] setAppKey:UMENG_APPKEY];
    [[UMAnalyticsConfig sharedInstance] setEPolicy:BATCH];
    [[UMAnalyticsConfig sharedInstance] setChannelId:APP_CHANNEL];
    [MobClick startWithConfigure:[UMAnalyticsConfig sharedInstance]];

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
