//
//  TLAppDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAppDelegate.h"
#import "TLRootViewController.h"

#import "TLRootProxy.h"
#import "TLExpressionProxy.h"
#import "TLExpressionHelper.h"

#import <AFNetworking.h>
#import <JSPatch/JSPatch.h>
//#import <SMS_SDK/SMSSDK.h>

@implementation TLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self p_initThirdPartSDK];      // 初始化第三方SDK
    [self p_initAppData];           // 初始化应用信息
    [self p_initUserData];          // 初始化用户信息
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    TLRootViewController *rootVC = [TLRootViewController sharedRootViewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:rootVC];
    [self.window addSubview:rootVC.view];
    [self.window makeKeyAndVisible];
}

- (void)p_initUserData
{
    DDLogVerbose(@"沙盒路径:\n%@", [NSFileManager documentsPath]);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirstRunApp"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"IsFirstRunApp"];
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"首次启动App，是否随机下载两组个性表情包，稍候也可在“我的”-“表情”中选择下载。" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self p_downloadDefaultExpression];
            }
        }];
    }
    [TLUserHelper sharedHelper];
    [TLFriendHelper sharedFriendHelper];
}

- (void)p_downloadDefaultExpression
{
    [SVProgressHUD show];
    __block NSInteger count = 0;
    __block NSInteger successCount = 0;
    TLExpressionProxy *proxy = [[TLExpressionProxy alloc] init];
    TLEmojiGroup *group = [[TLEmojiGroup alloc] init];
    group.groupID = @"241";
    group.groupName = @"婉转的骂人";
    group.groupIconURL = @"http://123.57.155.230:8080/ibiaoqing/admin/expre/downloadsuo.do?pId=10790";
    group.groupInfo = @"婉转的骂人";
    group.groupDetailInfo = @"婉转的骂人表情，慎用";
    [proxy requestExpressionGroupDetailByGroupID:group.groupID pageIndex:1 success:^(id data) {
        group.data = data;
        [[TLExpressionHelper sharedHelper] downloadExpressionsWithGroupInfo:group progress:^(CGFloat progress) {
            
        } success:^(TLEmojiGroup *group) {
            BOOL ok = [[TLExpressionHelper sharedHelper] addExpressionGroup:group];
            if (!ok) {
                DDLogError(@"表情存储失败！");
            }
            else {
                successCount ++;
            }
            count ++;
            if (count == 2) {
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功下载%ld组表情！", (long)successCount]];
            }
        } failure:^(TLEmojiGroup *group, NSString *error) {
            
        }];
    } failure:^(NSString *error) {
        count ++;
        if (count == 2) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功下载%ld组表情！", (long)successCount]];
        }
    }];
    
    
    TLEmojiGroup *group1 = [[TLEmojiGroup alloc] init];
    group1.groupID = @"223";
    group1.groupName = @"王锡玄";
    group1.groupIconURL = @"http://123.57.155.230:8080/ibiaoqing/admin/expre/downloadsuo.do?pId=10482";
    group1.groupInfo = @"王锡玄 萌娃 冷笑宝宝";
    group1.groupDetailInfo = @"韩国萌娃，冷笑宝宝王锡玄表情包";
    [proxy requestExpressionGroupDetailByGroupID:group1.groupID pageIndex:1 success:^(id data) {
        group1.data = data;
        [[TLExpressionHelper sharedHelper] downloadExpressionsWithGroupInfo:group1 progress:^(CGFloat progress) {
            
        } success:^(TLEmojiGroup *group) {
            BOOL ok = [[TLExpressionHelper sharedHelper] addExpressionGroup:group];
            if (!ok) {
                DDLogError(@"表情存储失败！");
            }
            else {
                successCount ++;
            }
            count ++;
            if (count == 2) {
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功下载%ld组表情！", (long)successCount]];
            }
        } failure:^(TLEmojiGroup *group, NSString *error) {
            
        }];
    } failure:^(NSString *error) {
        count ++;
        if (count == 2) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功下载%ld组表情！", (long)successCount]];
        }
    }];
}

- (void)p_initAppData
{
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
