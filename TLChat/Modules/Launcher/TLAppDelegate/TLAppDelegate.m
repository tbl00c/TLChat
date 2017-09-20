//
//  TLAppDelegate.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAppDelegate.h"
#import "TLLaunchManager.h"
#import "TLSDKManager.h"

#import "TLWalletViewController.h"

@implementation TLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 初始化第三方SDK
    [[TLSDKManager sharedInstance] launchInWindow:self.window];
    
    // 初始化UI
    [[TLLaunchManager sharedInstance] launchInWindow:self.window];
    
    // 紧急方法，可使用JSPatch重写
    [self urgentMethod];
    
    return YES;
}

- (void)urgentMethod
{
    @weakify(self);
    [TLUIUtility showAlertWithTitle:@"LBK WARNING"
                            message:@"由于近期正在进行项目组织结构的优化，某些地方感觉比较懵逼属于正常现象，因为我可能只做完了一半~"
                  cancelButtonTitle:@"取消"
                  otherButtonTitles:@[@"小额赞助"]
                      actionHandler:^(NSInteger buttonIndex) {
                          if (buttonIndex == 1) {
                              @strongify(self);
                              TLWalletViewController *wallerVC = [[TLWalletViewController alloc] init];
                              UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:wallerVC];
                              [wallerVC addDismissBarButtonWithTitle:@"取消"];
                              [self.window.visibleViewController presentViewController:navC animated:YES completion:nil];
                          }
                      }];
}

@end
