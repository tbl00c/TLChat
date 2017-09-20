//
//  TLBaseKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/8/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatMacros.h"
#import "TLKeyboardDelegate.h"
#import "TLKeyboardProtocol.h"

@interface TLBaseKeyboard : UIView <TLKeyboardProtocol>

/// 是否正在展示
@property (nonatomic, assign, readonly) BOOL isShow;

/// 键盘事件回调
@property (nonatomic, weak) id<TLKeyboardDelegate> keyboardDelegate;

/**
 *  显示键盘(在keyWindow上)
 *
 *  @param animation 是否显示动画
 */
- (void)showWithAnimation:(BOOL)animation;

/**
 *  显示键盘
 *
 *  @param view      父view
 *  @param animation 是否显示动画
 */
- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

/**
 *  键盘消失
 *
 *  @param animation 是否显示消失动画
 */
- (void)dismissWithAnimation:(BOOL)animation;

/**
 *  重置键盘
 */
- (void)reset;

@end
