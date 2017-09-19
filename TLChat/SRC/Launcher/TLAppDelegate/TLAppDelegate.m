//
//  TLAppDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAppDelegate.h"
#import "TLLaunchManager.h"
#import "TLRootProxy.h"

#import <AFNetworking.h>
#import <JSPatch/JSPatch.h>
//#import <SMS_SDK/SMSSDK.h>

@implementation TLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self p_initThirdPartSDK];      // 初始化第三方SDK
    [self p_initAppData];           // 初始化应用信息
    [self p_initUI];                // 初始化UI
    
    [self p_urgentMethod];          // 紧急方法
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - Private Methods
- (void)p_initThirdPartSDK
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
    
    // 提示框
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    // 日志
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

- (void)p_initUI
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[TLLaunchManager sharedInstance] launchInWindow:self.window];
}

- (void)p_initAppData
{
    DDLogVerbose(@"沙盒路径:\n%@", [NSFileManager documentsPath]);
    
    TLRootProxy *proxy = [[TLRootProxy alloc] init];
    [proxy requestClientInitInfoSuccess:^(id data) {
        
    } failure:^(NSString *error) {
        
    }];
}

- (void)p_urgentMethod
{
    // 由JSPatch重写
}

@end
