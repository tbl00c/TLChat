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
    
    [self.navigationBar setBarTintColor:[TLColorUtility colorNavBarBarTint]];
    [self.navigationBar setTintColor:[TLColorUtility colorNavBarTint]];
    [self.view setBackgroundColor:[TLColorUtility colorTableViewBG]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
