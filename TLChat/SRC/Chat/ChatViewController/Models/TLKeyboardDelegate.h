//
//  TLKeyboardDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLKeyboardDelegate <NSObject>

@optional
- (void) chatKeyboardWillShow:(id)keyboard;

- (void) chatKeyboardDidShow:(id)keyboard;

- (void) chatKeyboardWillDismiss:(id)keyboard;

- (void) chatKeyboardDidDismiss:(id)keyboard;

- (void) chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height;

@end
