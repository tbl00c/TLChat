//
//  TLAppDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAppDelegate.h"
#import "TLRootViewController.h"

#import <MobClick.h>
#import <AFNetworking.h>
#import <JSPatch/JSPatch.h>
#import "TLFriendHelper.h"

@implementation TLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self p_initAppData];           // 初始化应用信息
    [self p_initUI];                // 初始化UI
//    [self p_initTestUI];
    [self p_initThirdPartSDK];      // 初始化第三方SDK
    [self p_initUserData];          // 初始化用户信息
    
    [self p_urgentMethod];          // 紧急方法
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Methods
- (void)p_initTestUI
{
    NSString *className = @"TLChatViewController";
    id vc = [[NSClassFromString(className) alloc] init];
    [vc setTitle:@"Test"];
    UIViewController *rootVC = [[NSClassFromString(@"TLNavigationController") alloc] initWithRootViewController: vc];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:rootVC];
    [self.window addSubview:rootVC.view];
    [self.window makeKeyAndVisible];
}

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
    TLRootViewController *rootVC = [TLRootViewController sharedRootViewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:rootVC];
    [self.window addSubview:rootVC.view];
    [self.window makeKeyAndVisible];
}

- (void)p_initUserData
{
    [TLUserHelper sharedHelper];
    [TLFriendHelper sharedFriendHelper];
}

- (void)p_initAppData
{

}

- (void)p_urgentMethod
{
    // 由JSPatch重写
}

@end
