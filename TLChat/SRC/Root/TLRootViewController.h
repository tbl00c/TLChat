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

- (id)childViewControllerAtIndex:(NSUInteger)index;

@end
