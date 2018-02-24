//
//  UIControl+ZZEvent.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/27.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZZEvent)

/**
 *  添加点击事件
 *
 *  @param controlEvents 点击事件类型
 *  @param handlerBlock  点击回调
 */
- (void)addControlEvents:(UIControlEvents)controlEvents
                 handler:(void (^)(id sender))handlerBlock;

/**
 *  移除点击事件
 *
 *  @param controlEvents 点击事件类型
 */
- (void)removeControlEvents:(UIControlEvents)controlEvents;

@end
