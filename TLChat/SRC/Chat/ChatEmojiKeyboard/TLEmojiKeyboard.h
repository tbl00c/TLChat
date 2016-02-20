//
//  TLEmojiKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLKeyboardDelegate.h"
#import "TLEmojiKeyboardDataSource.h"

@interface TLEmojiKeyboard : UIView

@property (nonatomic, assign) NSMutableArray *emojiGroupData;

@property (nonatomic, assign) id<TLKeyboardDelegate> keyboardDelegate;

@property (nonatomic, assign) id<TLEmojiKeyboardDataSource> dataSource;

+ (TLEmojiKeyboard *)keyboard;

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

- (void)dismissWithAnimation:(BOOL)animation;

- (void)reset;

@end
