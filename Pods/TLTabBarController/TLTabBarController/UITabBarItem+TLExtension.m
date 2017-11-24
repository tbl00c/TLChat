//
//  UITabBarItem+TLExtension.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/11/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "UITabBarItem+TLExtension.h"
#import "UITabBarItem+TLPrivateExtension.h"

@implementation UITabBarItem (TLExtension)

- (CGRect)itemRect
{
    return self.tabBarControl.frame;
}

@end
