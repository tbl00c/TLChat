//
//  TLNavigationController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNavigationController.h"

@implementation TLNavigationController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setBarTintColor:[UIColor colorNavBarBarTint]];
    [self.navigationBar setTintColor:[UIColor colorNavBarTint]];
    [self.view setBackgroundColor:[UIColor colorTableViewBG]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0f]}];
}

@end
