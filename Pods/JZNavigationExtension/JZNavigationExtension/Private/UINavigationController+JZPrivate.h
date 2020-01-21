//
//  UINavigationController+JZPrivate.h
//  navbarTest
//
//  Created by 李伯坤 on 2017/11/22.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class _JZNavigationDelegating;
@interface UINavigationController (JZPrivate) <UINavigationBarDelegate>

@property (nonatomic, weak) _JZNavigationDelegating *jz_navigationDelegate;
@property (nonatomic, assign) UINavigationControllerOperation jz_operation;

@end
