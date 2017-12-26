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

__kindof UINavigationController *__createTabBarChildVC(__kindof UIViewController *vc, NSString *title, NSString *image, NSString *imageHL)
{
    [vc.tabBarItem setTitle:title];
    [vc.tabBarItem setImage:[UIImage imageNamed:image]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:imageHL]];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    return navC;
}

@interface TLLaunchManager ()

@property (nonatomic, weak) UIWindow *window;

@end

@implementation TLLaunchManager
@synthesize tabBarController = _tabBarController;

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
    self.window = window;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([TLUserHelper sharedHelper].isLogin) {      // 已登录
        [self.tabBarController setViewControllers:[self p_createTabBarChildViewController]];
        [self setCurRootVC:self.tabBarController];
        
        // 初始化用户信息
        [self initUserData];
    }
    else {  // 未登录
        TLAccountViewController *accountVC = [[TLAccountViewController alloc] init];
        @weakify(self);
        [accountVC setLoginSuccess:^{
            @strongify(self);
            [self launchInWindow:window];
        }];
        [self setCurRootVC:accountVC];
    }
}

- (void)setCurRootVC:(__kindof UIViewController *)curRootVC
{
    _curRootVC = curRootVC;
    
    {
        UIWindow *window = self.window ? self.window : [UIApplication sharedApplication].keyWindow;
        [window removeAllSubviews];
        [window setRootViewController:curRootVC];
        [window addSubview:curRootVC.view];
        [window makeKeyAndVisible];
    }
}

#pragma mark - # Private Methods
- (NSArray *)p_createTabBarChildViewController
{
    NSArray *data = @[__createTabBarChildVC([[TLConversationViewController alloc] init], @"消息", @"tabbar_mainframe", @"tabbar_mainframeHL"),
                      __createTabBarChildVC([[TLFriendsViewController alloc] init], @"通讯录", @"tabbar_contacts", @"tabbar_contactsHL"),
                      __createTabBarChildVC([[TLDiscoverViewController alloc] init], @"发现", @"tabbar_discover", @"tabbar_discoverHL"),
                      __createTabBarChildVC([[TLMineViewController alloc] init], @"我", @"tabbar_me", @"tabbar_meHL"),
                      ];
    return data;
}


#pragma mark - # Getters
- (TLTabBarController *)tabBarController
{
    if (!_tabBarController) {
        TLTabBarController *tabbarController = [[TLTabBarController alloc] init];
        [tabbarController.tabBar setBackgroundColor:[UIColor colorGrayBG]];
        [tabbarController.tabBar setTintColor:[UIColor colorGreenDefault]];
        _tabBarController = tabbarController;
    }
    return _tabBarController;
}

@end

