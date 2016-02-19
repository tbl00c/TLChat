//
//  TLChatMoreKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatKeyboardDelegate.h"
#import "TLChatMoreKeyboardItem.h"

@interface TLChatMoreKeyboard : UIView

@property (nonatomic, assign) id<TLChatKeyboardDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *chatMoreKeyboardData;

+ (TLChatMoreKeyboard *)keyboard;

- (void)reset;

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

- (void)dismissWithAnimation:(BOOL)animation;

@end
