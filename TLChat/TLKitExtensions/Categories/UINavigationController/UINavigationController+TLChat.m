//
//  UINavigationController+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UINavigationController+TLChat.h"

@implementation UINavigationController (TLChat)

+ (void)load
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontNavBarTitle]}];

    TLExchangeMethod(@selector(loadView), @selector(__tt_loadView));
}

- (void)__tt_loadView
{
    [self __tt_loadView];
    
    [self.navigationBar setBarTintColor:[UIColor colorBlackForNavBar]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
}

@end
