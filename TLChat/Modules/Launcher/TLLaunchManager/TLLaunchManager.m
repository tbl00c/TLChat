//
//  TLLaunchManager.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLLaunchManager.h"
#import "TLLaunchManager+UserData.h"
#import "TLUserHelper.h"

#import "TLConversationViewController.h"
#import "TLContactsViewController.h"
#import "TLDiscoverViewController.h"
#import "TLMineViewController.h"
#import "TLAccountViewController.h"

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
    TLConversationViewController *conversationVC = [[TLConversationViewController alloc] init];
    TLContactsViewController *friendsVC = [[TLContactsViewController alloc] init];
    TLDiscoverViewController *discoverVC = [[TLDiscoverViewController alloc] init];
    TLMineViewController *mineVC = [[TLMineViewController alloc] init];
    
    NSArray *data = @[addNavigationController(conversationVC),
                      addNavigationController(friendsVC),
                      addNavigationController(discoverVC),
                      addNavigationController(mineVC),
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

