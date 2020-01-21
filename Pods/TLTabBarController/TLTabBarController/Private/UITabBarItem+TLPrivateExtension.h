//
//  UITabBarItem+TLPrivateExtension.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/15.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLBadge.h"

/**
 *  增加了一些属性，处理红点
 */

@interface UITabBarItem (TLPrivateExtension)

/// 是不是plusButton，一个标志而已
@property (nonatomic, assign) BOOL isPlusButton;

/// tabBarItem实际控件
@property (nonatomic, strong) UIControl *tabBarControl;

/// 红点view
@property (nonatomic, strong, readonly) TLBadge *tlBadge;

/// 点击事件，默认nil或返回YES执行页面页面跳转
@property (nonatomic, copy) BOOL (^clickActionBlock)();

@end
