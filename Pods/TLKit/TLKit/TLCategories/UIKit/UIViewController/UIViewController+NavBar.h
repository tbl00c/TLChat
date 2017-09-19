//
//  UIViewController+NavBar.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+Action.h"

@interface UIViewController (NavBar)

/// 添加消失BarButton（左侧)
- (void)addDismissBarButtonWithTitle:(NSString *)title;

/// 左侧文字BarButton
- (void)addLeftBarButtonWithTitle:(NSString *)title actionBlick:(TLBarButtonActionBlock)actionBlock;
/// 左侧图片BarButton
- (void)addLeftBarButtonWithImage:(UIImage *)image actionBlick:(TLBarButtonActionBlock)actionBlock;

/// 右侧文字BarButton
- (void)addRightBarButtonWithTitle:(NSString *)title actionBlick:(TLBarButtonActionBlock)actionBlock;
/// 右侧图片BarButton
- (void)addRightBarButtonWithImage:(UIImage *)image actionBlick:(TLBarButtonActionBlock)actionBlock;

@end
