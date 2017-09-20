//
//  TLLaunchManager.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLLaunchManager.h"
#import "TLLaunchManager+UserData.h"

#import "TLAccountViewController.h"

#import "TLConversationViewController.h"
#import "TLFriendsViewController.h"
#import "TLDiscoverViewController.h"
#import "TLMineViewController.h"

#import "TLUserHelper.h"

void addBarChildViewController(UITabBarController *tabBarController, UIViewController *vc, NSString *title, NSString *image, NSString *imageHL)
{
    [vc.tabBarItem setTitle:title];
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:imageHL]];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    [tabBarController addChildViewController:navC];
}

@implementation TLLaunchManager
@synthesize rootVC = _rootVC;

+ (TLLaunchManager *)sharedInstance
{
    static TLLaunchManager *rootVCManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVCManager = [[self alloc] init];
    });
    return rootVCManager;
}

- (void)launchInWindow:(UIWindow *)window
{
    [window removeAllSubviews];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIViewController *rootVC;
    if ([TLUserHelper sharedHelper].isLogin) {      // 已登录
        [self p_resetRootVC];
        
        rootVC = self.rootVC;
        // 初始化用户信息
        [self initUserData];
    }
    else {  // 未登录
        rootVC = [[TLAccountViewController alloc] init];
        @weakify(self);
        [(TLAccountViewController *)rootVC setLoginSuccess:^{
            @strongify(self);
            [self launchInWindow:window];
        }];
    }
    
    [window setRootViewController:rootVC];
    [window addSubview:rootVC.view];
    [window makeKeyAndVisible];
}

#pragma mark - # Private Methods
- (void)p_resetRootVC
{
    _rootVC = nil;
    
    addBarChildViewController(self.rootVC, [[TLConversationViewController alloc] init], @"消息", @"tabbar_mainframe", @"tabbar_mainframeHL");
    addBarChildViewController(self.rootVC, [[TLFriendsViewController alloc] init], @"通讯录", @"tabbar_contacts", @"tabbar_contactsHL");
    addBarChildViewController(self.rootVC, [[TLDiscoverViewController alloc] init], @"发现", @"tabbar_discover", @"tabbar_discoverHL");
    addBarChildViewController(self.rootVC, [[TLMineViewController alloc] init], @"我", @"tabbar_me", @"tabbar_meHL");
}

#pragma mark - # Getters
- (TLTabBarController *)rootVC
{
    if (!_rootVC) {
        _rootVC = [[TLTabBarController alloc] init];
        [_rootVC.tabBar setBackgroundColor:[UIColor colorGrayBG]];
        [_rootVC.tabBar setTintColor:[UIColor colorGreenDefault]];
    }
    return _rootVC;
}

@end

