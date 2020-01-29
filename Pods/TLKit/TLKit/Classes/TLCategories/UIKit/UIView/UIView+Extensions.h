//
//  UIView+Extensions.h
//  TLKit
//
//  Created by 李伯坤 on 2017/8/27.
//  Copyright © 2017年 libokun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

/**
 * 获取view所在的controller
 */
@property (nonatomic, weak, readonly) UIViewController *viewController;

/**
 * 获取view所在的navigationController
 */
@property (nonatomic, weak, readonly) UINavigationController *navigationController;

/**
 * 当前view是不是正在屏幕上展示了
 */
@property (nonatomic, assign, readonly) BOOL isShowInScreen;

/**
 * 移除所有子视图
 */
- (void)removeAllSubviews;

/**
 *  找到指定类名的SubView对象
 */
- (id)findSubViewWithClass:(Class)subViewClass;

/**
 *  找到指定类名的SuperView对象
 */
- (id)findSuperViewWithClass:(Class)superViewClass;

/**
 *  找到第一响应者
 */
- (UIView *)findFirstResponder;

@property (nonatomic, strong) NSString *stringTag;

@end
