//
//  UITabBar+TLExtension.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/15.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (TLExtension)

@property (nonatomic, assign) CGFloat plusButtonImageOffset;

/**
 *  tabbar顶部线
 */
- (void)setHiddenShadow:(BOOL)hiddenShadow;

/**
 *  tabbar顶部黑线颜色
 */
- (void)setShadowColor:(UIColor *)shadowColor;

@end
