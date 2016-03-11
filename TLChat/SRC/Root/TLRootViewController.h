//
//  TLRootViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTabBarController.h"

@interface TLRootViewController : TLTabBarController

+ (TLRootViewController *) sharedRootViewController;

/**
 *  获取tabbarController的第Index个VC（不是navController）
 *
 *  @return navController的rootVC
 */
- (id)childViewControllerAtIndex:(NSUInteger)index;

@end
