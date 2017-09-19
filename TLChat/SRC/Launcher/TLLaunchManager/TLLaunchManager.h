//
//  TLLaunchManager.h
//  TLChat
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TLTabBarController/TLTabBarController.h>
#import "UITabBarController+TLLaunchExtension.h"

@interface TLLaunchManager : NSObject

@property (nonatomic, strong, readonly) TLTabBarController *rootVC;

+ (TLLaunchManager *)sharedInstance;

- (void)launchInWindow:(UIWindow *)window;




@end
