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
- (UIBarButtonItem *)addDismissBarButtonWithTitle:(NSString *)title;

/// 左侧文字BarButton
- (UIBarButtonItem *)addLeftBarButtonWithTitle:(NSString *)title actionBlick:(TLBarButtonActionBlock)actionBlock;
/// 左侧图片BarButton
- (UIBarButtonItem *)addLeftBarButtonWithImage:(UIImage *)image actionBlick:(TLBarButtonActionBlock)actionBlock;

/// 右侧文字BarButton
- (UIBarButtonItem *)addRightBarButtonWithTitle:(NSString *)title actionBlick:(TLBarButtonActionBlock)actionBlock;
/// 右侧图片BarButton
- (UIBarButtonItem *)addRightBarButtonWithImage:(UIImage *)image actionBlick:(TLBarButtonActionBlock)actionBlock;

@end
