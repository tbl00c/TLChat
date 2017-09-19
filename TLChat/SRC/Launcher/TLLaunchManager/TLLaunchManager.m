//
//  TLLaunchManager.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLLaunchManager.h"
#import "TLLaunchManager+UserData.h"

#import "TLNavigationController.h"

#import "TLAccountViewController.h"

#import "TLConversationViewController.h"
#import "TLFriendsViewController.h"
#import "TLDiscoverViewController.h"
#import "TLMineViewController.h"


void addBarChildViewController(UITabBarController *tabBarController, UIViewController *vc, NSString *title, NSString *image, NSString *imageHL)
{
    [vc.tabBarItem setTitle:title];
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:imageHL]];
    TLNavigationController *navC = [[TLNavigationController alloc] initWithRootViewController:vc];
    [tabBarController addChildViewController:navC];
}

@implementation TLLaunchManager
@synthesize rootVC = _rootVC;

+ (TLLaunchManager *)sharedInstance
{
    static TLLaunchManager *rootVCManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVCManager = [[TLLaunchManager alloc] init];
    });
    return rootVCManager;
}

- (id)init
{
    if (self = [super init]) {
        _rootVC = [[TLTabBarController alloc] init];
        [self.rootVC.tabBar setBackgroundColor:[UIColor colorGrayBG]];
        [self.rootVC.tabBar setTintColor:[UIColor colorGreenDefault]];
        
        [self p_initChildViewController];
    }
    return self;
}

- (void)launchInWindow:(UIWindow *)window
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIViewController *rootVC;
    if ([TLUserHelper sharedHelper].isLogin) {
        rootVC = self.rootVC;
        [self initUserData];          // 初始化用户信息
    }
    else {
        rootVC = [[TLAccountViewController alloc] init];
        TLWeakSelf(self);
        TLWeakSelf(rootVC)
        [(TLAccountViewController *)rootVC setLoginSuccess:^{
            [weakself initUserData];          // 初始化用户信息
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [weakrootVC.view removeFromSuperview];
            [window setRootViewController:weakself.rootVC];
            [window addSubview:weakself.rootVC.view];
        }];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [window setRootViewController:self.rootVC];
    [window addSubview:self.rootVC.view];
    [window makeKeyAndVisible];
}

- (void)p_initChildViewController
{
    addBarChildViewController(self.rootVC, [[TLConversationViewController alloc] init], @"消息", @"tabbar_mainframe", @"tabbar_mainframeHL");
    addBarChildViewController(self.rootVC, [[TLFriendsViewController alloc] init], @"通讯录", @"tabbar_contacts", @"tabbar_contactsHL");
    addBarChildViewController(self.rootVC, [[TLDiscoverViewController alloc] init], @"发现", @"tabbar_discover", @"tabbar_discoverHL");
    addBarChildViewController(self.rootVC, [[TLMineViewController alloc] init], @"我", @"tabbar_me", @"tabbar_meHL");
}

@end

