//
//  UIViewController+PopGesture.h
//  TLChat
//
//  Created by 李伯坤 on 2017/9/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopGesture) <UIGestureRecognizerDelegate>

/// 禁用手势返回（默认为NO）
@property (nonatomic, assign) BOOL disablePopGesture;

@end
